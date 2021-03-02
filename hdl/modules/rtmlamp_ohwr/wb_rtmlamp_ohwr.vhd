------------------------------------------------------------------------------
-- Title      : WB RTM LAMP interface
------------------------------------------------------------------------------
-- Author     : Lucas Maziero Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-02-26
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Wishbone RTM LAMP Serial register interface.
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2021-02-26  1.0      lucas.russo        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- RTM LAMP definitions
use work.rtm_lamp_pkg.all;
-- Wishbone definitions
use work.wishbone_pkg.all;

entity wb_rtmlamp_ohwr is
generic (
  g_INTERFACE_MODE                           : t_wishbone_interface_mode      := CLASSIC;
  g_ADDRESS_GRANULARITY                      : t_wishbone_address_granularity := WORD;
  g_WITH_EXTRA_WB_REG                        : boolean := false;
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
  adc_data_o                                 : out  std_logic_vector(16*g_ADC_CHANNELS-1 downto 0);
  adc_valid_o                                : out  std_logic_vector(g_ADC_CHANNELS-1 downto 0);

  ---------------------------------------------------------------------------
  -- DAC parallel interface
  ---------------------------------------------------------------------------
  dac_start_i                                : in   std_logic;
  dac_data_i                                 : in   std_logic_vector(16*g_DAC_CHANNELS-1 downto 0);
  dac_ready_o                                : out  std_logic
);
end wb_rtmlamp_ohwr;

architecture rtl of wb_rtmlamp_ohwr is

  signal wb_slv_out                          : t_wishbone_slave_out;
  signal wb_slv_in                           : t_wishbone_slave_in;

  signal adc_data                            : t_16b_word_array(g_ADC_CHANNELS-1 downto 0);
  signal dac_data                            : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);

begin

  wb_slv_in.adr  <= wb_adr_i;
  wb_slv_in.dat  <= wb_dat_i;
  wb_slv_in.sel  <= wb_sel_i;
  wb_slv_in.we   <= wb_we_i;
  wb_slv_in.cyc  <= wb_cyc_i;
  wb_slv_in.stb  <= wb_stb_i;

  wb_dat_o    <= wb_slv_out.dat;
  wb_ack_o    <= wb_slv_out.ack;
  wb_err_o    <= wb_slv_out.err;
  wb_rty_o    <= wb_slv_out.rty;
  wb_stall_o  <= wb_slv_out.stall;

  cmp_xwb_rtmlamp_ohwr : xwb_rtmlamp_ohwr
  generic map (
    g_INTERFACE_MODE                           => g_INTERFACE_MODE,
    g_ADDRESS_GRANULARITY                      => g_ADDRESS_GRANULARITY,
    g_WITH_EXTRA_WB_REG                        => g_WITH_EXTRA_WB_REG,
    g_SYS_CLOCK_FREQ                           => g_SYS_CLOCK_FREQ,
    g_ADC_MASTER_CLOCK_FREQ                    => g_ADC_MASTER_CLOCK_FREQ,
    g_ADC_SCLK_FREQ                            => g_ADC_SCLK_FREQ ,
    g_ADC_CHANNELS                             => g_ADC_CHANNELS,
    g_DAC_MASTER_CLOCK_FREQ                    => g_DAC_MASTER_CLOCK_FREQ,
    g_DAC_SCLK_FREQ                            => g_DAC_SCLK_FREQ,
    g_DAC_CHANNELS                             => g_DAC_CHANNELS,
    g_SERIAL_REG_SCLK_FREQ                     => g_SERIAL_REG_SCLK_FREQ,
    g_SERIAL_REGS_AMP_CHANNELS                 => g_SERIAL_REGS_AMP_CHANNELS
  )
  port map (
    ---------------------------------------------------------------------------
    -- clock and reset interface
    ---------------------------------------------------------------------------
    clk_i                                      => clk_i,
    rst_n_i                                    => rst_n_i,

    clk_master_adc_i                           => clk_master_adc_i,
    rst_master_adc_n_i                         => rst_master_adc_n_i,

    clk_master_dac_i                           => clk_master_dac_i,
    rst_master_dac_n_i                         => rst_master_dac_n_i,

    ---------------------------------------------------------------------------
    -- Wishbone Control Interface signals
    ---------------------------------------------------------------------------
    wb_slv_i                                   => wb_slv_in,
    wb_slv_o                                   => wb_slv_out,

    ---------------------------------------------------------------------------
    -- RTM amplifier registers serial interface
    ---------------------------------------------------------------------------
    amp_status_reg_clk_o                       => amp_status_reg_clk_o,
    amp_status_reg_out_i                       => amp_status_reg_out_i,
    amp_status_reg_pl_o                        => amp_status_reg_pl_o,

    amp_ctl_reg_oe_n_o                         => amp_ctl_reg_oe_n_o,
    amp_ctl_reg_din_o                          => amp_ctl_reg_din_o,
    amp_ctl_reg_str_o                          => amp_ctl_reg_str_o,

    ---------------------------------------------------------------------------
    -- RTM ADC interface
    ---------------------------------------------------------------------------
    adc_octo_cnv_o                             => adc_octo_cnv_o,
    adc_octo_sck_p_o                           => adc_octo_sck_p_o,
    adc_octo_sck_n_o                           => adc_octo_sck_n_o,
    adc_octo_sck_ret_p_i                       => adc_octo_sck_ret_p_i,
    adc_octo_sck_ret_n_i                       => adc_octo_sck_ret_n_i,
    adc_octo_sdoa_p_i                          => adc_octo_sdoa_p_i,
    adc_octo_sdoa_n_i                          => adc_octo_sdoa_n_i,
    adc_octo_sdob_p_i                          => adc_octo_sdob_p_i,
    adc_octo_sdob_n_i                          => adc_octo_sdob_n_i,
    adc_octo_sdoc_p_i                          => adc_octo_sdoc_p_i,
    adc_octo_sdoc_n_i                          => adc_octo_sdoc_n_i,
    adc_octo_sdod_p_i                          => adc_octo_sdod_p_i,
    adc_octo_sdod_n_i                          => adc_octo_sdod_n_i,

    -- Only used when g_ADC_CHANNELS > 8
    adc_quad_cnv_o                             => adc_quad_cnv_o,
    adc_quad_sck_p_o                           => adc_quad_sck_p_o,
    adc_quad_sck_n_o                           => adc_quad_sck_n_o,
    adc_quad_sck_ret_p_i                       => adc_quad_sck_ret_p_i,
    adc_quad_sck_ret_n_i                       => adc_quad_sck_ret_n_i,
    adc_quad_sdoa_p_i                          => adc_quad_sdoa_p_i,
    adc_quad_sdoa_n_i                          => adc_quad_sdoa_n_i,
    adc_quad_sdoc_p_i                          => adc_quad_sdoc_p_i,
    adc_quad_sdoc_n_i                          => adc_quad_sdoc_n_i,

    ---------------------------------------------------------------------------
    -- RTM DAC interface
    ---------------------------------------------------------------------------
    dac_cs_n_o                                 => dac_cs_n_o,
    dac_sck_o                                  => dac_sck_o,
    dac_sdi_o                                  => dac_sdi_o,

    ---------------------------------------------------------------------------
    -- RTM Serial registers interface
    ---------------------------------------------------------------------------
    amp_shift_clk_o                            => amp_shift_clk_o,
    amp_shift_dout_i                           => amp_shift_dout_i,
    amp_shift_pl_o                             => amp_shift_pl_o,

    amp_shift_oe_n_o                           => amp_shift_oe_n_o,
    amp_shift_din_o                            => amp_shift_din_o,
    amp_shift_str_o                            => amp_shift_str_o,

    ---------------------------------------------------------------------------
    -- FPGA interface
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- ADC parallel interface
    ---------------------------------------------------------------------------
    adc_start_i                                => adc_start_i,
    adc_data_o                                 => adc_data,
    adc_valid_o                                => adc_valid_o,

    ---------------------------------------------------------------------------
    -- DAC parallel interface
    ---------------------------------------------------------------------------
    dac_start_i                                => dac_start_i,
    dac_data_i                                 => dac_data,
    dac_ready_o                                => dac_ready_o
  );

  gen_adc_plain_data : for i in 0 to g_ADC_CHANNELS-1 generate
    adc_data_o(16*(i+1)-1 downto 16*i) <= adc_data(i);
  end generate;

  gen_dac_plain_data : for i in 0 to g_DAC_CHANNELS-1 generate
    dac_data(i) <= dac_data_i(16*(i+1)-1 downto 16*i);
  end generate;

end rtl;
