------------------------------------------------------------------------------
-- Title      : LTC232x acquisition module
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-22
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Flexible acquisition module for LTC232x ADCs
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-10-22  1.0      augusto.fraga   Created
-- 2021-03-03  1.1      lucas.russo     Split conv/readout funcionality in 2 modules
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

library work;
-- RTM LAMP definitions
use work.rtm_lamp_pkg.all;
-- gc_sync_ffs, gc_pulse_synchronizer2
use work.gencores_pkg.all;

entity ltc232x_acq is
  generic(
    -- System clock frequency [Hz]
    g_SYS_CLOCK_FREQ                         : natural := 100_000_000;
    -- Core clock frequency [Hz], should be an integer multiple of
    -- g_SCLK_FREQ, at 4x the frequency ADC sck frequency [Hz]
    g_CLK_FAST_SPI_FREQ                      : natural := 400_000_000;
    g_SCLK_FREQ                              : natural := 100_000_000;
    -- Reference clock frequency [Hz], used only when g_USE_REF_CLK_CNV is
    -- set to true
    g_REF_CLK_CNV_FREQ                       : natural := 50_000_000;
    -- Wether or not to use a reference clk to drive CNV.
    -- If true uses clk_ref_cnv_i to drive CNV
    -- If false uses clk_i to drive CNV
    g_USE_REF_CLK_CNV                        : boolean := false;
    -- Sample bit size
    g_BITS                                   : natural := 16;
    -- Number of channels
    g_CHANNELS                               : natural := 8;
    -- Number of data lines
    g_DATA_LINES                             : natural := 8;
    -- Conversion wait time
    g_CNV_HIGH                               : real    := 30.0e-9;
    -- Conversion wait time
    g_CNV_WAIT                               : real    := 450.0e-9
    );
  port(
    -- Reset fast SPI clock
    rst_fast_spi_n_i                         : in  std_logic;
    -- Fast SPI clock
    clk_fast_spi_i                           : in  std_logic;
    -- Reset
    rst_n_i                                  : in  std_logic;
    -- Core clock
    clk_i                                    : in  std_logic;
    -- Optional reset_n to ref_cnv
    rst_ref_cnv_n_i                          : in  std_logic := '1';
    -- Optional reference clock to drive CNV
    clk_ref_cnv_i                            : in  std_logic := '0';
    -- Start the conversion
    start_i                                  : in  std_logic;
    -- Synched with clk_i if g_USE_REF_CLK_CNV is false
    -- Synched with clk_ref_cnv_i if g_USE_REF_CLK_CNV is true
    -- Drives the CNV signal
    cnv_o                                    : out std_logic := '0';
    -- ADC input clock
    sck_o                                    : out std_logic := '0';
    -- ADC return clock
    sck_ret_i                                : in  std_logic;
    -- '0': ongoing conversion
    -- '1': ready to start conversion
    ready_o                                  : out std_logic := '0';
    -- pulse when finished acquisition
    done_pp_o                                : out std_logic;
    -- pulse when finished CNV drive
    done_cnv_pp_ref_sys_o                    : out std_logic;
    -- ADC output SDO1/SDOA
    sdo1a_i                                  : in  std_logic;
    -- ADC output SDO2
    sdo2_i                                   : in  std_logic := '0';
    -- ADC output SDO3/SDOB
    sdo3b_i                                  : in  std_logic := '0';
    -- ADC output SDO4
    sdo4_i                                   : in  std_logic := '0';
    -- ADC output SDO5/SDOC
    sdo5c_i                                  : in  std_logic := '0';
    -- ADC output SDO6
    sdo6_i                                   : in  std_logic := '0';
    -- ADC output SDO7/SDOD
    sdo7d_i                                  : in  std_logic := '0';
    -- ADC output SDO8
    sdo8_i                                   : in  std_logic := '0';
    -- CH1 parallel output
    ch1_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH2 parallel output
    ch2_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH3 parallel output
    ch3_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH4 parallel output
    ch4_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH5 parallel output
    ch5_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH6 parallel output
    ch6_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH7 parallel output
    ch7_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH8 parallel output
    ch8_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- data valid output
    valid_o                                  : out std_logic
    );
end ltc232x_acq;

architecture ltc232x_acq_arch of ltc232x_acq is

  function f_get_clk_freq( use_ref_clk_cnv : boolean ) return natural is
    variable v_clk_freq : natural;
  begin
    if use_ref_clk_cnv then
      v_clk_freq := g_REF_CLK_CNV_FREQ;
    else
      v_clk_freq := g_SYS_CLOCK_FREQ;
    end if;

    return v_clk_freq;
  end f_get_clk_freq;

  constant c_WAIT_CONV_CYCLES                : natural := integer(ceil(g_CNV_WAIT * real(f_get_clk_freq(g_USE_REF_CLK_CNV))));
  constant c_CONV_HIGH_CYCLES                : natural := integer(ceil(g_CNV_HIGH * real(f_get_clk_freq(g_USE_REF_CLK_CNV))));
  constant c_NUM_CLKS                        : natural := 3;

  signal multi_aasd_arst                     : std_logic;
  signal multi_aasd_clks                     : std_logic_vector(c_NUM_CLKS-1 downto 0);
  signal multi_aasd_rst_n                    : std_logic_vector(c_NUM_CLKS-1 downto 0);
  signal rst_n                               : std_logic;
  signal rst_ref_cnv_n                       : std_logic;
  signal rst_fast_spi_n                      : std_logic;

  type t_state_conv is (IDLE, CONV_HIGH, WAIT_CONV);
  signal state_conv                               : t_state_conv := IDLE;
  type t_state_ready is (IDLE, WAIT_FOR_START, WAIT_FOR_CONV, WAIT_FOR_READOUT);
  signal state_ready                         : t_state_ready := IDLE;

  signal clk_fsm                             : std_logic;
  signal rst_fsm_n                           : std_logic;
  signal start_ref_cnv                       : std_logic;
  signal done_cnv_pp                         : std_logic;
  signal done_cnv_pp_ref_fast                : std_logic := '0';
  signal done_cnv_pp_ref_sys                 : std_logic := '0';
  signal start_cnv                           : std_logic := '0';
  signal ready_cnv                           : std_logic;
  signal ready                               : std_logic;
  signal ready_cnv_ref_sys                   : std_logic;
  signal done_readout_pp_ref_sys             : std_logic;
  signal done_readout_pp_ref_fast            : std_logic;
  signal ready_readout_ref_sys               : std_logic;
  signal ready_readout_ref_fast              : std_logic;
  signal wait_counter                        : integer range 0 to c_WAIT_CONV_CYCLES := 0;

  signal cnv                                 : std_logic;
  signal sck                                 : std_logic;
  signal sck_ret                             : std_logic;

  signal cdc_fifo_data_in                    : std_logic_vector(8*g_BITS-1 downto 0);
  signal cdc_fifo_valid_in                   : std_logic;
  signal cdc_fifo_data_out                   : std_logic_vector(8*g_BITS-1 downto 0);
  signal cdc_fifo_valid_out                  : std_logic;

  signal ch1                                 : std_logic_vector(g_BITS-1 downto 0);
  signal ch2                                 : std_logic_vector(g_BITS-1 downto 0);
  signal ch3                                 : std_logic_vector(g_BITS-1 downto 0);
  signal ch4                                 : std_logic_vector(g_BITS-1 downto 0);
  signal ch5                                 : std_logic_vector(g_BITS-1 downto 0);
  signal ch6                                 : std_logic_vector(g_BITS-1 downto 0);
  signal ch7                                 : std_logic_vector(g_BITS-1 downto 0);
  signal ch8                                 : std_logic_vector(g_BITS-1 downto 0);
  signal valid                               : std_logic;

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

  multi_aasd_arst    <= not (rst_n_i and rst_ref_cnv_n_i and rst_fast_spi_n_i);
  multi_aasd_clks(0) <= clk_i;
  multi_aasd_clks(1) <= clk_ref_cnv_i;
  multi_aasd_clks(2) <= clk_fast_spi_i;
  rst_n              <= multi_aasd_rst_n(0);
  rst_ref_cnv_n      <= multi_aasd_rst_n(1);
  rst_fast_spi_n     <= multi_aasd_rst_n(2);

  -------------------------------------------
  --         Reference clock and CNV start
  -------------------------------------------

  start_cnv <= start_i and ready;

  gen_ref_clk_cnv : if (g_USE_REF_CLK_CNV) generate

    clk_fsm <= clk_ref_cnv_i;
    rst_fsm_n <= rst_ref_cnv_n;

    cmp_start_gc_pulse_synchronizer2 : gc_pulse_synchronizer2
    port map (
      clk_in_i                               => clk_i,
      rst_in_n_i                             => rst_n,
      clk_out_i                              => clk_fsm,
      rst_out_n_i                            => rst_fsm_n,
      d_p_i                                  => start_cnv,
      q_p_o                                  => start_ref_cnv
    );

  end generate;

  gen_sys_clk_cnv : if (not g_USE_REF_CLK_CNV) generate

    clk_fsm <= clk_i;
    rst_fsm_n <= rst_n;

    start_ref_cnv <= start_cnv;

  end generate;

  p_cnv_ltc232x: process(clk_fsm)
  begin
    if rising_edge(clk_fsm) then
      if rst_fsm_n = '0' then               -- Reset the state_conv machine
        state_conv <= IDLE;
        wait_counter <= 0;
        cnv <= '0';
        done_cnv_pp <= '0';
        -- if we are in reset state we can't be ready
        ready_cnv <= '0';
      else
        -- done_pp signal is only asserted for 1 clock cycle
        done_cnv_pp <= '0';

        -- The FSM has 3 states:
        --
        -- IDLE:
        --   Wait for a high level in start_ref_cnv;
        --
        -- CONV_HIGH:
        --   Hold the CNV signal high for 30ns minimum to start the
        --   conversion;
        --
        -- WAIT_CONV:
        --   Wait for the conversion to finish, conversion time is set
        --   by g_CNV_WAIT;
       --
        -- WAIT_READOUT:
        --   Wait for the readout to finish, readout set by done_readout;
        case state_conv is
          when IDLE =>
            ready_cnv <= '1';

            if start_ref_cnv = '1' then
              cnv <= '1';
              state_conv <= CONV_HIGH;
              ready_cnv <= '0';
            end if;

          when CONV_HIGH =>
            if wait_counter = c_CONV_HIGH_CYCLES-1 then
              wait_counter <= 0;
              cnv <= '0';
              state_conv <= WAIT_CONV;
            else
              wait_counter <= wait_counter + 1;
            end if;

          when WAIT_CONV =>
            if wait_counter = c_WAIT_CONV_CYCLES-1 then
              wait_counter <= 0;
              state_conv <= IDLE;
              ready_cnv <= '1';
              done_cnv_pp <= '1';
            else
              wait_counter <= wait_counter + 1;
            end if;

        end case;
      end if;
    end if;
  end process;

  cnv_o <= cnv;

  gen_ref_clk_ready_cnv : if (g_USE_REF_CLK_CNV) generate

    cmp_gc_sync_ffs : gc_sync
    port map (
      clk_i                                    => clk_i,
      rst_n_a_i                                => rst_n,
      d_i                                      => ready_cnv,
      q_o                                      => ready_cnv_ref_sys
    );

  end generate;

  gen_sys_clk_ready_cnv : if (not g_USE_REF_CLK_CNV) generate

    ready_cnv_ref_sys <= ready_cnv;

  end generate;

  -------------------------------------------
  --         Done conversion pulse signal synch
  -------------------------------------------
  gen_ref_clk_done_cnv : if (g_USE_REF_CLK_CNV) generate

    cmp_done_gc_sys_pulse_synchronizer2 : gc_pulse_synchronizer2
    port map (
      clk_in_i                               => clk_fsm,
      rst_in_n_i                             => rst_fsm_n,
      clk_out_i                              => clk_i,
      rst_out_n_i                            => rst_n,
      d_p_i                                  => done_cnv_pp,
      q_p_o                                  => done_cnv_pp_ref_sys
    );
  end generate;

  gen_sys_clk_done_cnv : if (not g_USE_REF_CLK_CNV) generate

    done_cnv_pp_ref_sys <= done_cnv_pp;

  end generate;

done_cnv_pp_ref_sys_o <= done_cnv_pp_ref_sys;

  cmp_done_gc_pulse_synchronizer2 : gc_pulse_synchronizer2
  port map (
    clk_in_i                               => clk_fsm,
    rst_in_n_i                             => rst_fsm_n,
    clk_out_i                              => clk_fast_spi_i,
    rst_out_n_i                            => rst_fast_spi_n,
    d_p_i                                  => done_cnv_pp,
    q_p_o                                  => done_cnv_pp_ref_fast
  );

  -------------------------------------------
  --         ADC readout
  -------------------------------------------
  cmp_ltc232x_readout : ltc232x_readout
    generic map (
      g_CLK_FAST_SPI_FREQ                    => g_CLK_FAST_SPI_FREQ,
      g_SCLK_FREQ                            => g_SCLK_FREQ,
      g_BITS                                 => g_BITS,
      g_CHANNELS                             => g_CHANNELS,
      g_DATA_LINES                           => g_DATA_LINES
    )
    port map (
      rst_fast_spi_n_i                       => rst_fast_spi_n,
      clk_fast_spi_i                         => clk_fast_spi_i,
      start_i                                => done_cnv_pp_ref_fast,
      sck_o                                  => sck,
      sck_ret_i                              => sck_ret,
      ready_o                                => ready_readout_ref_fast,
      done_pp_o                              => done_readout_pp_ref_fast,
      sdo1a_i                                => sdo1a_i,
      sdo2_i                                 => sdo2_i,
      sdo3b_i                                => sdo3b_i,
      sdo4_i                                 => sdo4_i,
      sdo5c_i                                => sdo5c_i,
      sdo6_i                                 => sdo6_i,
      sdo7d_i                                => sdo7d_i,
      sdo8_i                                 => sdo8_i,
      ch1_o                                  => ch1,
      ch2_o                                  => ch2,
      ch3_o                                  => ch3,
      ch4_o                                  => ch4,
      ch5_o                                  => ch5,
      ch6_o                                  => ch6,
      ch7_o                                  => ch7,
      ch8_o                                  => ch8,
      valid_o                                => valid
    );

  sck_o <= sck;
  sck_ret <= sck_ret_i;

  cmp_gc_sync_ffs : gc_sync
  port map (
    clk_i                                    => clk_fast_spi_i,
    rst_n_a_i                                => rst_fast_spi_n,
    d_i                                      => ready_readout_ref_fast,
    q_o                                      => ready_readout_ref_sys
  );

  -----------------------------------------------------------
  --         CDC from FAST SPI domain to CLK_SYS
  -----------------------------------------------------------

  cdc_fifo_data_in(8*g_BITS-1 downto 7*g_BITS) <= ch8;
  cdc_fifo_data_in(7*g_BITS-1 downto 6*g_BITS) <= ch7;
  cdc_fifo_data_in(6*g_BITS-1 downto 5*g_BITS) <= ch6;
  cdc_fifo_data_in(5*g_BITS-1 downto 4*g_BITS) <= ch5;
  cdc_fifo_data_in(4*g_BITS-1 downto 3*g_BITS) <= ch4;
  cdc_fifo_data_in(3*g_BITS-1 downto 2*g_BITS) <= ch3;
  cdc_fifo_data_in(2*g_BITS-1 downto   g_BITS) <= ch2;
  cdc_fifo_data_in(  g_BITS-1 downto        0) <= ch1;
  cdc_fifo_valid_in <= valid;

  cmp_ltc232x_cdc_fifo : ltc232x_cdc_fifo
  generic map
  (
    g_data_width                              => 8*g_BITS,
    g_size                                    => 4
  )
  port map
  (
    clk_wr_i                                  => clk_fast_spi_i,
    data_i                                    => cdc_fifo_data_in,
    valid_i                                   => cdc_fifo_valid_in,

    clk_rd_i                                  => clk_i,
    data_o                                    => cdc_fifo_data_out,
    valid_o                                   => cdc_fifo_valid_out
  );

  -- output assingments
  ch8_o     <= cdc_fifo_data_out(8*g_BITS-1 downto 7*g_BITS);
  ch7_o     <= cdc_fifo_data_out(7*g_BITS-1 downto 6*g_BITS);
  ch6_o     <= cdc_fifo_data_out(6*g_BITS-1 downto 5*g_BITS);
  ch5_o     <= cdc_fifo_data_out(5*g_BITS-1 downto 4*g_BITS);
  ch4_o     <= cdc_fifo_data_out(4*g_BITS-1 downto 3*g_BITS);
  ch3_o     <= cdc_fifo_data_out(3*g_BITS-1 downto 2*g_BITS);
  ch2_o     <= cdc_fifo_data_out(2*g_BITS-1 downto   g_BITS);
  ch1_o     <= cdc_fifo_data_out(  g_BITS-1 downto        0);
  valid_o   <= cdc_fifo_valid_out;

  cmp_done_readout_pulse_synchronizer2 : gc_pulse_synchronizer2
  port map (
    clk_in_i                               => clk_fast_spi_i,
    rst_in_n_i                             => rst_fast_spi_n,
    clk_out_i                              => clk_i,
    rst_out_n_i                            => rst_n,
    d_p_i                                  => done_readout_pp_ref_fast,
    q_p_o                                  => done_readout_pp_ref_sys
  );

  done_pp_o <= done_readout_pp_ref_sys;

  ----------------------------------------
  --         Drive ready logic
  ----------------------------------------
  p_drive_ready : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n = '0' then
        state_ready <= IDLE;
        ready <= '0';
      else

        case state_ready is
          when IDLE =>
            -- wait for ready_cnv
            if ready_cnv_ref_sys = '1' and
              ready_readout_ref_sys = '1' then
              ready <= '1';
              state_ready <= WAIT_FOR_START;
            end if;

          when WAIT_FOR_START =>
            if start_cnv = '1' then
              ready <= '0';
              state_ready <= WAIT_FOR_CONV;
            end if;

          when WAIT_FOR_CONV =>
            if done_cnv_pp_ref_sys = '1' then
              state_ready <= WAIT_FOR_READOUT;
            end if;

          when WAIT_FOR_READOUT =>
            if done_readout_pp_ref_sys = '1' then
              state_ready <= IDLE;
            end if;

        end case;

      end if;
    end if;
  end process;

  ready_o <= ready;

end ltc232x_acq_arch;
