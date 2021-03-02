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
    -- Number of DACs to control
    g_NUM_DACS                               : natural := 8;
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
    -- DAC LDAC
    dac_ldac_n_o:  out std_logic;
    -- DAC data clock
    dac_sck_o:     out std_logic;
    -- Serial data outputs
    dac_sdi_o:     out std_logic_vector(g_NUM_DACS-1 downto 0)
    );
end multi_dac_spi_ldac;

architecture multi_dac_spi_ldac_arch of multi_dac_spi_ldac is

  constant c_LDAC_WAIT_CYCLES                : natural := integer(ceil(g_LDAC_WAIT_AFTER_CS * real(g_CLK_FREQ)));
  constant c_LDAC_WIDTH_CYCLES               : natural := integer(ceil(g_LDAC_WIDTH * real(g_CLK_FREQ)));

  type t_state is (IDLE, WAIT_AFTER_CS, DRIVE_LDAC);
  signal state                               : t_state := IDLE;

  signal done_pp                             : std_logic;
  signal ldac_n                              : std_logic;
  signal ldac_wait_counter                   : unsigned(f_log2_ceil(c_LDAC_WAIT_CYCLES)-1 downto 0);
  signal ldac_width_counter                  : unsigned(f_log2_ceil(c_LDAC_WIDTH_CYCLES)-1 downto 0);
begin

  cmp_multi_dac_spi : multi_dac_spi
    generic map(
      g_CLK_FREQ                             => g_CLK_FREQ,
      g_SCLK_FREQ                            => g_SCLK_FREQ,
      g_NUM_DACS                             => g_NUM_DACS,
      g_CPOL                                 => g_CPOL
    )
    port map(
      clk_i                                  => clk_i,
      rst_n_i                                => rst_n_i,

      start_i                                => start_i,
      data_i                                 => data_i,
      ready_o                                => ready_o,
      done_pp_o                              => done_pp,
      dac_cs_n_o                             => dac_cs_n_o,
      dac_sck_o                              => dac_sck_o,
      dac_sdi_o                              => dac_sdi_o
    );

  done_pp_o <= done_pp;

  ----------------------------------
  --         LDAC drive
  ----------------------------------

  p_drive_ldac : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state <= IDLE;
        ldac_n <= '1';
        ldac_wait_counter <= (others => '0');
        ldac_width_counter <= (others => '0');
      else

        case state is

          when IDLE =>
            if done_pp = '1' then
              ldac_wait_counter <= (others => '0');
              state <= WAIT_AFTER_CS;
            end if;

          when WAIT_AFTER_CS =>
            if ldac_wait_counter = to_unsigned(c_LDAC_WAIT_CYCLES, ldac_wait_counter'length) then
              ldac_n <= '0';
              ldac_width_counter <= (others => '0');
              state <= DRIVE_LDAC;
            else
              ldac_wait_counter <= ldac_wait_counter+1;
            end if;

          when DRIVE_LDAC =>
            if ldac_width_counter = to_unsigned(c_LDAC_WIDTH_CYCLES, ldac_width_counter'length) then
              ldac_n <= '1';
              state <= IDLE;
            else
              ldac_width_counter <= ldac_width_counter+1;
            end if;

        end case;

      end if;
    end if;
  end process;

  dac_ldac_n_o <= ldac_n;

end multi_dac_spi_ldac_arch;
