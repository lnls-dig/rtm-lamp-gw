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

  component rtmlamp_ohwr is
  generic (
    -- System clock frequency [Hz]
    g_SYS_CLOCK_FREQ                           : natural := 100000000;
    -- ADC clock frequency [Hz]. Must be a multiple of g_ADC_SCLK_FREQ
    g_ADC_MASTER_CLOCK_FREQ                    : natural := 200000000;
    -- ADC clock frequency [Hz]
    g_ADC_SCLK_FREQ                            : natural := 100000000;
    -- Number of ADC channels
    g_ADC_CHANNELS                             : natural := 12;
    -- DAC clock frequency [Hz]. Must be a multiple of g_DAC_SCLK_FREQ
    g_DAC_MASTER_CLOCK_FREQ                    : natural := 200000000;
    -- DAC clock frequency [Hz]
    g_DAC_SCLK_FREQ                            : natural := 25000000;
    -- Number of DAC channels
    g_DAC_CHANNELS                             : natural := 12;
    -- Serial registers clock frequency [Hz]
    g_SERIAL_REG_SCLK_FREQ                     : natural := 100000;
    -- Number of AMP channels
    g_SERIAL_REGS_AMP_CHANNELS                 : natural := 12
  );
  port (
    ---------------------------------------------------------------------------
    -- clock and reset interface
    ---------------------------------------------------------------------------
    clk_i                                      : in   std_logic;
    rst_n_i                                    : in   std_logic;

    clk_master_adc_i                           : in   std_logic;
    rst_master_adc_n_i                         : in   std_logic;

    clk_master_dac_i                           : in   std_logic;
    rst_master_dac_n_i                         : in   std_logic;

    ---------------------------------------------------------------------------
    -- RTM amplifier registers serial interface
    ---------------------------------------------------------------------------
    amp_status_reg_clk_o                       : out  std_logic;
    amp_status_reg_out_i                       : in   std_logic;
    amp_status_reg_pl_o                        : out  std_logic;

    amp_ctl_reg_oe_n_o                         : out  std_logic;
    amp_ctl_reg_din_o                          : out  std_logic;
    amp_ctl_reg_str_o                          : out  std_logic;

    ---------------------------------------------------------------------------
    -- RTM ADC interface
    ---------------------------------------------------------------------------
    adc_octo_cnv_o                             : out   std_logic;
    adc_octo_sck_o                             : out   std_logic;
    adc_octo_sck_ret_i                         : in    std_logic;
    adc_octo_sdoa_i                            : in    std_logic;
    adc_octo_sdob_i                            : in    std_logic;
    adc_octo_sdoc_i                            : in    std_logic;
    adc_octo_sdod_i                            : in    std_logic;

    -- Only used when g_ADC_CHANNELS > 8
    adc_quad_cnv_o                             : out   std_logic;
    adc_quad_sck_o                             : out   std_logic;
    adc_quad_sck_ret_i                         : in    std_logic := '0';
    adc_quad_sdoa_i                            : in    std_logic := '0';
    adc_quad_sdoc_i                            : in    std_logic := '0';

    ---------------------------------------------------------------------------
    -- RTM DAC interface
    ---------------------------------------------------------------------------
    dac_cs_o                                   : out  std_logic;
    dac_sck_o                                  : out  std_logic;
    dac_sdi_o                                  : out  std_logic_vector(g_DAC_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- RTM Serial registers interface
    ---------------------------------------------------------------------------
    amp_shift_clk_o                            : out   std_logic;
    amp_shift_dout_i                           : in    std_logic;
    amp_shift_pl_o                             : out   std_logic;

    amp_shift_oe_n_o                           : out   std_logic;
    amp_shift_din_o                            : out   std_logic;
    amp_shift_str_o                            : out   std_logic;

    ---------------------------------------------------------------------------
    -- FPGA interface
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- ADC parallel interface
    ---------------------------------------------------------------------------
    adc_start_i                                : in   std_logic;
    adc_data_o                                 : out  t_16b_word_array(g_ADC_CHANNELS-1 downto 0);
    adc_valid_o                                : out  std_logic_vector(g_ADC_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- DAC parallel interface
    ---------------------------------------------------------------------------
    dac_start_i                                : in   std_logic;
    dac_data_i                                 : in   t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
    dac_ready_o                                : out  std_logic;

    ---------------------------------------------------------------------------
    -- AMP parallel interface
    ---------------------------------------------------------------------------
    -- Set to 1 to read and write all AMP parameters listed at the AMP
    -- parallel interface
    amp_sta_ctl_rw_i                           : in    std_logic := '1';

    amp_iflag_l_o                              : out   std_logic_vector(g_SERIAL_REGS_AMP_CHANNELS-1 downto 0);
    amp_tflag_l_o                              : out   std_logic_vector(g_SERIAL_REGS_AMP_CHANNELS-1 downto 0);
    amp_iflag_r_o                              : out   std_logic_vector(g_SERIAL_REGS_AMP_CHANNELS-1 downto 0);
    amp_tflag_r_o                              : out   std_logic_vector(g_SERIAL_REGS_AMP_CHANNELS-1 downto 0);
    amp_en_ch_i                                : in    std_logic_vector(g_SERIAL_REGS_AMP_CHANNELS-1 downto 0)
  );
  end component;
end rtm_lamp_pkg;
