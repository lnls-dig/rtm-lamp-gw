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
-- Genrams
use work.genram_pkg.all;

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
end rtmlamp_ohwr;

architecture rtl of rtmlamp_ohwr is
  constant c_ADC_CNV_HIGH                    : real := 30.0e-9; -- minimum of 30.0e-9
  constant c_ADC_CNV_WAIT                    : real := 450.0e-9; -- minimum of 450.0e-9
  constant c_ADC_BITS                        : natural := 16;
  -- quasi-offset binary to two's complement conversion factor
  constant c_ADC_OFFB_2_TWOSCOMP_CONV        : signed(c_ADC_BITS-1 downto 0) := to_signed(-16384, c_ADC_BITS);

  constant c_DAC_LDAC_WIDTH                  : real := 100.0e-9; -- minimum of 30.0e-9
  constant c_DAC_LDAC_WAIT_AFTER_CS          : real := 100.0e-9; -- minimum of 30.0e-9

  signal dac_ldac_n                          : std_logic;

  signal adc_start                           : std_logic;
  signal adc_ready                           : std_logic;
  signal adc_data                            : t_16b_word_array(c_MAX_ADC_CHANNELS-1 downto 0);
  signal adc_valid                           : std_logic_vector(c_MAX_ADC_CHANNELS-1 downto 0);

  signal adc_octo_ready                      : std_logic;
  signal adc_octo_sck                        : std_logic;
  signal adc_octo_sck_ret                    : std_logic;
  signal adc_octo_cnv                        : std_logic;
  signal adc_octo_sdoa                       : std_logic;
  signal adc_octo_sdob                       : std_logic;
  signal adc_octo_sdoc                       : std_logic;
  signal adc_octo_sdod                       : std_logic;

  signal adc_quad_ready                      : std_logic := '1';
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
  signal adc_octo_raw_flat_data              : std_logic_vector(8*c_ADC_BITS-1 downto 0);
  signal adc_octo_raw_flat_we                : std_logic;
  signal adc_octo_synched_flat_data          : std_logic_vector(8*c_ADC_BITS-1 downto 0);
  signal adc_octo_synched_flat_empty         : std_logic;
  signal adc_octo_synched                    : t_adc_readout;
  signal adc_octo_fix_inv                    : t_adc_readout;
  signal adc_octo_scaled                     : t_adc_readout;

  signal adc_quad_raw                        : t_adc_readout := c_DUMMY_ADC_READOUT;
  signal adc_quad_raw_flat_data              : std_logic_vector(4*c_ADC_BITS-1 downto 0) := (others => '0');
  signal adc_quad_raw_flat_we                : std_logic := '0';
  signal adc_quad_synched_flat_data          : std_logic_vector(4*c_ADC_BITS-1 downto 0) := (others => '0');
  signal adc_quad_synched_flat_empty         : std_logic := '0';
  signal adc_quad_synched                    : t_adc_readout := c_DUMMY_ADC_READOUT;
  signal adc_quad_fix_inv                    : t_adc_readout;
  signal adc_quad_scaled                     : t_adc_readout;

  signal adc_synched_flat_empty              : std_logic;
  signal adc_synched_flat_rd                 : std_logic;
  signal adc_synched_flat_valid              : std_logic;

  signal dac_start                           : std_logic;
  signal dac_valid                           : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dac_data                            : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);

  subtype t_acc_word is std_logic_vector(c_ADC_BITS*2-1 downto 0);
  type t_acc_word_array is array(natural range <>) of t_acc_word;

  subtype t_sum_word is std_logic_vector(c_ADC_BITS downto 0);
  type t_sum_word_array is array(natural range <>) of t_sum_word;

  signal dbg_pi_err_ti                       : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_err_kp                       : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_err_mult_valid               : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  signal dbg_pi_acc                          : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_acc_valid                    : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_acc_shifted                  : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_acc_shifted_valid            : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_sum                          : t_sum_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_sum_valid                    : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  -----------------------------------------------------------------------------
  -- VIO/ILA signals
  -----------------------------------------------------------------------------

  signal probe_in0                           : std_logic_vector(63 downto 0);
  signal probe_in1                           : std_logic_vector(63 downto 0);

  signal probe_out0                          : std_logic_vector(63 downto 0);
  signal probe_out1                          : std_logic_vector(63 downto 0);

  signal data                                : std_logic_vector(255 downto 0);
  signal trig0                               : std_logic_vector(7 downto 0);

  signal pi_kp                               : std_logic_vector(c_ADC_BITS-1 downto 0);
  signal pi_ti                               : std_logic_vector(c_ADC_BITS-1 downto 0);
  signal pi_sp                               : std_logic_vector(c_ADC_BITS-1 downto 0);
  signal pi_enable                           : std_logic;
  signal pi_acc_shift                        : integer range 0 to (2*c_ADC_BITS)-1;

  signal dac_data_vio                        : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_data_offset                     : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_valid_vio                       : std_logic;

  signal dac_data_from_pi                    : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_data_offset_from_pi             : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_valid_from_pi                   : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dac_valid_offset_from_pi            : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  attribute MARK_DEBUG                       : string;
  attribute MARK_DEBUG of pi_kp              : signal is "TRUE";
  attribute MARK_DEBUG of pi_ti              : signal is "TRUE";
  attribute MARK_DEBUG of pi_sp              : signal is "TRUE";
  attribute MARK_DEBUG of pi_enable          : signal is "TRUE";
  attribute MARK_DEBUG of dac_data_vio       : signal is "TRUE";
  attribute MARK_DEBUG of dac_data_offset    : signal is "TRUE";
  attribute MARK_DEBUG of dac_valid_vio      : signal is "TRUE";
  attribute MARK_DEBUG of pi_acc_shift       : signal is "TRUE";
  attribute MARK_DEBUG of dbg_pi_err_ti      : signal is "TRUE";

  attribute DONT_TOUCH                       : string;
  attribute DONT_TOUCH of pi_kp              : signal is "TRUE";
  attribute DONT_TOUCH of pi_ti              : signal is "TRUE";
  attribute DONT_TOUCH of pi_sp              : signal is "TRUE";
  attribute DONT_TOUCH of pi_enable          : signal is "TRUE";
  attribute DONT_TOUCH of dac_data_vio       : signal is "TRUE";
  attribute DONT_TOUCH of dac_data_offset    : signal is "TRUE";
  attribute DONT_TOUCH of dac_valid_vio      : signal is "TRUE";
  attribute DONT_TOUCH of pi_acc_shift       : signal is "TRUE";
  attribute DONT_TOUCH of dbg_pi_err_ti      : signal is "TRUE";

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
      g_SYS_CLOCK_FREQ                     => g_SYS_CLOCK_FREQ,
      g_CLK_FAST_SPI_FREQ                  => g_CLK_FAST_SPI_FREQ,
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
      rst_fast_spi_n_i                     => rst_fast_spi_n_i,
      clk_fast_spi_i                       => clk_fast_spi_i,

      clk_i                                => clk_i,
      rst_n_i                              => rst_n_i,

      clk_ref_cnv_i                        => clk_ref_i,
      rst_ref_cnv_n_i                      => rst_ref_n_i,

      start_i                              => adc_start,

      ready_o                              => adc_octo_ready,
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

  gen_flat_ltc232x_octo : for i in 0 to 7 generate
    adc_octo_raw_flat_data((i+1)*c_ADC_BITS-1 downto i*c_ADC_BITS) <=
      adc_octo_raw.data(i);
  end generate;

  adc_octo_raw_flat_we <= adc_octo_raw.valid;

  cmp_ltc232x_octo_fifo : inferred_sync_fifo
  generic map
  (
    g_data_width                              => 8*c_ADC_BITS,
    g_size                                    => 4
  )
  port map
  (
    clk_i                                     => clk_i,
    d_i                                       => adc_octo_raw_flat_data,
    we_i                                      => adc_octo_raw_flat_we,

    q_o                                       => adc_octo_synched_flat_data,
    rd_i                                      => adc_synched_flat_rd,
    empty_o                                   => adc_octo_synched_flat_empty
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

      adc_quad_raw.data(0)   <= (others => '0');
      adc_quad_raw.data(1)   <= (others => '0');
      adc_quad_raw.data(2)   <= (others => '0');
      adc_quad_raw.data(3)   <= (others => '0');
      adc_quad_raw.valid     <= '0';

      adc_quad_ready <= '1';
      adc_quad_cnv <= '0';
      adc_quad_sck <= '0';

      adc_quad_synched_flat_data <= (others => '0');
      adc_quad_synched_flat_empty <= '0';

  end generate;

  gen_adc_more_than_8_channels : if g_ADC_CHANNELS > 8 generate

    -- RTM LTC2324 operates in LVDS mode, so we always acquire 4 channels
    -- with half the number of data lines (2 channels per data line)
    cmp_ltc2320_acq: ltc232x_acq
      generic map(
        g_SYS_CLOCK_FREQ                     => g_SYS_CLOCK_FREQ,
        g_CLK_FAST_SPI_FREQ                  => g_CLK_FAST_SPI_FREQ,
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
        rst_fast_spi_n_i                     => rst_fast_spi_n_i,
        clk_fast_spi_i                       => clk_fast_spi_i,

        clk_i                                => clk_i,
        rst_n_i                              => rst_n_i,

        clk_ref_cnv_i                        => clk_ref_i,
        rst_ref_cnv_n_i                      => rst_ref_n_i,

        start_i                              => adc_start,

        ready_o                              => adc_quad_ready,
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

    gen_flat_ltc232x_quad : for i in 0 to 3 generate
      adc_quad_raw_flat_data((i+1)*c_ADC_BITS-1 downto i*c_ADC_BITS) <=
        adc_quad_raw.data(i);
    end generate;

    adc_quad_raw_flat_we <= adc_quad_raw.valid;

    cmp_ltc232x_quad_fifo : inferred_sync_fifo
    generic map
    (
      g_data_width                            => 4*c_ADC_BITS,
      g_size                                  => 4
    )
    port map
    (
      clk_i                                   => clk_i,
      d_i                                     => adc_quad_raw_flat_data,
      we_i                                    => adc_quad_raw_flat_we,

      q_o                                     => adc_quad_synched_flat_data,
      rd_i                                    => adc_synched_flat_rd,
      empty_o                                 => adc_quad_synched_flat_empty
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

  adc_ready <= adc_octo_ready and adc_quad_ready;

  ----------------------------------------
  -- ADC start when both are ready
  ----------------------------------------
  p_gen_adc_start_valid: process (clk_i)
  begin
    if rising_edge (clk_i) then
      if rst_n_i = '0' then
        adc_start <= '0';
      else
        adc_start <= adc_start_i and adc_ready;
      end if;
    end if;
  end process;

  ----------------------------------------
  -- Aggregate OCTO/QUAD ADC data to a single stream
  ----------------------------------------

  adc_synched_flat_empty <= adc_octo_synched_flat_empty or adc_quad_synched_flat_empty;
  adc_synched_flat_rd <= '1' when adc_synched_flat_empty = '0' else '0';

  p_gen_adc_synched_valid: process (clk_i)
  begin
    if rising_edge (clk_i) then
      adc_synched_flat_valid <= adc_synched_flat_rd;

      if adc_synched_flat_empty = '1' then
        adc_synched_flat_valid <= '0';
      end if;
    end if;
  end process;

  gen_rec_ltc232x_octo : for i in 0 to 7 generate
    adc_octo_synched.data(i) <= adc_octo_synched_flat_data((i+1)*c_ADC_BITS-1 downto i*c_ADC_BITS);
  end generate;

  adc_octo_synched.valid <= adc_synched_flat_valid;

  gen_rec_ltc232x_quad : for i in 0 to 3 generate
    adc_quad_synched.data(i) <= adc_quad_synched_flat_data((i+1)*c_ADC_BITS-1 downto i*c_ADC_BITS);
  end generate;

  adc_quad_synched.valid <= adc_synched_flat_valid;

  ----------------------------------------
  -- fix possible inversion on ADC inputs.
  ----------------------------------------
  gen_fix_adc_inversion : if g_ADC_FIX_INV_INPUTS generate

    p_fix_adc_inversion : process(clk_i)
    begin
      if rising_edge(clk_i) then
        if rst_n_i = '0' then
          adc_octo_fix_inv <= c_DUMMY_ADC_READOUT;
          adc_quad_fix_inv <= c_DUMMY_ADC_READOUT;
        else
          for i in 0 to 7 loop
            adc_octo_fix_inv.data(i) <= std_logic_vector(-signed(adc_octo_synched.data(i)));
            adc_quad_fix_inv.data(i) <= std_logic_vector(-signed(adc_quad_synched.data(i)));
          end loop;

          adc_octo_fix_inv.valid <= adc_octo_synched.valid;
          adc_quad_fix_inv.valid <= adc_quad_synched.valid;
        end if;
      end if;
    end process;

  end generate;

  gen_not_fix_adc_inversion : if not g_ADC_FIX_INV_INPUTS generate

    adc_octo_fix_inv <= adc_octo_synched;
    adc_quad_fix_inv <= adc_quad_synched;

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
  p_conv_full_scale : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
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
      g_CLK_FREQ                             => g_SYS_CLOCK_FREQ,
      g_SCLK_FREQ                            => g_DAC_SCLK_FREQ,
      g_REF_CLK_LDAC_FREQ                    => g_REF_CLK_FREQ,
      g_USE_REF_CLK_LDAC                     => g_USE_REF_CLK,
      g_NUM_DACS                             => g_DAC_CHANNELS,
      g_CPOL                                 => false,
      g_LDAC_WIDTH                           => c_DAC_LDAC_WIDTH,
      g_LDAC_WAIT_AFTER_CS                   => c_DAC_LDAC_WAIT_AFTER_CS
    )
    port map(
      clk_i                                  => clk_i,
      rst_n_i                                => rst_n_i,

      clk_ref_ldac_i                         => clk_ref_i,
      rst_ref_ldac_n_i                       => rst_ref_n_i,

      start_i                                => dac_start,
      data_i                                 => dac_data,
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
  --                              PI Controller
  ---------------------------------------------------------------------------
  gen_pi_controller : for i in 0 to g_ADC_CHANNELS-1 generate
    cmp_pi_controller : pi_controller
      generic map (
        g_PRECISION                          => c_ADC_BITS
      )
      port map (
        rst_n_i                              => rst_n_i,
        clk_i                                => clk_i,

        kp_i                                 => pi_kp,
        ti_i                                 => pi_ti,
        acc_shift_i                          => pi_acc_shift,

        ctrl_sp_i                            => pi_sp,

        ctrl_fb_i                            => adc_data(i),
        ctrl_fb_valid_i                      => adc_valid(i),

        ctrl_sig_o                           => dac_data_from_pi(i),
        ctrl_sig_valid_o                     => dac_valid_from_pi(i),

        dbg_err_ti_o                         => dbg_pi_err_ti(i),
        dbg_err_kp_o                         => dbg_pi_err_kp(i),
        dbg_err_mult_valid_o                 => dbg_pi_err_mult_valid(i),
        dbg_acc_o                            => dbg_pi_acc(i),
        dbg_acc_valid_o                      => dbg_pi_acc_valid(i),
        dbg_acc_shifted_o                    => dbg_pi_acc_shifted(i),
        dbg_acc_shifted_valid_o              => dbg_pi_acc_shifted_valid(i),
        dbg_sum_o                            => dbg_pi_sum(i),
        dbg_sum_valid_o                      => dbg_pi_sum_valid(i)
      );
  end generate;

  dac_start <= dac_valid(0);

  gen_dac_data_from_pi : for i in 0 to g_DAC_CHANNELS-1 generate

    dac_data_offset_from_pi(i) <= std_logic_vector(32768 + signed(dac_data_from_pi(i)));
    dac_valid_offset_from_pi(i) <= dac_valid_from_pi(i);

    dac_data(i) <= dac_data_offset_from_pi(i) when pi_enable = '1' else dac_data_offset(i);
    dac_valid(i) <= dac_valid_offset_from_pi(i) when pi_enable = '1' else dac_valid_vio;

  end generate;

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

  ila_core_inst : entity work.ila_t8_d256_s8192_cap
  port map (
    clk             => clk_i,
    probe0          => data,
    probe1          => trig0
  );

  trig0(0)          <= adc_valid(0);
  trig0(1)          <= dac_start;
  trig0(2)          <= dbg_pi_acc_valid(0);
  trig0(3)          <= dbg_pi_sum_valid(0);
  trig0(4)          <= '0';
  trig0(5)          <= '0';
  trig0(6)          <= '0';
  trig0(7)          <= '0';

  data(0)           <= adc_valid(0);
  data(1)           <= dac_start;
  data(2)           <= dbg_pi_acc_valid(0);
  data(3)           <= dbg_pi_sum_valid(0);
  data(4)           <= '0';
  data(5)           <= '0';
  data(6)           <= '0';
  data(7)           <= '0';
  data(15 downto 8) <= (others => '0');

  data(31 downto 16)   <= adc_data(0);
  data(47 downto 32)   <= adc_data(1);
  data(63 downto 48)   <= adc_data(2);
  data(79 downto 64)   <= adc_data(3);
  data(95 downto 80)   <= dac_data(0);
  data(111 downto 96)  <= dac_data(1);
  data(127 downto 112) <= dac_data(2);
  data(143 downto 128) <= dac_data(3);
  data(175 downto 144) <= dbg_pi_acc(0);
  data(192 downto 176) <= dbg_pi_sum(0);

  data(223 downto 193) <= std_logic_vector(resize(signed(dbg_pi_err_ti(0)), 31));
  data(254 downto 224) <= std_logic_vector(resize(signed(dbg_pi_acc_shifted(0)), 31));
  data(255)            <= '0';

  ------------------------------------------------------------------------
  ----                          VIO                                     --
  ------------------------------------------------------------------------
  cmp_vio_din2_w64_dout2_w64 : entity work.vio_din2_w64_dout2_w64
  port map (
    clk                                      => clk_i,
    probe_in0                                => probe_in0,
    probe_in1                                => probe_in1,
    probe_out0                               => probe_out0,
    probe_out1                               => probe_out1
  );

  probe_in0(63 downto 0) <= (others => '0');
  probe_in1(63 downto 0) <= (others => '0');

  pi_kp         <= probe_out0(15 downto 0);
  pi_ti         <= probe_out0(31 downto 16);
  pi_sp         <= probe_out0(47 downto 32);
  pi_enable     <= probe_out0(48);
  dac_valid_vio <= probe_out0(49);

  pi_acc_shift <= to_integer(unsigned(probe_out0(56 downto 50)));

  dac_data_vio(0) <= probe_out1(15 downto 0);
  dac_data_vio(1) <= probe_out1(31 downto 16);
  dac_data_vio(2) <= probe_out1(47 downto 32);
  dac_data_vio(3) <= probe_out1(63 downto 48);

  dac_data_offset(0)  <= std_logic_vector(32768 + signed(dac_data_vio(0)));
  dac_data_offset(1)  <= std_logic_vector(32768 + signed(dac_data_vio(1)));
  dac_data_offset(2)  <= std_logic_vector(32768 + signed(dac_data_vio(2)));
  dac_data_offset(3)  <= std_logic_vector(32768 + signed(dac_data_vio(3)));

end rtl;
