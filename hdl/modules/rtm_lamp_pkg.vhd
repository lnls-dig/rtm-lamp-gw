------------------------------------------------------------------------------
-- Title      : RTM-LAMP components
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-11-26
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: RTM-LAMP components
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-11-26  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package rtm_lamp_pkg is
  type array_16b_word is array(natural range <>) of std_logic_vector(15 downto 0);

  -- Multiple SPI DAC interface
  component multi_dac_spi is
    generic(
      g_clk_freq:      natural := 100_000_000;
      g_sclk_freq:     natural := 50_000_000;
      g_num_dacs:      natural := 8;
      g_cpol:          boolean := false
      );
    port(
      clk_i:       in  std_logic;
      rst_n_i:     in  std_logic;
      start_i:     in  std_logic;
      ready_o:     out std_logic := '0';
      data_i:      in  array_16b_word(g_num_dacs-1 downto 0);
      dac_cs_o:    out std_logic;
      dac_sck_o:   out std_logic;
      dac_sdi_o:   out std_logic_vector(g_num_dacs-1 downto 0)
      );
  end component;

  component ltc232x_acq is
      generic(
    g_clk_freq:   natural := 100_000_000;
    g_sclk_freq:  natural := 50_000_000;
    g_bits:       natural := 16;
    g_channels:   natural := 8;
    g_data_lines: natural := 8;
    g_cnv_wait:   real := 450.0e-9
    );
  port(
    rst_n_i:    in  std_logic;
    clk_i:      in  std_logic;
    start_i:    in  std_logic;
    cnv_o:      out std_logic := '0';
    sck_o:      out std_logic := '0';
    sck_ret_i:  in  std_logic;
    ready_o:    out std_logic := '0';
    sdo1a_i:    in  std_logic;
    sdo2_i:     in  std_logic := '0';
    sdo3b_i:    in  std_logic := '0';
    sdo4_i:     in  std_logic := '0';
    sdo5c_i:    in  std_logic := '0';
    sdo6_i:     in  std_logic := '0';
    sdo7d_i:    in  std_logic := '0';
    sdo8_i:     in  std_logic := '0';
    ch1_o:      out std_logic_vector(g_bits-1 downto 0);
    ch2_o:      out std_logic_vector(g_bits-1 downto 0);
    ch3_o:      out std_logic_vector(g_bits-1 downto 0);
    ch4_o:      out std_logic_vector(g_bits-1 downto 0);
    ch5_o:      out std_logic_vector(g_bits-1 downto 0);
    ch6_o:      out std_logic_vector(g_bits-1 downto 0);
    ch7_o:      out std_logic_vector(g_bits-1 downto 0);
    ch8_o:      out std_logic_vector(g_bits-1 downto 0);
    valid_o:    out std_logic
    );
  end component;
end rtm_lamp_pkg;
