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
use ieee.math_real.all;

library work;
use work.rtm_lamp_pkg.all;

entity ltc232x_acq_tb is
  generic(
    g_BITS: natural := 16
    );
  port(
    ch1_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch2_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch3_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch4_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch5_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch6_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch7_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch8_o:      out std_logic_vector(g_BITS-1 downto 0);

    ch1_sync_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch2_sync_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch3_sync_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch4_sync_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch5_sync_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch6_sync_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch7_sync_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch8_sync_o:      out std_logic_vector(g_BITS-1 downto 0)
    );
end ltc232x_acq_tb;

architecture ltc232x_acq_tb_arch of ltc232x_acq_tb is
  -- Frequency in Hz, Period in s
  constant c_CLK_PERIOD : real := 5.0e-9;
  constant c_CLK_PERIOD_HALF : real := c_CLK_PERIOD/2.0;
  constant c_CLK_FREQ : natural := integer(floor(1.0/c_CLK_PERIOD));
  constant c_SCLK_PERIOD : real := 10.0e-9;
  constant c_SCLK_PERIOD_HALF : real := c_SCLK_PERIOD/2.0;
  constant c_SCLK_FREQ : natural := integer(floor(1.0/c_SCLK_PERIOD));
  constant c_CLK_SYNC_PERIOD : real := 14.42e-9;
  constant c_CLK_SYNC_PERIOD_HALF : real := c_CLK_SYNC_PERIOD/2.0;
  constant c_CLK_SYNC_FREQ : natural := integer(floor(1.0/c_CLK_SYNC_PERIOD));

  signal rst_n: std_logic := '0';
  signal clk: std_logic := '0';
  signal rst_sync_n: std_logic := '0';
  signal clk_sync: std_logic := '0';

  signal start: std_logic := '0';
  signal sck: std_logic := '0';
  signal sck_ret: std_logic;
  signal cnv: std_logic;
  signal sdoa: std_logic;
  signal sdob: std_logic;
  signal sdoc: std_logic;
  signal sdod: std_logic;
  signal sck_sync: std_logic := '0';
  signal sck_ret_sync: std_logic;
  signal cnv_sync: std_logic;
  signal sdoa_sync: std_logic;
  signal sdob_sync: std_logic;
  signal sdoc_sync: std_logic;
  signal sdod_sync: std_logic;

  signal analog_i: real_vector (1 to 8) :=
    (2.735, 2.048, 4.096, -1.024, -2.048, -4.096, 3.000, 2.0);

  procedure f_wait_until( signal net    : in std_logic;
                          repeat        : positive := 1;
                          condition     : std_logic := '1') is
  begin

    for i in 0 to repeat-1 loop
      wait until net = condition;
    end loop;

  end f_wait_until;
begin

  cmp_ltc2320: entity work.ltc232x_model
    generic map(
      g_DDR_MODE => false
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

  cmp_clk_sync_ltc2320: entity work.ltc232x_model
    generic map(
      g_DDR_MODE => false
      )
    port map(
      cnv_n_i => cnv_sync,
      clk_i => sck_sync,
      clk_o => sck_ret_sync,
      sdoa_o => sdoa_sync,
      sdob_o => sdob_sync,
      sdoc_o => sdoc_sync,
      sdod_o => sdod_sync,
      analog_i => analog_i
      );

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

  p_start_cnv: process
  begin
    f_wait_until(rst_n, 1);
    f_wait_until(clk, 5);

    start <= '1';
    f_wait_until(clk, 2);
    start <= '0';
    f_wait_until(clk, 200);
    start <= '1';
    f_wait_until(clk, 2);
    start <= '0';
    f_wait_until(clk, 200);
    std.env.finish;
  end process;

  cmp_ltc232x_acq: ltc232x_acq
    generic map(
      g_CLK_FREQ => c_CLK_FREQ,
      g_SCLK_FREQ => c_SCLK_FREQ,
      g_CHANNELS => 8,
      g_DATA_LINES => 4
      )
    port map(
      rst_n_i => rst_n,
      clk_i => clk,
      start_i => start,
      cnv_o => cnv,
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

  cmp_ltc232x_sync_acq: ltc232x_acq
    generic map(
      g_CLK_FREQ => c_CLK_FREQ,
      g_SCLK_FREQ => c_SCLK_FREQ,
      g_REF_CLK_CNV_FREQ => c_CLK_SYNC_FREQ,
      g_USE_REF_CLK_CNV => true,
      g_CHANNELS => 8,
      g_DATA_LINES => 4
      )
    port map(
      rst_n_i => rst_n,
      clk_i => clk,
      rst_ref_cnv_n_i => rst_sync_n,
      clk_ref_cnv_i   => clk_sync,
      start_i => start,
      cnv_o => cnv_sync,
      sck_o => sck_sync,
      sck_ret_i => sck_ret_sync,
      sdo1a_i => sdoa_sync,
      sdo3b_i => sdob_sync,
      sdo5c_i => sdoc_sync,
      sdo7d_i => sdod_sync,
      ch1_o => ch1_sync_o,
      ch2_o => ch2_sync_o,
      ch3_o => ch3_sync_o,
      ch4_o => ch4_sync_o,
      ch5_o => ch5_sync_o,
      ch6_o => ch6_sync_o,
      ch7_o => ch7_sync_o,
      ch8_o => ch8_sync_o
      );

end ltc232x_acq_tb_arch;
