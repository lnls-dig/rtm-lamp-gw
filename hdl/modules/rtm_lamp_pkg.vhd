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

use work.wishbone_pkg.all;

package rtm_lamp_pkg is
  --------------------------------------------------------------------
  -- Constants
  --------------------------------------------------------------------
  constant c_MAX_ADC_CHANNELS                : natural := 12;
  constant c_MAX_DAC_CHANNELS                : natural := 12;

  --------------------------------------------------------------------
  -- Types
  --------------------------------------------------------------------
  subtype t_16b_word is std_logic_vector(15 downto 0);

  type t_16b_word_array is array(natural range <>) of t_16b_word;

  --------------------------------------------------------------------
  -- Components
  --------------------------------------------------------------------

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
      done_pp_o:   out std_logic;
      data_i:      in  t_16b_word_array(g_NUM_DACS-1 downto 0);
      dac_cs_n_o:  out std_logic;
      dac_sck_o:   out std_logic;
      dac_sdi_o:   out std_logic_vector(g_NUM_DACS-1 downto 0)
      );
  end component;

  component multi_dac_spi_ldac is
    generic (
      g_CLK_FREQ            : natural := 100_000_000;
      g_SCLK_FREQ           : natural := 50_000_000;
      g_REF_CLK_LDAC_FREQ   : natural := 50_000_000;
      g_NUM_DACS            : natural := 8;
      g_USE_REF_CLK_LDAC    : boolean := false;
      g_CPOL                : boolean := false;
      g_LDAC_WIDTH          : real := 30.0e-9;
      g_LDAC_WAIT_AFTER_CS  : real := 30.0e-9
    );
    port(
      clk_i:         in  std_logic;
      rst_n_i:       in  std_logic;
      clk_ref_ldac_i: in  std_logic := '0';
      rst_ref_ldac_n_i: in  std_logic := '1';
      start_i:       in  std_logic;
      ready_o:       out std_logic := '0';
      done_pp_o:     out std_logic;
      data_i:        in  t_16b_word_array(g_NUM_DACS-1 downto 0);
      dac_cs_n_o:    out std_logic;
      dac_ldac_n_o:  out std_logic;
      dac_sck_o:     out std_logic;
      dac_sdi_o:     out std_logic_vector(g_NUM_DACS-1 downto 0)
      );
  end component;

  component ltc232x_acq is
  generic(
    g_CLK_FAST_SPI_FREQ                      : natural := 400_000_000;
    g_SCLK_FREQ                              : natural := 100_000_000;
    g_REF_CLK_CNV_FREQ                       : natural := 50_000_000;
    g_USE_REF_CLK_CNV                        : boolean := false;
    g_BITS                                   : natural := 16;
    g_CHANNELS                               : natural := 8;
    g_DATA_LINES                             : natural := 8;
    g_CNV_HIGH                               : real    := 30.0e-9;
    g_CNV_WAIT                               : real    := 450.0e-9
    );
  port(
    rst_fast_spi_n_i                         : in  std_logic;
    clk_fast_spi_i                           : in  std_logic;
    rst_n_i                                  : in  std_logic;
    clk_i                                    : in  std_logic;
    rst_ref_cnv_n_i                          : in  std_logic  := '1';
    clk_ref_cnv_i                            : in  std_logic  := '0';
    start_i                                  : in  std_logic;
    cnv_o                                    : out std_logic  := '0';
    sck_o                                    : out std_logic  := '0';
    sck_ret_i                                : in  std_logic;
    ready_o                                  : out std_logic  := '0';
    done_pp_o                                : out std_logic;
    sdo1a_i                                  : in  std_logic;
    sdo2_i                                   : in  std_logic  := '0';
    sdo3b_i                                  : in  std_logic  := '0';
    sdo4_i                                   : in  std_logic  := '0';
    sdo5c_i                                  : in  std_logic  := '0';
    sdo6_i                                   : in  std_logic  := '0';
    sdo7d_i                                  : in  std_logic  := '0';
    sdo8_i                                   : in  std_logic  := '0';
    ch1_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch2_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch3_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch4_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch5_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch6_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch7_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch8_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    valid_o                                  : out std_logic
    );
  end component;

  component ltc232x_cdc_fifo
  generic
  (
    g_data_width                              : natural;
    g_size                                    : natural
  );
  port
  (
    clk_wr_i                                  : in std_logic;
    data_i                                    : in std_logic_vector(g_data_width-1 downto 0);
    valid_i                                   : in std_logic;

    clk_rd_i                                  : in std_logic;
    data_o                                    : out std_logic_vector(g_data_width-1 downto 0);
    valid_o                                   : out std_logic
  );
  end component;

  component ltc232x_readout is
  generic(
    g_CLK_FAST_SPI_FREQ                      : natural := 400_000_000;
    g_SCLK_FREQ                              : natural := 100_000_000;
    g_BITS                                   : natural := 16;
    g_CHANNELS                               : natural := 8;
    g_DATA_LINES                             : natural := 8
    );
  port(
    rst_fast_spi_n_i                         : in  std_logic;
    clk_fast_spi_i                           : in  std_logic;
    start_i                                  : in  std_logic;
    sck_o                                    : out std_logic  := '0';
    sck_ret_i                                : in  std_logic;
    ready_o                                  : out std_logic  := '0';
    done_pp_o                                : out std_logic;
    sdo1a_i                                  : in  std_logic;
    sdo2_i                                   : in  std_logic  := '0';
    sdo3b_i                                  : in  std_logic  := '0';
    sdo4_i                                   : in  std_logic  := '0';
    sdo5c_i                                  : in  std_logic  := '0';
    sdo6_i                                   : in  std_logic  := '0';
    sdo7d_i                                  : in  std_logic  := '0';
    sdo8_i                                   : in  std_logic  := '0';
    ch1_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch2_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch3_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch4_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch5_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch6_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch7_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    ch8_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    valid_o                                  : out std_logic
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
    -- Reference clock frequency [Hz], used only when g_USE_REF_CNV is
    -- set to true
    g_REF_CLK_FREQ                             : natural := 50000000;
    -- Wether or not to use a reference clk to drive CNV/LDAC.
    -- If true uses clk_ref_i to drive CNV/LDAC
    -- If false uses clk_i to drive CNV/LDAC
    g_USE_REF_CLK                              : boolean := false;
    -- ADC clock frequency [Hz]. Must be a multiple of g_ADC_SCLK_FREQ
    -- at 4x the frequency ADC sck frequency [Hz]
    g_CLK_FAST_SPI_FREQ                        : natural := 400000000;
    -- ADC clock frequency [Hz]
    g_ADC_SCLK_FREQ                            : natural := 100000000;
    -- Number of ADC channels
    g_ADC_CHANNELS                             : natural := 12;
    -- If the ADC inputs are inverted on RTM-LAMP or not
    g_ADC_FIX_INV_INPUTS                       : boolean := false;
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

    clk_ref_i                                  : in   std_logic := '0';
    rst_ref_n_i                                : in   std_logic := '1';

    rst_fast_spi_n_i                           : in  std_logic;
    clk_fast_spi_i                             : in  std_logic;

    ---------------------------------------------------------------------------
    -- RTM ADC interface
    ---------------------------------------------------------------------------
    adc_octo_cnv_o                             : out   std_logic;
    adc_octo_sck_p_o                           : out   std_logic;
    adc_octo_sck_n_o                           : out   std_logic;
    adc_octo_sck_ret_p_i                       : in    std_logic;
    adc_octo_sck_ret_n_i                       : in    std_logic;
    adc_octo_sdoa_p_i                          : in    std_logic;
    adc_octo_sdoa_n_i                          : in    std_logic;
    adc_octo_sdob_p_i                          : in    std_logic;
    adc_octo_sdob_n_i                          : in    std_logic;
    adc_octo_sdoc_p_i                          : in    std_logic;
    adc_octo_sdoc_n_i                          : in    std_logic;
    adc_octo_sdod_p_i                          : in    std_logic;
    adc_octo_sdod_n_i                          : in    std_logic;

    -- Only used when g_ADC_CHANNELS > 8
    adc_quad_cnv_o                             : out   std_logic;
    adc_quad_sck_p_o                           : out   std_logic;
    adc_quad_sck_n_o                           : out   std_logic;
    adc_quad_sck_ret_p_i                       : in    std_logic := '0';
    adc_quad_sck_ret_n_i                       : in    std_logic := '1';
    adc_quad_sdoa_p_i                          : in    std_logic := '0';
    adc_quad_sdoa_n_i                          : in    std_logic := '1';
    adc_quad_sdoc_p_i                          : in    std_logic := '0';
    adc_quad_sdoc_n_i                          : in    std_logic := '1';

    ---------------------------------------------------------------------------
    -- RTM DAC interface
    ---------------------------------------------------------------------------
    dac_cs_n_o                                 : out  std_logic;
    dac_ldac_n_o                               : out  std_logic;
    dac_sck_o                                  : out  std_logic;
    dac_sdi_o                                  : out  std_logic_vector(g_DAC_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- RTM Serial registers interface
    ---------------------------------------------------------------------------
    amp_shift_clk_o                            : out   std_logic;
    amp_shift_dout_i                           : in    std_logic := '0';
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
    dac_done_pp_o                              : out  std_logic;

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

  component wb_rtmlamp_ohwr is
  generic (
    g_INTERFACE_MODE                           : t_wishbone_interface_mode      := CLASSIC;
    g_ADDRESS_GRANULARITY                      : t_wishbone_address_granularity := WORD;
    g_WITH_EXTRA_WB_REG                        : boolean := false;
    -- System clock frequency [Hz]
    g_SYS_CLOCK_FREQ                           : natural := 100000000;
    -- Reference clock frequency [Hz], used only when g_USE_REF_CNV is
    -- set to true
    g_REF_CLK_FREQ                             : natural := 50000000;
    -- Wether or not to use a reference clk to drive CNV/LDAC.
    -- If true uses clk_ref_i to drive CNV/LDAC
    -- If false uses clk_i to drive CNV/LDAC
    g_USE_REF_CLK                              : boolean := false;
    -- ADC clock frequency [Hz]. Must be a multiple of g_ADC_SCLK_FREQ
    -- at 4x the frequency ADC sck frequency [Hz]
    g_CLK_FAST_SPI_FREQ                        : natural := 400000000;
    -- ADC clock frequency [Hz]
    g_ADC_SCLK_FREQ                            : natural := 100000000;
    -- Number of ADC channels
    g_ADC_CHANNELS                             : natural := 12;
    -- If the ADC inputs are inverted on RTM-LAMP or not
    g_ADC_FIX_INV_INPUTS                       : boolean := false;
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

    clk_ref_i                                  : in   std_logic := '0';
    rst_ref_n_i                                : in   std_logic := '1';

    rst_fast_spi_n_i                           : in  std_logic;
    clk_fast_spi_i                             : in  std_logic;

    ---------------------------------------------------------------------------
    -- Wishbone Control Interface signals
    ---------------------------------------------------------------------------
    wb_adr_i                                   : in  std_logic_vector(c_WISHBONE_ADDRESS_WIDTH-1 downto 0) := (others => '0');
    wb_dat_i                                   : in  std_logic_vector(c_WISHBONE_DATA_WIDTH-1 downto 0) := (others => '0');
    wb_dat_o                                   : out std_logic_vector(c_WISHBONE_DATA_WIDTH-1 downto 0);
    wb_sel_i                                   : in  std_logic_vector(c_WISHBONE_DATA_WIDTH/8-1 downto 0) := (others => '0');
    wb_we_i                                    : in  std_logic := '0';
    wb_cyc_i                                   : in  std_logic := '0';
    wb_stb_i                                   : in  std_logic := '0';
    wb_ack_o                                   : out std_logic;
    wb_err_o                                   : out std_logic;
    wb_rty_o                                   : out std_logic;
    wb_stall_o                                 : out std_logic;

    ---------------------------------------------------------------------------
    -- RTM ADC interface
    ---------------------------------------------------------------------------
    adc_octo_cnv_o                             : out   std_logic;
    adc_octo_sck_p_o                           : out   std_logic;
    adc_octo_sck_n_o                           : out   std_logic;
    adc_octo_sck_ret_p_i                       : in    std_logic;
    adc_octo_sck_ret_n_i                       : in    std_logic;
    adc_octo_sdoa_p_i                          : in    std_logic;
    adc_octo_sdoa_n_i                          : in    std_logic;
    adc_octo_sdob_p_i                          : in    std_logic;
    adc_octo_sdob_n_i                          : in    std_logic;
    adc_octo_sdoc_p_i                          : in    std_logic;
    adc_octo_sdoc_n_i                          : in    std_logic;
    adc_octo_sdod_p_i                          : in    std_logic;
    adc_octo_sdod_n_i                          : in    std_logic;

    -- Only used when g_ADC_CHANNELS > 8
    adc_quad_cnv_o                             : out   std_logic;
    adc_quad_sck_p_o                           : out   std_logic;
    adc_quad_sck_n_o                           : out   std_logic;
    adc_quad_sck_ret_p_i                       : in    std_logic := '0';
    adc_quad_sck_ret_n_i                       : in    std_logic := '1';
    adc_quad_sdoa_p_i                          : in    std_logic := '0';
    adc_quad_sdoa_n_i                          : in    std_logic := '1';
    adc_quad_sdoc_p_i                          : in    std_logic := '0';
    adc_quad_sdoc_n_i                          : in    std_logic := '1';

    ---------------------------------------------------------------------------
    -- RTM DAC interface
    ---------------------------------------------------------------------------
    dac_cs_n_o                                 : out  std_logic;
    dac_ldac_n_o                               : out  std_logic;
    dac_sck_o                                  : out  std_logic;
    dac_sdi_o                                  : out  std_logic_vector(g_DAC_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- RTM Serial registers interface
    ---------------------------------------------------------------------------
    amp_shift_clk_o                            : out   std_logic;
    amp_shift_dout_i                           : in    std_logic := '0';
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
    adc_data_o                                 : out  std_logic_vector(16*g_ADC_CHANNELS-1 downto 0);
    adc_valid_o                                : out  std_logic_vector(g_ADC_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- DAC parallel interface
    ---------------------------------------------------------------------------
    dac_start_i                                : in   std_logic;
    dac_data_i                                 : in   std_logic_vector(16*g_DAC_CHANNELS-1 downto 0);
    dac_ready_o                                : out  std_logic;
    dac_done_pp_o                              : out  std_logic
  );
  end component;

  component xwb_rtmlamp_ohwr is
  generic (
    g_INTERFACE_MODE                           : t_wishbone_interface_mode      := CLASSIC;
    g_ADDRESS_GRANULARITY                      : t_wishbone_address_granularity := WORD;
    g_WITH_EXTRA_WB_REG                        : boolean := false;
    -- System clock frequency [Hz]
    g_SYS_CLOCK_FREQ                           : natural := 100000000;
    -- Reference clock frequency [Hz], used only when g_USE_REF_CNV is
    -- set to true
    g_REF_CLK_FREQ                             : natural := 50000000;
    -- Wether or not to use a reference clk to drive CNV/LDAC.
    -- If true uses clk_ref_i to drive CNV/LDAC
    -- If false uses clk_i to drive CNV/LDAC
    g_USE_REF_CLK                              : boolean := false;
    -- ADC clock frequency [Hz]. Must be a multiple of g_ADC_SCLK_FREQ
    -- at 4x the frequency ADC sck frequency [Hz]
    g_CLK_FAST_SPI_FREQ                        : natural := 400000000;
    -- ADC clock frequency [Hz]
    g_ADC_SCLK_FREQ                            : natural := 100000000;
    -- Number of ADC channels
    g_ADC_CHANNELS                             : natural := 12;
    -- If the ADC inputs are inverted on RTM-LAMP or not
    g_ADC_FIX_INV_INPUTS                       : boolean := false;
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

    clk_ref_i                                  : in   std_logic := '0';
    rst_ref_n_i                                : in   std_logic := '1';

    rst_fast_spi_n_i                           : in  std_logic;
    clk_fast_spi_i                             : in  std_logic;

    ---------------------------------------------------------------------------
    -- Wishbone Control Interface signals
    ---------------------------------------------------------------------------
    wb_slv_i                                   : in   t_wishbone_slave_in;
    wb_slv_o                                   : out  t_wishbone_slave_out;

    ---------------------------------------------------------------------------
    -- RTM ADC interface
    ---------------------------------------------------------------------------
    adc_octo_cnv_o                             : out   std_logic;
    adc_octo_sck_p_o                           : out   std_logic;
    adc_octo_sck_n_o                           : out   std_logic;
    adc_octo_sck_ret_p_i                       : in    std_logic;
    adc_octo_sck_ret_n_i                       : in    std_logic;
    adc_octo_sdoa_p_i                          : in    std_logic;
    adc_octo_sdoa_n_i                          : in    std_logic;
    adc_octo_sdob_p_i                          : in    std_logic;
    adc_octo_sdob_n_i                          : in    std_logic;
    adc_octo_sdoc_p_i                          : in    std_logic;
    adc_octo_sdoc_n_i                          : in    std_logic;
    adc_octo_sdod_p_i                          : in    std_logic;
    adc_octo_sdod_n_i                          : in    std_logic;

    -- Only used when g_ADC_CHANNELS > 8
    adc_quad_cnv_o                             : out   std_logic;
    adc_quad_sck_p_o                           : out   std_logic;
    adc_quad_sck_n_o                           : out   std_logic;
    adc_quad_sck_ret_p_i                       : in    std_logic := '0';
    adc_quad_sck_ret_n_i                       : in    std_logic := '1';
    adc_quad_sdoa_p_i                          : in    std_logic := '0';
    adc_quad_sdoa_n_i                          : in    std_logic := '1';
    adc_quad_sdoc_p_i                          : in    std_logic := '0';
    adc_quad_sdoc_n_i                          : in    std_logic := '1';

    ---------------------------------------------------------------------------
    -- RTM DAC interface
    ---------------------------------------------------------------------------
    dac_cs_n_o                                 : out  std_logic;
    dac_ldac_n_o                               : out  std_logic;
    dac_sck_o                                  : out  std_logic;
    dac_sdi_o                                  : out  std_logic_vector(g_DAC_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- RTM Serial registers interface
    ---------------------------------------------------------------------------
    amp_shift_clk_o                            : out   std_logic;
    amp_shift_dout_i                           : in    std_logic := '0';
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
    dac_done_pp_o                              : out  std_logic
  );
  end component;

  --------------------------------------------------------------------
  -- SDB Devices Structures
  --------------------------------------------------------------------

  -- FOFB CC
  constant c_xwb_rtm_lamp_regs_sdb : t_sdb_device := (
    abi_class     => x"0000",                   -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"00",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"4",                      -- 32-bit port granularity (0100)
    sdb_component => (
    addr_first    => x"0000000000000000",
    addr_last     => x"0000000000000FFF",
    product => (
    vendor_id     => x"1000000000001215",       -- LNLS
    device_id     => x"a1248bec",
    version       => x"00000001",
    date          => x"20211301",
    name          => "LNLS_RTM_LAMP_REGS ")));

end rtm_lamp_pkg;
