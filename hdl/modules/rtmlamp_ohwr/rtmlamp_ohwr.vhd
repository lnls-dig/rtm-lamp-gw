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
  -- Reference clock frequency [Hz], used only when g_USE_REF_CNV is
  -- set to true
  g_REF_CLK_FREQ                             : natural := 50000000;
  -- Wether or not to use a reference clk to drive CNV/LDAC.
  -- If true uses clk_ref_i to drive CNV/LDAC
  -- If false uses clk_i to drive CNV/LDAC
  g_USE_REF_CLK                              : boolean := false;
  -- ADC clock frequency [Hz]. Must be a multiple of g_ADC_SCLK_FREQ
  g_ADC_MASTER_CLOCK_FREQ                    : natural := 200000000;
  -- ADC clock frequency [Hz]
  g_ADC_SCLK_FREQ                            : natural := 100000000;
  -- Number of ADC channels
  g_ADC_CHANNELS                             : natural := 12;
  -- If the ADC inputs are inverted on RTM-LAMP or not
  g_ADC_FIX_INV_INPUTS                       : boolean := false;
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

  clk_ref_i                                  : in   std_logic := '0';
  rst_ref_n_i                                : in   std_logic := '1';

  clk_master_adc_i                           : in   std_logic;
  rst_master_adc_n_i                         : in   std_logic;

  clk_master_dac_i                           : in   std_logic;
  rst_master_dac_n_i                         : in   std_logic;

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
end rtmlamp_ohwr;

architecture rtl of rtmlamp_ohwr is
  constant c_ADC_CNV_HIGH                    : real := 30.0e-9; -- minimum of 30.0e-9
  constant c_ADC_CNV_WAIT                    : real := 450.0e-9; -- minimum of 450.0e-9
  constant c_ADC_BITS                        : natural := 16;
  -- quasi-offset binary to two's complement conversion factor
  constant c_ADC_OFFB_2_TWOSCOMP_CONV        : signed(c_ADC_BITS-1 downto 0) := to_signed(-16384, c_ADC_BITS);

  signal dac_ldac_n                          : std_logic;

  signal adc_data                            : t_16b_word_array(c_MAX_ADC_CHANNELS-1 downto 0);
  signal adc_valid                           : std_logic_vector(c_MAX_ADC_CHANNELS-1 downto 0);

  signal adc_octo_sck                        : std_logic;
  signal adc_octo_sck_ret                    : std_logic;
  signal adc_octo_cnv                        : std_logic;
  signal adc_octo_sdoa                       : std_logic;
  signal adc_octo_sdob                       : std_logic;
  signal adc_octo_sdoc                       : std_logic;
  signal adc_octo_sdod                       : std_logic;

  signal adc_quad_sck                        : std_logic;
  signal adc_quad_sck_ret                    : std_logic;
  signal adc_quad_cnv                        : std_logic;
  signal adc_quad_sdoa                       : std_logic;
  signal adc_quad_sdoc                       : std_logic;

  subtype t_adc_word is std_logic_vector(c_ADC_BITS-1 downto 0);
  type t_adc_word_array is array(natural range <>) of t_adc_word;

  type t_adc_readout is record
    data     : t_adc_word_array(7 downto 0);
    valid    : std_logic;
  end record;

  constant c_DUMMY_ADC_READOUT               : t_adc_readout :=
  (
    data => (others => (others => '0')),
    valid => '0'
  );

  signal adc_octo_raw                        : t_adc_readout;
  signal adc_octo_fix_inv                    : t_adc_readout;
  signal adc_octo_scaled                     : t_adc_readout;

  signal adc_quad_raw                        : t_adc_readout := c_DUMMY_ADC_READOUT;
  signal adc_quad_fix_inv                    : t_adc_readout;
  signal adc_quad_scaled                     : t_adc_readout;
begin

  assert (g_ADC_CHANNELS <= c_MAX_ADC_CHANNELS)
    report "[rtmlamp_ohwr] g_ADC_CHANNELS(" & Integer'image(g_ADC_CHANNELS) &
    ") unsuppoted. Maximum number of g_ADC_CHANNELS = " & Integer'image(c_MAX_ADC_CHANNELS)
    severity failure;

  assert (g_DAC_CHANNELS <= c_MAX_DAC_CHANNELS)
    report "[rtmlamp_ohwr] g_DAC_CHANNELS(" & Integer'image(g_DAC_CHANNELS) &
    ") unsuppoted. Maximum number of g_DAC_CHANNELS = " & Integer'image(c_MAX_DAC_CHANNELS)
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
      g_REF_CLK_CNV_FREQ                   => g_REF_CLK_FREQ,
      g_USE_REF_CLK_CNV                    => g_USE_REF_CLK,
      g_BITS                               => c_ADC_BITS,
      g_CHANNELS                           => 8,
      g_DATA_LINES                         => 4,
      g_CNV_HIGH                           => c_ADC_CNV_HIGH,
      g_CNV_WAIT                           => c_ADC_CNV_WAIT
    )
    port map(
      clk_i                                => clk_master_adc_i,
      rst_n_i                              => rst_master_adc_n_i,

      clk_ref_cnv_i                        => clk_ref_i,
      rst_ref_cnv_n_i                      => rst_ref_n_i,

      start_i                              => adc_start_i,

      cnv_o                                => adc_octo_cnv,
      sck_o                                => adc_octo_sck,
      sck_ret_i                            => adc_octo_sck_ret,
      sdo1a_i                              => adc_octo_sdoa,
      sdo3b_i                              => adc_octo_sdob,
      sdo5c_i                              => adc_octo_sdoc,
      sdo7d_i                              => adc_octo_sdod,

      ch1_o                                => adc_octo_raw.data(0),
      ch2_o                                => adc_octo_raw.data(1),
      ch3_o                                => adc_octo_raw.data(2),
      ch4_o                                => adc_octo_raw.data(3),
      ch5_o                                => adc_octo_raw.data(4),
      ch6_o                                => adc_octo_raw.data(5),
      ch7_o                                => adc_octo_raw.data(6),
      ch8_o                                => adc_octo_raw.data(7),
      valid_o                              => adc_octo_raw.valid
    );

  -- RTM LAMP has a retiming FF with the CNV signal
  -- connected to the CLR_N pin, with an inverter after the Q
  -- output pin, see retiming circuit at 232x datasheet, page 32.
  -- So we must invert the CNV signal here.
  adc_octo_cnv_o <= not adc_octo_cnv;

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

      adc_quad_raw.data(0)   <= (others => '0');
      adc_quad_raw.data(1)   <= (others => '0');
      adc_quad_raw.data(2)   <= (others => '0');
      adc_quad_raw.data(3)   <= (others => '0');
      adc_quad_raw.valid     <= '0';

      adc_quad_cnv <= '0';
      adc_quad_sck <= '0';

  end generate;

  gen_adc_more_than_8_channels : if g_ADC_CHANNELS > 8 generate

    -- RTM LTC2324 operates in LVDS mode, so we always acquire 4 channels
    -- with half the number of data lines (2 channels per data line)
    cmp_ltc2320_acq: ltc232x_acq
      generic map(
        g_CLK_FREQ                           => g_ADC_MASTER_CLOCK_FREQ,
        g_SCLK_FREQ                          => g_ADC_SCLK_FREQ,
        g_REF_CLK_CNV_FREQ                   => g_REF_CLK_FREQ,
        g_USE_REF_CLK_CNV                    => g_USE_REF_CLK,
        g_BITS                               => c_ADC_BITS,
        g_CHANNELS                           => 4,
        g_DATA_LINES                         => 2,
        g_CNV_HIGH                           => c_ADC_CNV_HIGH,
        g_CNV_WAIT                           => c_ADC_CNV_WAIT
      )
      port map(
        clk_i                                => clk_master_adc_i,
        rst_n_i                              => rst_master_adc_n_i,

        clk_ref_cnv_i                        => clk_ref_i,
        rst_ref_cnv_n_i                      => rst_ref_n_i,

        start_i                              => adc_start_i,

        cnv_o                                => adc_quad_cnv,
        sck_o                                => adc_quad_sck,
        sck_ret_i                            => adc_quad_sck_ret,
        sdo1a_i                              => adc_quad_sdoa,
        sdo5c_i                              => adc_quad_sdoc,

        ch1_o                                => adc_quad_raw.data(0),
        ch2_o                                => adc_quad_raw.data(1),
        ch3_o                                => adc_quad_raw.data(2),
        ch4_o                                => adc_quad_raw.data(3),
        valid_o                              => adc_quad_raw.valid
      );

    -- RTM LAMP has a retiming FF with the CNV signal
    -- connected to the CLR_N pin, with an inverter after the Q
    -- output pin, see retiming circuit at 232x datasheet, page 32.
    -- So we must invert the CNV signal here.
    adc_quad_cnv_o <= not adc_quad_cnv;

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

  ----------------------------------------
  -- fix possible inversion on ADC inputs.
  ----------------------------------------
  gen_fix_adc_inversion : if g_ADC_FIX_INV_INPUTS generate

    p_fix_adc_inversion : process(clk_master_adc_i)
    begin
      if rising_edge(clk_master_adc_i) then
        if rst_master_adc_n_i = '0' then
          adc_octo_fix_inv <= c_DUMMY_ADC_READOUT;
          adc_quad_fix_inv <= c_DUMMY_ADC_READOUT;
        else
          for i in 0 to 7 loop
            adc_octo_fix_inv.data(i) <= std_logic_vector(-signed(adc_octo_raw.data(i)));
            adc_quad_fix_inv.data(i) <= std_logic_vector(-signed(adc_quad_raw.data(i)));
          end loop;

          adc_octo_fix_inv.valid <= adc_octo_raw.valid;
          adc_quad_fix_inv.valid <= adc_quad_raw.valid;
        end if;
      end if;
    end process;

  end generate;

  gen_not_fix_adc_inversion : if not g_ADC_FIX_INV_INPUTS generate

    adc_octo_fix_inv <= adc_octo_raw;
    adc_quad_fix_inv <= adc_quad_raw;

  end generate;

  ----------------------------------------
  -- Convert results from quasi-offset binary to twos complement.
  ----------------------------------------

  -- As RTM LAMP only uses half of the input range, the ADC
  -- outputs at this stage would range from ~0 to 2^15-1 (32767).
  -- We say ~0 because the ADC can output values < 0 due to noise
  -- or offsets. So, we need to convert from this quase-offset binary
  -- to two's complement by subtractig half the scale and not by
  -- just using the more efficient XOR to invert the MSB.
  p_conv_full_scale : process(clk_master_adc_i)
  begin
    if rising_edge(clk_master_adc_i) then
      if rst_master_adc_n_i = '0' then
        adc_octo_scaled <= c_DUMMY_ADC_READOUT;
        adc_quad_scaled <= c_DUMMY_ADC_READOUT;
      else
        for i in 0 to 7 loop
          adc_octo_scaled.data(i) <= std_logic_vector(
                                     signed(adc_octo_fix_inv.data(i)) +
                                        c_ADC_OFFB_2_TWOSCOMP_CONV);
          adc_quad_scaled.data(i) <= std_logic_vector(
                                     signed(adc_quad_fix_inv.data(i)) +
                                        c_ADC_OFFB_2_TWOSCOMP_CONV);
        end loop;

        adc_octo_scaled.valid <= adc_octo_fix_inv.valid;
        adc_quad_scaled.valid <= adc_quad_fix_inv.valid;
      end if;
    end if;
  end process;

  ----------------------------------------
  -- Aggregate all data from ADC octo + quad
  ----------------------------------------
  gen_adc_valid : for i in 0 to g_ADC_CHANNELS-1 generate

    gen_adc_valid_up_to_8_channels: if i < 8 generate
      adc_valid(i) <= adc_octo_scaled.valid;
      adc_data(i) <= adc_octo_scaled.data(i);
    end generate;

    gen_adc_valid_more_than_8_channels: if i >= 8 generate
      adc_valid(i) <= adc_quad_scaled.valid;
      adc_data(i) <= adc_quad_scaled.data(i-8);
    end generate;

    adc_data_o(i) <= adc_data(i);
    adc_valid_o(i) <= adc_valid(i);

  end generate;

  ---------------------------------------------------------------------------
  --                              DACs
  ---------------------------------------------------------------------------

  cmp_multi_dac: multi_dac_spi_ldac
    generic map(
      g_CLK_FREQ                             => g_DAC_MASTER_CLOCK_FREQ,
      g_SCLK_FREQ                            => g_DAC_SCLK_FREQ,
      g_REF_CLK_LDAC_FREQ                    => g_REF_CLK_FREQ,
      g_USE_REF_CLK_LDAC                     => g_USE_REF_CLK,
      g_NUM_DACS                             => g_DAC_CHANNELS,
      g_CPOL                                 => false,
      g_LDAC_WIDTH                           => 30.0e-9,
      g_LDAC_WAIT_AFTER_CS                   => 30.0e-9
    )
    port map(
      clk_i                                  => clk_master_dac_i,
      rst_n_i                                => rst_master_dac_n_i,

      clk_ref_ldac_i                         => clk_ref_i,
      rst_ref_ldac_n_i                       => rst_ref_n_i,

      start_i                                => dac_start_i,
      data_i                                 => dac_data_i,
      ready_o                                => dac_ready_o,
      done_pp_o                              => dac_done_pp_o,
      dac_cs_n_o                             => dac_cs_n_o,
      dac_ldac_n_o                           => dac_ldac_n,
      dac_sck_o                              => dac_sck_o,
      dac_sdi_o                              => dac_sdi_o
    );

  -- RTM LAMP has a retiming FF with the LDAC_N signal
  -- connected to the CLR_N pin, with an inverter after the Q
  -- output pin. So we must invert the LDAC_N signal here.
  dac_ldac_n_o <= not dac_ldac_n;

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
