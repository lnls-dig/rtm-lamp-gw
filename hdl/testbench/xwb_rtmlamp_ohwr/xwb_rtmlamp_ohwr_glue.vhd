------------------------------------------------------------------------------
-- Title      : xwb_rtmlamp_ohwr rtm_lamp_model glue
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-GCA
-- Created    : 2022-01-24
-- Platform   : Simulation
-------------------------------------------------------------------------------
-- Description: xwb_rtmlamp_ohwr core connected to a virtual RTM-LAMP model
-------------------------------------------------------------------------------
-- Copyright (c) 2022 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2022-01-24  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
-- RTM LAMP definitions
use work.rtm_lamp_pkg.all;
-- Main Wishbone Definitions
use work.wishbone_pkg.all;
-- generic buffers
use work.platform_generic_pkg.all;
-- wishbone read / write procedures
use work.sim_wishbone.all;

entity xwb_rtmlamp_ohwr_glue is
  generic(
    g_SYS_CLOCK_FREQ         : natural := 100000000;
    g_REF_CLOCK_FREQ         : natural := 100000000;
    g_FAST_SPI_FREQ          : natural := 400000000;
    g_ADC_SCLK_FREQ          : natural := 100000000;
    g_DAC_SCLK_FREQ          : natural := 25000000;
    g_USE_REF_CLOCK          : boolean := true;
    g_CHANNELS               : natural := 12
    );
  port(
    clk_sys_i                : in  std_logic := '0';
    clk_sys_rstn_i           : in  std_logic := '0';
    clk_rtm_ref_i            : in  std_logic := '0';
    clk_rtm_ref_rstn_i       : in  std_logic := '0';
    clk_fast_spi_i           : in  std_logic := '0';
    clk_fast_spi_rstn_i      : in  std_logic := '0';

    wb_slave_i               : in  t_wishbone_slave_in;
    wb_slave_o               : out t_wishbone_slave_out;

    pi_sp_ext_i              : in t_pi_sp_word_array(g_CHANNELS-1 downto 0) := (others => x"0000")
    );
end entity xwb_rtmlamp_ohwr_glue;

architecture xwb_rtmlamp_ohwr_glue_arch of xwb_rtmlamp_ohwr_glue is
  signal adc_cnv             : std_logic;
  signal adc_octo_sck        : std_logic;
  signal adc_octo_sck_p      : std_logic;
  signal adc_octo_sck_n      : std_logic;
  signal adc_octo_sck_ret    : std_logic;
  signal adc_octo_sck_ret_p  : std_logic;
  signal adc_octo_sck_ret_n  : std_logic;
  signal adc_octo_sdoa       : std_logic;
  signal adc_octo_sdoa_p     : std_logic;
  signal adc_octo_sdoa_n     : std_logic;
  signal adc_octo_sdob       : std_logic;
  signal adc_octo_sdob_p     : std_logic;
  signal adc_octo_sdob_n     : std_logic;
  signal adc_octo_sdoc       : std_logic;
  signal adc_octo_sdoc_p     : std_logic;
  signal adc_octo_sdoc_n     : std_logic;
  signal adc_octo_sdod       : std_logic;
  signal adc_octo_sdod_p     : std_logic;
  signal adc_octo_sdod_n     : std_logic;
  signal adc_quad_sck        : std_logic;
  signal adc_quad_sck_p      : std_logic;
  signal adc_quad_sck_n      : std_logic;
  signal adc_quad_sck_ret    : std_logic;
  signal adc_quad_sck_ret_p  : std_logic;
  signal adc_quad_sck_ret_n  : std_logic;
  signal adc_quad_sdoa       : std_logic;
  signal adc_quad_sdoa_p     : std_logic;
  signal adc_quad_sdoa_n     : std_logic;
  signal adc_quad_sdoc       : std_logic;
  signal adc_quad_sdoc_p     : std_logic;
  signal adc_quad_sdoc_n     : std_logic;

  signal dac_ldac            : std_logic;
  signal dac_cs_n            : std_logic;
  signal dac_sck             : std_logic;
  signal dac_sdi             : std_logic_vector(g_CHANNELS-1 downto 0);

  signal amp_shift_clk       : std_logic;
  signal amp_shift_dout      : std_logic;
  signal amp_shift_pl        : std_logic;
  signal amp_shift_oe_n      : std_logic;
  signal amp_shift_din       : std_logic;
  signal amp_shift_str       : std_logic;

  signal pi_sp_eff           : t_pi_sp_word_array(g_CHANNELS-1 downto 0);
  signal dac_data_eff        : t_16b_word_array(g_CHANNELS-1 downto 0);
  signal adc_data            : t_16b_word_array(g_CHANNELS-1 downto 0);
  signal data_valid          : std_logic;

begin

  cmp_xwb_rtmlamp_ohwr : xwb_rtmlamp_ohwr
    generic map (
      g_INTERFACE_MODE                           => CLASSIC,
      g_ADDRESS_GRANULARITY                      => BYTE,
      g_WITH_EXTRA_WB_REG                        => false,
      -- System clock frequency [Hz]
      g_SYS_CLOCK_FREQ                           => g_SYS_CLOCK_FREQ,
      -- Reference clock frequency [Hz], used only when g_USE_REF_CNV is
      -- set to true
      g_REF_CLK_FREQ                             => g_REF_CLOCK_FREQ,
      -- Wether or not to use a reference clk to drive CNV/LDAC.
      -- If true uses clk_ref_i to drive CNV/LDAC
      -- If false uses clk_i to drive CNV/LDAC
      g_USE_REF_CLK                              => g_USE_REF_CLOCK,
      -- ADC clock frequency [Hz]. Must be a multiple of g_ADC_SCLK_FREQ
      g_CLK_FAST_SPI_FREQ                        => g_FAST_SPI_FREQ,
      -- ADC clock frequency [Hz]
      g_ADC_SCLK_FREQ                            => g_ADC_SCLK_FREQ,
      -- Number channels (8 or 12)
      g_CHANNELS                                 => g_CHANNELS,
      -- If the ADC inputs are inverted on RTM-LAMP or not
      g_ADC_FIX_INV_INPUTS                       => false,
      -- DAC clock frequency [Hz]
      g_DAC_SCLK_FREQ                            => g_DAC_SCLK_FREQ
      -- Number of DAC channels
      )
    port map (
      ---------------------------------------------------------------------------
      -- clock and reset interface
      ---------------------------------------------------------------------------
      clk_i                                      => clk_sys_i,
      rst_n_i                                    => clk_sys_rstn_i,

      clk_ref_i                                  => clk_rtm_ref_i,
      rst_ref_n_i                                => clk_rtm_ref_rstn_i,

      clk_fast_spi_i                             => clk_fast_spi_i,
      rst_fast_spi_n_i                           => clk_fast_spi_rstn_i,

      ---------------------------------------------------------------------------
      -- Wishbone Control Interface signals
      ---------------------------------------------------------------------------
      wb_slv_i                                   => wb_slave_i,
      wb_slv_o                                   => wb_slave_o,

      ---------------------------------------------------------------------------
      -- RTM ADC interface
      ---------------------------------------------------------------------------
      -- use octo conversion signal to drive all ADCs
      adc_octo_cnv_o                             => adc_cnv,
      adc_octo_sck_p_o                           => adc_octo_sck_p,
      adc_octo_sck_n_o                           => adc_octo_sck_n,
      adc_octo_sck_ret_p_i                       => adc_octo_sck_ret_p,
      adc_octo_sck_ret_n_i                       => adc_octo_sck_ret_n,
      adc_octo_sdoa_p_i                          => adc_octo_sdoa_p,
      adc_octo_sdoa_n_i                          => adc_octo_sdoa_n,
      adc_octo_sdob_p_i                          => adc_octo_sdob_p,
      adc_octo_sdob_n_i                          => adc_octo_sdob_n,
      adc_octo_sdoc_p_i                          => adc_octo_sdoc_p,
      adc_octo_sdoc_n_i                          => adc_octo_sdoc_n,
      adc_octo_sdod_p_i                          => adc_octo_sdod_p,
      adc_octo_sdod_n_i                          => adc_octo_sdod_n,

      -- Only used when g_CHANNELS > 8
      adc_quad_sck_p_o                           => adc_quad_sck_p,
      adc_quad_sck_n_o                           => adc_quad_sck_n,
      adc_quad_sck_ret_p_i                       => adc_quad_sck_ret_p,
      adc_quad_sck_ret_n_i                       => adc_quad_sck_ret_n,
      adc_quad_sdoa_p_i                          => adc_quad_sdoa_p,
      adc_quad_sdoa_n_i                          => adc_quad_sdoa_n,
      adc_quad_sdoc_p_i                          => adc_quad_sdoc_p,
      adc_quad_sdoc_n_i                          => adc_quad_sdoc_n,

      ---------------------------------------------------------------------------
      -- RTM DAC interface
      ---------------------------------------------------------------------------
      dac_cs_n_o                                 => dac_cs_n,
      dac_ldac_n_o                               => dac_ldac,
      dac_sck_o                                  => dac_sck,
      dac_sdi_o                                  => dac_sdi,

      ---------------------------------------------------------------------------
      -- RTM Serial registers interface
      ---------------------------------------------------------------------------
      amp_shift_clk_o                            => amp_shift_clk,
      amp_shift_dout_i                           => amp_shift_dout,
      amp_shift_pl_o                             => amp_shift_pl,

      amp_shift_oe_n_o                           => amp_shift_oe_n,
      amp_shift_din_o                            => amp_shift_din,
      amp_shift_str_o                            => amp_shift_str,

      ---------------------------------------------------------------------------
      -- FPGA interface
      ---------------------------------------------------------------------------

      ---------------------------------------------------------------------------
      -- PI parameters
      ---------------------------------------------------------------------------
      -- External PI setpoint data. It is used when ch.x.ctl.mode (wishbone
      -- register) is set to 0b100
      pi_sp_ext_i                                => pi_sp_ext_i,

      ---------------------------------------------------------------------------
      -- Debug data
      ---------------------------------------------------------------------------
      adc_data_o                                 => adc_data,
      pi_sp_eff_o                                => pi_sp_eff,
      dac_data_eff_o                             => dac_data_eff,
      data_valid_o                               => data_valid
      );

  -----------------------------------------------------------
  -- Convert between single ended and differential signals --
  -----------------------------------------------------------
  cmp_octo_ibufds_sck : ibufds_generic
    port map (
      buffer_p_i                             => adc_octo_sck_p,
      buffer_n_i                             => adc_octo_sck_n,
      buffer_o                               => adc_octo_sck
      );

  cmp_octo_obufds_sck_ret : obufds_generic
    port map (
      buffer_i                               => adc_octo_sck_ret,
      buffer_p_o                             => adc_octo_sck_ret_p,
      buffer_n_o                             => adc_octo_sck_ret_n
      );

  cmp_octo_obufds_sdoa : obufds_generic
    port map (
      buffer_i                               => adc_octo_sdoa,
      buffer_p_o                             => adc_octo_sdoa_p,
      buffer_n_o                             => adc_octo_sdoa_n
      );

  cmp_octo_obufds_sdob : obufds_generic
    port map (
      buffer_i                               => adc_octo_sdob,
      buffer_p_o                             => adc_octo_sdob_p,
      buffer_n_o                             => adc_octo_sdob_n
      );

  cmp_octo_obufds_sdoc : obufds_generic
    port map (
      buffer_i                               => adc_octo_sdoc,
      buffer_p_o                             => adc_octo_sdoc_p,
      buffer_n_o                             => adc_octo_sdoc_n
      );

  cmp_octo_obufds_sdod : obufds_generic
    port map (
      buffer_i                               => adc_octo_sdod,
      buffer_p_o                             => adc_octo_sdod_p,
      buffer_n_o                             => adc_octo_sdod_n
      );

  cmp_quad_ibufds_sck : ibufds_generic
    port map (
      buffer_p_i                             => adc_quad_sck_p,
      buffer_n_i                             => adc_quad_sck_n,
      buffer_o                               => adc_quad_sck
      );

  cmp_quad_obufds_sck_ret : obufds_generic
    port map (
      buffer_i                               => adc_quad_sck_ret,
      buffer_p_o                             => adc_quad_sck_ret_p,
      buffer_n_o                             => adc_quad_sck_ret_n
      );

  cmp_quad_obufds_sdoa : obufds_generic
    port map (
      buffer_i                               => adc_quad_sdoa,
      buffer_p_o                             => adc_quad_sdoa_p,
      buffer_n_o                             => adc_quad_sdoa_n
      );

  cmp_quad_obufds_sdoc : obufds_generic
    port map (
      buffer_i                               => adc_quad_sdoc,
      buffer_p_o                             => adc_quad_sdoc_p,
      buffer_n_o                             => adc_quad_sdoc_n
      );

  -----------------------------------------------------------------
  -- RTM-LAMP simulation model, including DACs, ADCs and magnets --
  -----------------------------------------------------------------
  cmp_rtm_lamp_model: entity work.rtm_lamp_model
    generic map(
      g_ADC_DDR_MODE => false
      )
    port map(
      rtm_lamp_sync_clk_i => clk_rtm_ref_i, -- ADC and DAC synchronization clock
                                            -- for conversion start

      adc_cnv_i => adc_cnv,               -- ADC conversion start

      adc_octo_clk_i => adc_octo_sck,     -- ADC octo data clock input
      adc_octo_clk_o => adc_octo_sck_ret, -- ADC octo data clock output
      adc_octo_sdoa_o => adc_octo_sdoa,
      adc_octo_sdob_o => adc_octo_sdob,
      adc_octo_sdoc_o => adc_octo_sdoc,
      adc_octo_sdod_o => adc_octo_sdod,

      adc_quad_clk_i => adc_quad_sck,     -- ADC quad data clock input
      adc_quad_clk_o => adc_quad_sck_ret, -- ADC quad data clock output
      adc_quad_sdoa_o => adc_quad_sdoa,
      adc_quad_sdoc_o => adc_quad_sdoc,

      dac_ldac_i => dac_ldac,             -- DAC load
      dac_cs_i => dac_cs_n,               -- DAC chip select
      dac_sck_i => dac_sck,               -- DAC data clock
      dac_sdi_i => dac_sdi,               -- DAC data input (12 channels)

      shift_pl_i   => amp_shift_pl,       -- Amplifier shift registers parallel load
      shift_clk_i  => amp_shift_clk,      -- Amplifier shift registers clock
      shift_dout_o => amp_shift_dout,     -- Amplifier flags shift register output

      shift_str_i  => amp_shift_str,      -- Amplifier enable shift register strobe
      shift_oe_n_i => amp_shift_oe_n,     -- Amplifier enable output enable
      shift_din_i  => amp_shift_din       -- Amplifier enable data input
      );
end architecture xwb_rtmlamp_ohwr_glue_arch;
