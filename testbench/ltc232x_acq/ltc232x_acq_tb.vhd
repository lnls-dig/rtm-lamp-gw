------------------------------------------------------------------------------
-- Title      : LTC232x serial interface testbench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-22
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Flexible serial interface for LTC232x ADCs testbench
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-10-27  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ltc232x_acq_tb is
  generic(
    g_bits: natural := 16
    );
  port(
    ch1_o:      out std_logic_vector(g_bits-1 downto 0);
    ch2_o:      out std_logic_vector(g_bits-1 downto 0);
    ch3_o:      out std_logic_vector(g_bits-1 downto 0);
    ch4_o:      out std_logic_vector(g_bits-1 downto 0);
    ch5_o:      out std_logic_vector(g_bits-1 downto 0);
    ch6_o:      out std_logic_vector(g_bits-1 downto 0);
    ch7_o:      out std_logic_vector(g_bits-1 downto 0);
    ch8_o:      out std_logic_vector(g_bits-1 downto 0)
    );
end ltc232x_acq_tb;

architecture ltc232x_acq_tb_arch of ltc232x_acq_tb is
  signal rst_n: std_logic := '0';
  signal clk: std_logic := '0';
  signal start: std_logic := '0';
  signal sck: std_logic := '0';
  signal sck_ret: std_logic;
  signal cnv: std_logic;
  signal sdoa: std_logic;
  signal sdob: std_logic;
  signal sdoc: std_logic;
  signal sdod: std_logic;
  signal analog_i: real_vector (1 to 8) :=
    (2.735, 2.048, 4.096, -1.024, -2.048, -4.096, 3.000, 2.0);
begin

  cmp_ltc2320: entity work.ltc232x_model
    generic map(
      g_ddr_mode => false
      )
    port map(
      cnv_n_i => cnv,
      clk_i => sck,
      clk_o => sck_ret,
      sdoa_o => sdoa,
      sdob_o => sdob,
      sdoc_o => sdoc,
      sdod_o => sdod,
      analog_i => analog_i
      );

  p_gen_200mhz_clk: process
  begin
    loop
      clk <= not clk;
      wait for 2.5 ns;
    end loop;
  end process;

  p_start_cnv: process
  begin
    wait for 10 ns;
    rst_n <= '1';
    wait for 10 ns;
    start <= '1';
    wait for 20 ns;
    start <= '0';
    wait for 1 us;
    std.env.finish;
  end process;

  ltc232x_acq_inst: entity work.ltc232x_acq
    generic map(
      g_clk_freq => 200_000_000,
      g_sclk_freq => 100_000_000,
      g_channels => 8,
      g_data_lines => 4
      )
    port map(
      rst_n_i => rst_n,
      start_i => start,
      cnv_o => cnv,
      clk_i => clk,
      sck_o => sck,
      sck_ret_i => sck_ret,
      sdo1a_i => sdoa,
      sdo3b_i => sdob,
      sdo5c_i => sdoc,
      sdo7d_i => sdod,
      ch1_o => ch1_o,
      ch2_o => ch2_o,
      ch3_o => ch3_o,
      ch4_o => ch4_o,
      ch5_o => ch5_o,
      ch6_o => ch6_o,
      ch7_o => ch7_o,
      ch8_o => ch8_o
      );

end ltc232x_acq_tb_arch;
