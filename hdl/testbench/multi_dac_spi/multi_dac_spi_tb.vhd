------------------------------------------------------------------------------
-- Title      : Multiple SPI DAC controller testbench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-11-13
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Test SPI output for 12 DACs sharing the CS and SCK signals
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-11-13  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.rtm_lamp_pkg.all;

entity multi_dac_spi_tb is
end multi_dac_spi_tb;

architecture multi_dac_spi_tb_arch of multi_dac_spi_tb is
  signal dac_data: t_16b_word_array(11 downto 0) := (x"AAAA", x"5555", x"F000", x"0001", others => x"DEAD");
  signal clk_200mhz: std_logic := '0';
  signal rst_n: std_logic := '0';
  signal ready: std_logic;
  signal dac_cs: std_logic;
  signal dac_sck: std_logic;
  signal dac_sdi: std_logic_vector(11 downto 0);
  signal dac_start: std_logic := '0';
begin

  p_gen_200mhz_clk: process
  begin
    loop
      wait for 2.5 ns;
      clk_200mhz <= not clk_200mhz;
    end loop;
  end process;

  cmp_multi_dac: multi_dac_spi
    generic map(
      g_CLK_FREQ => 200_000_000,
      g_SCLK_FREQ => 25_000_000,
      g_NUM_DACS => 12,
      g_CPOL => false
      )
    port map(
      clk_i => clk_200mhz,
      rst_n_i => rst_n,
      start_i => dac_start,
      data_i => dac_data,
      ready_o => ready,
      dac_cs_o => dac_cs,
      dac_sck_o => dac_sck,
      dac_sdi_o => dac_sdi
      );

  p_drive_dac: process
  begin
    wait for 20 ns;
    rst_n <= '1';
    wait for 20 ns;
    dac_start <= '1';
    wait for 20 ns;
    dac_start <= '0';
    wait for 1 us;
    dac_data <= (x"5555", x"AAAA", x"8000", x"0001", others => x"BEEF");
    wait for 20 ns;
    dac_start <= '1';
    wait for 20 ns;
    dac_start <= '0';
    wait for 1 us;
    std.env.finish;
  end process;
end multi_dac_spi_tb_arch;
