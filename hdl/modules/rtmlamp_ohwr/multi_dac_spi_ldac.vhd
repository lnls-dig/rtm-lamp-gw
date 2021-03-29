------------------------------------------------------------------------------
-- Title      : Multiple SPI DAC controller with LDAC driving
------------------------------------------------------------------------------
-- Author     : Lucas Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-13-02
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Wrapper to control LDAC line for Serial DACs.
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2021-13-02  1.0      lucas.russo     Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
-- RTM LAMP definitions
use work.rtm_lamp_pkg.all;
-- gc_posedge detector, log2
use work.gencores_pkg.all;

entity multi_dac_spi_ldac is
  generic (
    -- Core clock frequency [Hz], should be an integer multiple of
    -- g_SCLK_FREQ, at least double the frequency
    g_CLK_FREQ                               : natural := 100_000_000;
    -- DAC sck frequency [Hz]
    g_SCLK_FREQ                              : natural := 50_000_000;
    -- Reference clock frequency [Hz], used only when g_USE_REF_CLK_LDAC is
    -- set to true
    g_REF_CLK_LDAC_FREQ                      : natural := 50_000_000;
    -- Number of DACs to control
    g_NUM_DACS                               : natural := 8;
    -- Wether or not to use a reference clk to drive LDAC.
    -- If true uses clk_ref_ldac_i to drive LDAC
    -- If false uses clk_i to drive LDAC
    g_USE_REF_CLK_LDAC                       : boolean := false;
    -- Clock polarity.
    -- false - bit shifted on falling edge
    -- true - bit shifted on falling edge
    g_CPOL                                   : boolean := false;
    -- LDAC pulse width [ns]
    g_LDAC_WIDTH                             : real := 30.0e-9;
    -- LDAC wait period after CS deassertion [ns]
    g_LDAC_WAIT_AFTER_CS                     : real := 30.0e-9
  );
  port(
    -- Master system clock
    clk_i:         in  std_logic;
    -- Synchrnous reset (active low)
    rst_n_i:       in  std_logic;
    -- Optional reference clock to drive LDAC
    clk_ref_ldac_i: in  std_logic := '0';
    -- Optional reset_n to ref_ldac
    rst_ref_ldac_n_i: in  std_logic := '1';
    -- Start the transfer
    start_i:       in  std_logic;
    -- '0': there is an ongoing transfer
    -- '1': ready to start a new transfer
    ready_o:       out std_logic := '0';
    -- pulse when finished transferred
    done_pp_o:     out std_logic;
    -- data input
    data_i:        in  t_16b_word_array(g_NUM_DACS-1 downto 0);
    -- DAC chip select
    dac_cs_n_o:    out std_logic;
    -- DAC LDAC.
    -- Synched with clk_i if g_USE_REF_CLK_LDAC is false
    -- Synched with clk_ref_ldac_i if g_USE_REF_CLK_LDAC is true
    dac_ldac_n_o:  out std_logic;
    -- DAC data clock
    dac_sck_o:     out std_logic;
    -- Serial data outputs
    dac_sdi_o:     out std_logic_vector(g_NUM_DACS-1 downto 0)
    );
end multi_dac_spi_ldac;

architecture multi_dac_spi_ldac_arch of multi_dac_spi_ldac is

  function f_get_clk_freq( use_ref_clk_cnv : boolean ) return natural is
    variable v_clk_freq : natural;
  begin
    if use_ref_clk_cnv then
      v_clk_freq := g_REF_CLK_LDAC_FREQ;
    else
      v_clk_freq := g_CLK_FREQ;
    end if;

    return v_clk_freq;
  end f_get_clk_freq;

  constant c_LDAC_WAIT_CYCLES                : natural := integer(ceil(g_LDAC_WAIT_AFTER_CS * real(f_get_clk_freq(g_USE_REF_CLK_LDAC))));
  constant c_LDAC_WIDTH_CYCLES               : natural := integer(ceil(g_LDAC_WIDTH * real(f_get_clk_freq(g_USE_REF_CLK_LDAC))));
  constant c_NUM_CLKS                        : natural := 2;

  signal multi_aasd_arst                     : std_logic;
  signal multi_aasd_clks                     : std_logic_vector(c_NUM_CLKS-1 downto 0);
  signal multi_aasd_rst_n                    : std_logic_vector(c_NUM_CLKS-1 downto 0);
  signal rst_n                               : std_logic;
  signal rst_ref_ldac_n                      : std_logic;

  type t_state_ldac is (IDLE, WAIT_AFTER_CS, DRIVE_LDAC);
  signal state_ldac                          : t_state_ldac := IDLE;
  type t_state_ready is (IDLE, WAIT_FOR_START, WAIT_FOR_TRANS, WAIT_FOR_LDAC);
  signal state_ready                         : t_state_ready := IDLE;

  signal clk_fsm                             : std_logic;
  signal rst_fsm_n                           : std_logic;
  signal done_trans_pp                       : std_logic;
  signal done_trans_pp_ref_ldac              : std_logic := '0';
  signal done_trans_pp_fsm                   : std_logic;
  signal done_ldac_pp                        : std_logic;
  signal done_ldac_pp_ref_sys                : std_logic;
  signal start_trans                         : std_logic;
  signal ready                               : std_logic;
  signal ready_trans                         : std_logic;
  signal ldac_n                              : std_logic;
  signal ldac_wait_counter                   : integer range 0 to c_LDAC_WAIT_CYCLES := 0;
  signal ldac_width_counter                  : integer range 0 to c_LDAC_WIDTH_CYCLES := 0;
begin

  cmp_multi_aasd_reset : gc_reset_multi_aasd
  generic map (
    g_CLOCKS                                 => c_NUM_CLKS,
    g_RST_LEN                                => 16
  )
  port map (
    arst_i                                   => multi_aasd_arst,
    clks_i                                   => multi_aasd_clks,
    rst_n_o                                  => multi_aasd_rst_n
  );

  multi_aasd_arst    <= not (rst_n_i and rst_ref_ldac_n_i);
  multi_aasd_clks(0) <= clk_i;
  multi_aasd_clks(1) <= clk_ref_ldac_i;
  rst_n              <= multi_aasd_rst_n(0);
  rst_ref_ldac_n     <= multi_aasd_rst_n(1);

  ------------------------------------------
  --         DAC transfer
  ------------------------------------------

  start_trans <= start_i and ready;

  cmp_multi_dac_spi : multi_dac_spi
    generic map(
      g_CLK_FREQ                             => g_CLK_FREQ,
      g_SCLK_FREQ                            => g_SCLK_FREQ,
      g_NUM_DACS                             => g_NUM_DACS,
      g_CPOL                                 => g_CPOL
    )
    port map(
      clk_i                                  => clk_i,
      rst_n_i                                => rst_n,
      start_i                                => start_trans,
      ready_o                                => ready_trans,
      data_i                                 => data_i,
      done_pp_o                              => done_trans_pp,
      dac_cs_n_o                             => dac_cs_n_o,
      dac_sck_o                              => dac_sck_o,
      dac_sdi_o                              => dac_sdi_o
    );

  ------------------------------------------
  --         Reference clock and DONE for LDAC
  ------------------------------------------
  gen_ref_clk_done_trans_pp : if (g_USE_REF_CLK_LDAC) generate

    clk_fsm <= clk_ref_ldac_i;
    rst_fsm_n <= rst_ref_ldac_n;

    cmp_done_ldac_gc_pulse_synchronizer2 : gc_pulse_synchronizer2
    port map (
      clk_in_i                               => clk_i,
      rst_in_n_i                             => rst_n,
      clk_out_i                              => clk_fsm,
      rst_out_n_i                            => rst_fsm_n,
      -- pulse input (clk_in_i domain)
      d_p_i                                  => done_trans_pp,
      -- pulse output (clk_out_i domain)
      q_p_o                                  => done_trans_pp_ref_ldac
    );

    done_trans_pp_fsm <= done_trans_pp_ref_ldac;

  end generate;

  gen_sys_clk_done_trans_pp : if (not g_USE_REF_CLK_LDAC) generate

    clk_fsm <= clk_i;
    rst_fsm_n <= rst_n;
    done_trans_pp_fsm <= done_trans_pp;

  end generate;

  ----------------------------------
  --         LDAC drive
  ----------------------------------

  p_drive_ldac : process(clk_fsm)
  begin
    if rising_edge(clk_fsm) then
      if rst_fsm_n = '0' then
        state_ldac <= IDLE;
        ldac_n <= '1';
        ldac_wait_counter <= 0;
        ldac_width_counter <= 0;
        done_ldac_pp <= '0';
      else
        -- done_ldac_pp signal is only asserted for 1 clock cycle
        done_ldac_pp <= '0';

        case state_ldac is

          when IDLE =>

            if done_trans_pp_fsm = '1' then
              ldac_wait_counter <= 0;
              state_ldac <= WAIT_AFTER_CS;
            end if;

          when WAIT_AFTER_CS =>
            if ldac_wait_counter = c_LDAC_WAIT_CYCLES-1 then
              ldac_n <= '0';
              ldac_width_counter <= 0;
              state_ldac <= DRIVE_LDAC;
            else
              ldac_wait_counter <= ldac_wait_counter+1;
            end if;

          when DRIVE_LDAC =>
            if ldac_width_counter = c_LDAC_WIDTH_CYCLES-1 then
              ldac_n <= '1';
              state_ldac <= IDLE;
              done_ldac_pp <= '1';
            else
              ldac_width_counter <= ldac_width_counter+1;
            end if;

        end case;

      end if;
    end if;
  end process;

  dac_ldac_n_o <= ldac_n;

  gen_ref_clk_done_ldac : if (g_USE_REF_CLK_LDAC) generate

    cmp_done_trans_gc_pulse_synchronizer2 : gc_pulse_synchronizer2
    port map (
      clk_in_i                               => clk_ref_ldac_i,
      rst_in_n_i                             => rst_ref_ldac_n,
      clk_out_i                              => clk_i,
      rst_out_n_i                            => rst_n,
      -- pulse input (clk_in_i domain)
      d_p_i                                  => done_ldac_pp,
      -- pulse output (clk_out_i domain)
      q_p_o                                  => done_ldac_pp_ref_sys
    );

  end generate;

  gen_sys_clk_done_ldac : if (not g_USE_REF_CLK_LDAC) generate

    done_ldac_pp_ref_sys <= done_ldac_pp;

  end generate;

  done_pp_o <= done_ldac_pp_ref_sys;

  ----------------------------------
  --         Ready drive
  ----------------------------------
  p_drive_ready : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n = '0' then
        state_ready <= IDLE;
        ready <= '0';
      else

        case state_ready is
          when IDLE =>
            -- wait for ready_trans
            if ready_trans = '1' then
              ready <= '1';
              state_ready <= WAIT_FOR_START;
            end if;

          when WAIT_FOR_START =>
            if start_trans = '1' then
              ready <= '0';
              state_ready <= WAIT_FOR_TRANS;
            end if;

          when WAIT_FOR_TRANS =>
            if done_trans_pp = '1' then
              state_ready <= WAIT_FOR_LDAC;
            end if;

          when WAIT_FOR_LDAC =>
            if done_ldac_pp_ref_sys = '1' then
              state_ready <= IDLE;
            end if;

        end case;

      end if;
    end if;
  end process;

  ready_o <= ready;

end multi_dac_spi_ldac_arch;
