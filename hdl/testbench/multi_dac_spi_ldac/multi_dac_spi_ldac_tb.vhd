------------------------------------------------------------------------------
-- Title      : Multiple SPI DAC LDAC controller testbench
------------------------------------------------------------------------------
-- Author     : Lucas Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-03-02
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Test SPI output for 12 DACs sharing the CS and SCK signals
--              with LDAC
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2021-03-02  1.0      lucas.russo     Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

library work;
use work.rtm_lamp_pkg.all;

entity multi_dac_spi_ldac_tb is
end multi_dac_spi_ldac_tb;

architecture multi_dac_spi_ldac_tb_arch of multi_dac_spi_ldac_tb is
  -- Frequency in Hz, Period in s
  constant c_CLK_PERIOD : real := 10.0e-9;
  constant c_CLK_PERIOD_HALF : real := c_CLK_PERIOD/2.0;
  constant c_CLK_FREQ : natural := integer(floor(1.0/c_CLK_PERIOD));
  constant c_SCLK_PERIOD : real := 40.0e-9;
  constant c_SCLK_PERIOD_HALF : real := c_SCLK_PERIOD/2.0;
  constant c_SCLK_FREQ : natural := integer(floor(1.0/c_SCLK_PERIOD));
  constant c_CLK_SYNC_PERIOD : real := 14.42e-9;
  constant c_CLK_SYNC_PERIOD_HALF : real := c_CLK_SYNC_PERIOD/2.0;
  constant c_CLK_SYNC_FREQ : natural := integer(floor(1.0/c_CLK_SYNC_PERIOD));

  signal clk: std_logic := '0';
  signal rst_n: std_logic := '0';
  signal rst_sync_n: std_logic := '0';
  signal clk_sync: std_logic := '0';

  signal dac_data: t_16b_word_array(11 downto 0) := (x"AAAA", x"5555", x"F000", x"0001", others => x"DEAD");
  signal dac_start: std_logic := '0';

  signal ready: std_logic;
  signal done_pp : std_logic;
  signal dac_cs_n: std_logic;
  signal dac_ldac_n: std_logic;
  signal dac_sck: std_logic;
  signal dac_sdi: std_logic_vector(11 downto 0);
  signal ready_sync: std_logic;
  signal done_sync_pp : std_logic;
  signal dac_cs_sync_n: std_logic;
  signal dac_ldac_sync_n: std_logic;
  signal dac_sck_sync: std_logic;
  signal dac_sdi_sync: std_logic_vector(11 downto 0);

  procedure f_wait_until( signal net    : in std_logic;
                          repeat        : positive := 1;
                          condition     : std_logic := '1') is
  begin

    for i in 0 to repeat-1 loop
      wait until net = condition;
    end loop;

  end f_wait_until;
begin

  p_gen_200mhz_clk: process
  begin
    loop
      clk <= not clk;
      wait for c_CLK_PERIOD_HALF * 1.0e9 * 1 ns;
    end loop;
  end process;

  p_rst_n: process
  begin
    rst_n <= '0';
    f_wait_until(clk, 2);
    rst_n <= '1';
    wait;
  end process;

  p_gen_clk_sync: process
  begin
    loop
      clk_sync <= not clk_sync;
      wait for c_CLK_SYNC_PERIOD_HALF * 1.0e9 * 1 ns;
    end loop;
  end process;

  p_rst_sync_n: process
  begin
    rst_sync_n <= '0';
    f_wait_until(clk_sync, 2);
    rst_sync_n <= '1';
    wait;
  end process;

  p_drive_dac: process
  begin
    f_wait_until(rst_n, 1);
    f_wait_until(clk, 5);

    dac_start <= '1';
    f_wait_until(clk, 2);
    f_wait_until(clk, 200);
    dac_data <= (x"5555", x"AAAA", x"8000", x"0001", others => x"BEEF");
    f_wait_until(clk, 2);
    f_wait_until(clk, 2);
    f_wait_until(clk, 200);
    std.env.finish;
  end process;

  cmp_multi_dac: multi_dac_spi_ldac
    generic map(
      g_CLK_FREQ => c_CLK_FREQ,
      g_SCLK_FREQ => c_SCLK_FREQ,
      g_NUM_DACS => 12,
      g_CPOL => false,
      g_LDAC_WIDTH => 30.0e-9,
      g_LDAC_WAIT_AFTER_CS => 30.0e-9
    )
    port map(
      clk_i => clk,
      rst_n_i => rst_n,
      start_i => dac_start,
      data_i => dac_data,
      ready_o => ready,
      done_pp_o => done_pp,
      dac_cs_n_o => dac_cs_n,
      dac_ldac_n_o => dac_ldac_n,
      dac_sck_o => dac_sck,
      dac_sdi_o => dac_sdi
      );

  cmp_multi_dac_sync: multi_dac_spi_ldac
    generic map(
      g_CLK_FREQ => c_CLK_FREQ,
      g_SCLK_FREQ => c_SCLK_FREQ,
      g_REF_CLK_LDAC_FREQ => c_CLK_SYNC_FREQ,
      g_USE_REF_CLK_LDAC => true,
      g_NUM_DACS => 12,
      g_CPOL => false,
      g_LDAC_WIDTH => 30.0e-9,
      g_LDAC_WAIT_AFTER_CS => 30.0e-9
    )
    port map(
      clk_i => clk,
      rst_n_i => rst_n,
      clk_ref_ldac_i => clk_sync,
      rst_ref_ldac_n_i => rst_sync_n,
      start_i => dac_start,
      data_i => dac_data,
      ready_o => ready_sync,
      done_pp_o => done_sync_pp,
      dac_cs_n_o => dac_cs_sync_n,
      dac_ldac_n_o => dac_ldac_sync_n,
      dac_sck_o => dac_sck_sync,
      dac_sdi_o => dac_sdi_sync
      );

end multi_dac_spi_ldac_tb_arch;
