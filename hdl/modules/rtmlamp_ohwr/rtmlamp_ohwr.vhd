------------------------------------------------------------------------------
-- Title      : RTM LAMP interface
------------------------------------------------------------------------------
-- Author     : Lucas Maziero Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-02-25
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: RTM LAMP Serial register interface.
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2021-02-25  1.0      lucas.russo        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- RTM LAMP definitions
use work.rtm_lamp_pkg.all;
-- generic buffers
use work.platform_generic_pkg.all;

entity rtmlamp_ohwr is
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
end rtmlamp_ohwr;

architecture rtl of rtmlamp_ohwr is

  signal adc_octo_valid                      : std_logic;
  signal adc_quad_valid                      : std_logic;

  signal adc_data                            : t_16b_word_array(g_ADC_CHANNELS-1 downto 0);
  signal adc_valid                           : std_logic_vector(g_ADC_CHANNELS-1 downto 0);

  signal adc_octo_sck                        : std_logic;
  signal adc_octo_sck_ret                    : std_logic;
  signal adc_octo_sdoa                       : std_logic;
  signal adc_octo_sdob                       : std_logic;
  signal adc_octo_sdoc                       : std_logic;
  signal adc_octo_sdod                       : std_logic;

  signal adc_quad_sck                        : std_logic;
  signal adc_quad_sck_ret                    : std_logic;
  signal adc_quad_sdoa                       : std_logic;
  signal adc_quad_sdoc                       : std_logic;

begin

  assert (g_ADC_CHANNELS <= 12)
    report "[rtmlamp_ohwr] g_ADC_CHANNELS(" & Integer'image(g_ADC_CHANNELS) &
    ") unsuppoted. Maximum number of g_ADC_CHANNELS must be <= 12"
    severity failure;

  ---------------------------------------------------------------------------
  --                              ADC octo
  ---------------------------------------------------------------------------

  -- RTM LTC2320 operates in LVDS mode, so we always acquire 8 channels
  -- with half the number of data lines (2 channels per data line)
  cmp_ltc2320_acq: ltc232x_acq
    generic map(
      g_CLK_FREQ                           => g_ADC_MASTER_CLOCK_FREQ,
      g_SCLK_FREQ                          => g_ADC_SCLK_FREQ,
      g_CHANNELS                           => 8,
      g_DATA_LINES                         => 4
    )
    port map(
      clk_i                                => clk_master_adc_i,
      rst_n_i                              => rst_master_adc_n_i,

      start_i                              => adc_start_i,

      cnv_o                                => adc_octo_cnv_o,
      sck_o                                => adc_octo_sck,
      sck_ret_i                            => adc_octo_sck_ret,
      sdo1a_i                              => adc_octo_sdoa,
      sdo3b_i                              => adc_octo_sdob,
      sdo5c_i                              => adc_octo_sdoc,
      sdo7d_i                              => adc_octo_sdod,

      ch1_o                                => adc_data(0),
      ch2_o                                => adc_data(1),
      ch3_o                                => adc_data(2),
      ch4_o                                => adc_data(3),
      ch5_o                                => adc_data(4),
      ch6_o                                => adc_data(5),
      ch7_o                                => adc_data(6),
      ch8_o                                => adc_data(7),
      valid_o                              => adc_octo_valid
    );

  ---------------------------------------------------------------------------
  --                              Buffers
  ---------------------------------------------------------------------------

  cmp_octo_obufds_sck : obufds_generic
  port map
  (
    buffer_i                                  => adc_octo_sck,
    buffer_p_o                                => adc_octo_sck_p_o,
    buffer_n_o                                => adc_octo_sck_n_o

  );

  cmp_octo_ibufds_sck_ret : ibufds_generic
  port map
  (
    buffer_p_i                               => adc_octo_sck_ret_p_i,
    buffer_n_i                               => adc_octo_sck_ret_n_i,
    buffer_o                                 => adc_octo_sck_ret
  );

  cmp_octo_ibufds_sdoa : ibufds_generic
  port map
  (
    buffer_p_i                               => adc_octo_sdoa_p_i,
    buffer_n_i                               => adc_octo_sdoa_n_i,
    buffer_o                                 => adc_octo_sdoa
  );

  cmp_octo_ibufds_sdob : ibufds_generic
  port map
  (
    buffer_p_i                               => adc_octo_sdob_p_i,
    buffer_n_i                               => adc_octo_sdob_n_i,
    buffer_o                                 => adc_octo_sdob
  );

  cmp_octo_ibufds_sdoc : ibufds_generic
  port map
  (
    buffer_p_i                               => adc_octo_sdoc_p_i,
    buffer_n_i                               => adc_octo_sdoc_n_i,
    buffer_o                                 => adc_octo_sdoc
  );

  cmp_octo_ibufds_sdod : ibufds_generic
  port map
  (
    buffer_p_i                               => adc_octo_sdod_p_i,
    buffer_n_i                               => adc_octo_sdod_n_i,
    buffer_o                                 => adc_octo_sdod
  );

  ---------------------------------------------------------------------------
  --                              ADC quad
  ---------------------------------------------------------------------------

  gen_adc_up_to_8_channels : if g_ADC_CHANNELS <= 8 generate

      adc_data(8)    <= (others => '0');
      adc_data(9)    <= (others => '0');
      adc_data(10)   <= (others => '0');
      adc_data(11)   <= (others => '0');
      adc_quad_valid <= '0';

      adc_quad_cnv_o <= '0';
      adc_quad_sck <= '0';

  end generate;

  gen_adc_more_than_8_channels : if g_ADC_CHANNELS > 8 generate

    -- RTM LTC2324 operates in LVDS mode, so we always acquire 4 channels
    -- with half the number of data lines (2 channels per data line)
    cmp_ltc2320_acq: ltc232x_acq
      generic map(
        g_CLK_FREQ                           => g_ADC_MASTER_CLOCK_FREQ,
        g_SCLK_FREQ                          => g_ADC_SCLK_FREQ,
        g_CHANNELS                           => 4,
        g_DATA_LINES                         => 2
      )
      port map(
        clk_i                                => clk_master_adc_i,
        rst_n_i                              => rst_master_adc_n_i,

        start_i                              => adc_start_i,

        cnv_o                                => adc_quad_cnv_o,
        sck_o                                => adc_quad_sck,
        sck_ret_i                            => adc_quad_sck_ret,
        sdo1a_i                              => adc_quad_sdoa,
        sdo5c_i                              => adc_quad_sdoc,

        ch1_o                                => adc_data(8),
        ch2_o                                => adc_data(9),
        ch3_o                                => adc_data(10),
        ch4_o                                => adc_data(11),
        valid_o                              => adc_quad_valid
      );

    ---------------------------------------------------------------------------
    --                              Buffers
    ---------------------------------------------------------------------------

    cmp_quad_obufds_sck : obufds_generic
    port map
    (
      buffer_i                               => adc_quad_sck,
      buffer_p_o                             => adc_quad_sck_p_o,
      buffer_n_o                             => adc_quad_sck_n_o

    );

    cmp_quad_ibufds_sck_ret : ibufds_generic
    port map
    (
      buffer_p_i                             => adc_quad_sck_ret_p_i,
      buffer_n_i                             => adc_quad_sck_ret_n_i,
      buffer_o                               => adc_quad_sck_ret
    );

    cmp_quad_ibufds_sdoa : ibufds_generic
    port map
    (
      buffer_p_i                             => adc_quad_sdoa_p_i,
      buffer_n_i                             => adc_quad_sdoa_n_i,
      buffer_o                               => adc_quad_sdoa
    );

    cmp_quad_ibufds_sdoc : ibufds_generic
    port map
    (
      buffer_p_i                             => adc_quad_sdoc_p_i,
      buffer_n_i                             => adc_quad_sdoc_n_i,
      buffer_o                               => adc_quad_sdoc
    );

  end generate;

  -- Aggregate all data
  gen_adc_valid : for i in 0 to g_ADC_CHANNELS-1 generate

    gen_adc_valid_up_to_8_channels: if i < 8 generate
      adc_valid(i) <= adc_octo_valid;
    end generate;

    gen_adc_valid_more_than_8_channels: if i >= 8 generate
      adc_valid(i) <= adc_quad_valid;
    end generate;

  end generate;

  adc_data_o <= adc_data;
  adc_valid_o <= adc_valid;

  ---------------------------------------------------------------------------
  --                              DACs
  ---------------------------------------------------------------------------

  cmp_multi_dac: multi_dac_spi
    generic map(
      g_CLK_FREQ                             => g_DAC_MASTER_CLOCK_FREQ,
      g_SCLK_FREQ                            => g_DAC_SCLK_FREQ,
      g_NUM_DACS                             => g_DAC_CHANNELS,
      g_CPOL                                 => false
    )
    port map(
      clk_i                                  => clk_master_dac_i,
      rst_n_i                                => rst_master_dac_n_i,

      start_i                                => dac_start_i,
      data_i                                 => dac_data_i,
      ready_o                                => dac_ready_o,
      dac_cs_o                               => dac_cs_o,
      dac_sck_o                              => dac_sck_o,
      dac_sdi_o                              => dac_sdi_o
    );

  ---------------------------------------------------------------------------
  --                              Serial regs
  ---------------------------------------------------------------------------

  cmp_rtmlamp_ohwr_serial_regs : rtmlamp_ohwr_serial_regs
  generic map (
    g_CHANNELS                               => g_SERIAL_REGS_AMP_CHANNELS,
    g_CLOCK_FREQ                             => g_SYS_CLOCK_FREQ,
    g_SCLK_FREQ                              => g_SERIAL_REG_SCLK_FREQ
  )
  port map (
    clk_i                                    => clk_i,
    rst_n_i                                  => rst_n_i,

    amp_sta_ctl_rw_i                         => amp_sta_ctl_rw_i,

    amp_status_reg_clk_o                     => amp_shift_clk_o,
    amp_status_reg_out_i                     => amp_shift_dout_i,
    amp_status_reg_pl_o                      => amp_shift_pl_o,

    amp_ctl_reg_oe_n_o                       => amp_shift_oe_n_o,
    amp_ctl_reg_din_o                        => amp_shift_din_o,
    amp_ctl_reg_str_o                        => amp_shift_str_o,

    amp_iflag_l_o                            => amp_iflag_l_o,
    amp_tflag_l_o                            => amp_tflag_l_o,
    amp_iflag_r_o                            => amp_iflag_r_o,
    amp_tflag_r_o                            => amp_tflag_r_o,
    amp_en_ch_i                              => amp_en_ch_i
  );

end rtl;
