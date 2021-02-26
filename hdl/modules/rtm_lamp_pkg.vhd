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
  subtype t_16b_word is std_logic_vector(15 downto 0);
  type t_16b_word_array is array(natural range <>) of t_16b_word;

  -- Multiple SPI DAC interface
  component multi_dac_spi is
    generic(
      g_CLK_FREQ:      natural := 100_000_000;
      g_SCLK_FREQ:     natural := 50_000_000;
      g_NUM_DACS:      natural := 8;
      g_CPOL:          boolean := false
      );
    port(
      clk_i:       in  std_logic;
      rst_n_i:     in  std_logic;
      start_i:     in  std_logic;
      ready_o:     out std_logic := '0';
      data_i:      in  t_16b_word_array(g_NUM_DACS-1 downto 0);
      dac_cs_o:    out std_logic;
      dac_sck_o:   out std_logic;
      dac_sdi_o:   out std_logic_vector(g_NUM_DACS-1 downto 0)
      );
  end component;

  component ltc232x_acq is
  generic(
    g_CLK_FREQ:   natural := 100_000_000;
    g_SCLK_FREQ:  natural := 50_000_000;
    g_BITS:       natural := 16;
    g_CHANNELS:   natural := 8;
    g_DATA_LINES: natural := 8;
    g_CNV_WAIT:   real := 450.0e-9
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
    ch1_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch2_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch3_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch4_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch5_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch6_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch7_o:      out std_logic_vector(g_BITS-1 downto 0);
    ch8_o:      out std_logic_vector(g_BITS-1 downto 0);
    valid_o:    out std_logic
    );
  end component;

  component rtmlamp_ohwr_serial_regs is
  generic (
    g_CHANNELS        : natural := 12;
    g_CLOCK_FREQ      : natural := 100000000;
    g_SCLK_FREQ       : natural := 100000
  );
  port (
    clk_i                 : in std_logic;
    rst_n_i               : in std_logic;
    amp_sta_ctl_rw_i      : in std_logic := '1';
    amp_status_reg_clk_o  : out std_logic;
    amp_status_reg_out_i  : in std_logic;
    amp_status_reg_pl_o   : out std_logic;
    amp_ctl_reg_oe_n_o    : out std_logic;
    amp_ctl_reg_din_o     : out std_logic;
    amp_ctl_reg_str_o     : out std_logic;
    amp_iflag_l_o         : out std_logic_vector(g_CHANNELS-1 downto 0);
    amp_tflag_l_o         : out std_logic_vector(g_CHANNELS-1 downto 0);
    amp_iflag_r_o         : out std_logic_vector(g_CHANNELS-1 downto 0);
    amp_tflag_r_o         : out std_logic_vector(g_CHANNELS-1 downto 0);
    amp_en_ch_i           : in std_logic_vector(g_CHANNELS-1 downto 0)
  );
  end component;
end rtm_lamp_pkg;
