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
-- Common gencores
use work.gencores_pkg.all;

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
  -- Number of channels (8 or 12)
  g_CHANNELS                                 : natural := 12;
  -- If the ADC inputs are inverted on RTM-LAMP or not
  g_ADC_FIX_INV_INPUTS                       : boolean := false;
  -- DAC clock frequency [Hz]
  g_DAC_SCLK_FREQ                            : natural := 25000000;
  -- Serial registers clock frequency [Hz]
  g_SERIAL_REG_SCLK_FREQ                     : natural := 100000;
  -- Number of ADC bits
  g_ADC_BITS                                 : natural := 16
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

  -- Only used when g_CHANNELS > 8
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
  dac_sdi_o                                  : out  std_logic_vector(g_CHANNELS-1 downto 0);

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
  -- Channel control
  ---------------------------------------------------------------------------
  ch_ctrl_i                                  : in  t_rtmlamp_ch_ctrl_in_array(g_CHANNELS-1 downto 0);
  ch_ctrl_o                                  : out t_rtmlamp_ch_ctrl_out_array(g_CHANNELS-1 downto 0);
  data_valid_o                               : out std_logic
);
end rtmlamp_ohwr;

architecture rtl of rtmlamp_ohwr is
  constant c_ADC_CNV_HIGH                    : real := 30.0e-9; -- minimum of 30.0e-9
  constant c_ADC_CNV_WAIT                    : real := 450.0e-9; -- minimum of 450.0e-9
  -- quasi-offset binary to two's complement conversion factor
  constant c_ADC_OFFB_2_TWOSCOMP_CONV        : signed(g_ADC_BITS-1 downto 0) := to_signed(-16384, g_ADC_BITS);

  constant c_DAC_LDAC_WIDTH                  : real := 30.0e-9; -- minimum of 30.0e-9
  constant c_DAC_LDAC_WAIT_AFTER_CS          : real := 30.0e-9; -- minimum of 30.0e-9
  constant c_SERIAL_REGS_AMP_CHANNELS        : natural := 12;

  signal dac_ldac_n                          : std_logic;

  signal adc_start                           : std_logic;
  signal adc_ready                           : std_logic;
  signal adc_data                            : t_16b_word_array(g_CHANNELS-1 downto 0);
  signal adc_valid                           : std_logic_vector(g_CHANNELS-1 downto 0);

  signal pi_err                              : t_16b_word_array(g_CHANNELS-1 downto 0);
  signal pi_err_valid                        : std_logic_vector(g_CHANNELS-1 downto 0);

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

  subtype t_adc_word is std_logic_vector(g_ADC_BITS-1 downto 0);
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
  signal adc_octo_raw_flat_data              : std_logic_vector(8*g_ADC_BITS-1 downto 0);
  signal adc_octo_raw_flat_we                : std_logic;
  signal adc_octo_synched_flat_data          : std_logic_vector(8*g_ADC_BITS-1 downto 0);
  signal adc_octo_synched_flat_empty         : std_logic;
  signal adc_octo_synched                    : t_adc_readout;
  signal adc_octo_fix_inv                    : t_adc_readout;
  signal adc_octo_scaled                     : t_adc_readout;
  signal adc_octo_done_cnv_pp                : std_logic;

  signal adc_quad_raw                        : t_adc_readout := c_DUMMY_ADC_READOUT;
  signal adc_quad_raw_flat_data              : std_logic_vector(4*g_ADC_BITS-1 downto 0) := (others => '0');
  signal adc_quad_raw_flat_we                : std_logic := '0';
  signal adc_quad_synched_flat_data          : std_logic_vector(4*g_ADC_BITS-1 downto 0) := (others => '0');
  signal adc_quad_synched_flat_empty         : std_logic := '0';
  signal adc_quad_synched                    : t_adc_readout := c_DUMMY_ADC_READOUT;
  signal adc_quad_fix_inv                    : t_adc_readout;
  signal adc_quad_scaled                     : t_adc_readout;

  signal adc_synched_flat_empty              : std_logic;
  signal adc_synched_flat_rd                 : std_logic;
  signal adc_synched_flat_valid              : std_logic;

  signal dac_start                           : std_logic;
  signal dac_data                            : t_16b_word_array(g_CHANNELS-1 downto 0);
  signal pi_kp                               : t_pi_coeff_word_array(g_CHANNELS-1 downto 0);
  signal pi_ti                               : t_pi_coeff_word_array(g_CHANNELS-1 downto 0);
  signal pi_sp                               : t_pi_sp_word_array(g_CHANNELS-1 downto 0);
  signal amp_enable                          : std_logic_vector(11 downto 0);


  signal dac_data_from_pi                    : t_16b_word_array(g_CHANNELS-1 downto 0);
  signal dac_valid_from_pi                   : std_logic_vector(g_CHANNELS-1 downto 0);

  signal amp_iflag_l                         : std_logic_vector(g_CHANNELS-1 downto 0);
  signal amp_tflag_l                         : std_logic_vector(g_CHANNELS-1 downto 0);
  signal amp_iflag_r                         : std_logic_vector(g_CHANNELS-1 downto 0);
  signal amp_tflag_r                         : std_logic_vector(g_CHANNELS-1 downto 0);

  signal test_waveform                       : t_16b_word_array(g_CHANNELS-1 downto 0);
  signal test_waveform_valid                 : std_logic;

begin

  assert (g_CHANNELS = 8 or g_CHANNELS = 12)
    report "[rtmlamp_ohwr] g_CHANNELS(" & Integer'image(g_CHANNELS) &
    ") unsuppoted. Only 8 or 12 channels are supported."
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
      g_BITS                               => g_ADC_BITS,
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
      done_cnv_pp_ref_sys_o                => adc_octo_done_cnv_pp,
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
    adc_octo_raw_flat_data((i+1)*g_ADC_BITS-1 downto i*g_ADC_BITS) <=
      adc_octo_raw.data(i);
  end generate;

  adc_octo_raw_flat_we <= adc_octo_raw.valid;

  cmp_ltc232x_octo_fifo : inferred_sync_fifo
  generic map
  (
    g_data_width                              => 8*g_ADC_BITS,
    g_size                                    => 4
  )
  port map
  (
    clk_i                                     => clk_i,
    rst_n_i                                   => rst_n_i,
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

  gen_adc_up_to_8_channels : if g_CHANNELS <= 8 generate

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

  gen_adc_more_than_8_channels : if g_CHANNELS > 8 generate

    -- RTM LTC2324 operates in LVDS mode, so we always acquire 4 channels
    -- with half the number of data lines (2 channels per data line)
    cmp_ltc2324_acq: ltc232x_acq
      generic map(
        g_SYS_CLOCK_FREQ                     => g_SYS_CLOCK_FREQ,
        g_CLK_FAST_SPI_FREQ                  => g_CLK_FAST_SPI_FREQ,
        g_SCLK_FREQ                          => g_ADC_SCLK_FREQ,
        g_REF_CLK_CNV_FREQ                   => g_REF_CLK_FREQ,
        g_USE_REF_CLK_CNV                    => g_USE_REF_CLK,
        g_BITS                               => g_ADC_BITS,
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
      adc_quad_raw_flat_data((i+1)*g_ADC_BITS-1 downto i*g_ADC_BITS) <=
        adc_quad_raw.data(i);
    end generate;

    adc_quad_raw_flat_we <= adc_quad_raw.valid;

    cmp_ltc232x_quad_fifo : inferred_sync_fifo
    generic map
    (
      g_data_width                            => 4*g_ADC_BITS,
      g_size                                  => 4
    )
    port map
    (
      clk_i                                   => clk_i,
      rst_n_i                                 => rst_n_i,
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
        adc_start <=  adc_ready; -- FIXME: ADC conversions should start after
                                 -- a integer number of clk_ref_i edges
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
    adc_octo_synched.data(i) <= adc_octo_synched_flat_data((i+1)*g_ADC_BITS-1 downto i*g_ADC_BITS);
  end generate;

  adc_octo_synched.valid <= adc_synched_flat_valid;

  gen_rec_ltc232x_quad : for i in 0 to 3 generate
    adc_quad_synched.data(i) <= adc_quad_synched_flat_data((i+1)*g_ADC_BITS-1 downto i*g_ADC_BITS);
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
  gen_adc_valid : for i in 0 to g_CHANNELS-1 generate

    gen_adc_valid_up_to_8_channels: if i < 8 generate
      adc_valid(i) <= adc_octo_scaled.valid;
      adc_data(i) <= adc_octo_scaled.data(i);
    end generate;

    gen_adc_valid_more_than_8_channels: if i >= 8 generate
      adc_valid(i) <= adc_quad_scaled.valid;
      adc_data(i) <= adc_quad_scaled.data(i-8);
    end generate;

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
      g_NUM_DACS                             => g_CHANNELS,
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
      ready_o                                => open, -- FIXME: dac_ready_o,
      done_pp_o                              => open, -- FIXME: dac_done_pp_o,
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
  gen_pi_controller : for i in 0 to g_CHANNELS-1 generate

    p_err_calc : process(clk_i)
    begin
      if rising_edge(clk_i) then
        if rst_n_i = '0' then
          pi_err(i) <= (others => '0');
          pi_err_valid(i) <= '0';
        else
          pi_err_valid(i) <= adc_octo_done_cnv_pp;
          if adc_octo_done_cnv_pp = '1' then
            pi_err(i) <= std_logic_vector(signed(pi_sp(i)) - signed(adc_data(i)));
          end if;
        end if;
      end if;
    end process;

    cmp_gc_dual_pi_controller : gc_dual_pi_controller
      generic map(
        g_error_bits                       => 16,
        g_dacval_bits                      => 16,
        g_output_bias                      => 32768,
        g_integrator_fracbits              => 16,
        g_integrator_overbits              => 6,
        g_coef_bits                        => c_PI_COEFF_BITS
      )
      port map (
        clk_sys_i                          => clk_i,
        rst_n_sysclk_i                     => rst_n_i,

    -------------------------------------------------------------------------------
    -- Phase & frequency error inputs
    -------------------------------------------------------------------------------

        phase_err_i                        => (others => '0'),
        phase_err_stb_p_i                  => '0',

        freq_err_i                         => pi_err(i),
        freq_err_stb_p_i                   => pi_err_valid(i),

    -- mode select input: 1 = frequency mode, 0 = phase mode
        mode_sel_i                         => '1',

    -------------------------------------------------------------------------------
    -- DAC Output
    -------------------------------------------------------------------------------

        dac_val_o                          => dac_data_from_pi(i),
        dac_val_stb_p_o                    => dac_valid_from_pi(i),

    -------------------------------------------------------------------------------
    -- Wishbone regs
    -------------------------------------------------------------------------------

    -- PLL enable
        pll_pcr_enable_i                   => '1',

    -- PI force freq mode. '1' causes the PI to stay in frequency lock mode all the
    -- time.
        pll_pcr_force_f_i                  => '1',

    -- Frequency Kp/Ki
        pll_fbgr_f_kp_i                    => pi_kp(i),
        pll_fbgr_f_ki_i                    => pi_ti(i),

    -- Phase Kp/Ki
        pll_pbgr_p_kp_i                    => (others => '0'),
        pll_pbgr_p_ki_i                    => (others => '0')
    );
  end generate;

  dac_start <= adc_ready; -- FIXME: dac_valid(0);
  data_valid_o <= adc_ready;

  gen_conn_channels : for i in 0 to g_CHANNELS-1 generate
    -- Raw DAC data to be written
    dac_data(i) <= ch_ctrl_i(i).dac_data xor x"8000" when ch_ctrl_i(i).mode = OL_MODE else
                   test_waveform(i) xor x"8000" when ch_ctrl_i(i).mode = OL_TEST_SQR_MODE else
                   dac_data_from_pi(i); -- Closed loop modes, dac_data comes
                                        -- from the PI controller output

    pi_sp(i) <= ch_ctrl_i(i).pi_sp when ch_ctrl_i(i).mode = CL_MODE else
                test_waveform(i) when ch_ctrl_i(i).mode = CL_TEST_SQR_MODE else
                (others => '0');

    amp_enable(i) <= ch_ctrl_i(i).amp_en;
    pi_kp(i) <= ch_ctrl_i(i).pi_kp;
    pi_ti(i) <= ch_ctrl_i(i).pi_ti;

    ch_ctrl_o(i).adc_data <= adc_data(i);
    ch_ctrl_o(i).dac_data_eff <= dac_data(i) xor x"8000"; -- Convert dac_data
                                                          -- to signed
    ch_ctrl_o(i).pi_sp_eff <= pi_sp(i);
    ch_ctrl_o(i).amp_iflag_l <= amp_iflag_l(i);
    ch_ctrl_o(i).amp_iflag_r <= amp_iflag_r(i);
    ch_ctrl_o(i).amp_tflag_l <= amp_tflag_l(i);
    ch_ctrl_o(i).amp_tflag_r <= amp_tflag_r(i);
  end generate;

  ---------------------------------------------------------------------------
  --                              Square wave
  ---------------------------------------------------------------------------
  gen_test_patterns : for i in 0 to g_CHANNELS-1 generate

    p_patterns : process (clk_i)
      variable sample_period_cnt: unsigned(21 downto 0);
      variable lim_togle: boolean;
    begin
      if rising_edge(clk_i) then
        if rst_n_i = '0' then
          sample_period_cnt := (others => '0');
          lim_togle := false;
        else
          if sample_period_cnt >= ch_ctrl_i(i).cnt then
            sample_period_cnt := (others => '0');
            if lim_togle then
              test_waveform(i) <= ch_ctrl_i(i).lim_b;
              lim_togle := false;
              else
              test_waveform(i) <= ch_ctrl_i(i).lim_a;
              lim_togle := true;
            end if;
            test_waveform_valid <= '1';
          else
            test_waveform_valid <= '0';
            sample_period_cnt := sample_period_cnt + 1;
          end if;
        end if;
      else
      end if;
    end process;

  end generate;

  ---------------------------------------------------------------------------
  --                              Serial regs
  ---------------------------------------------------------------------------

  cmp_rtmlamp_ohwr_serial_regs : rtmlamp_ohwr_serial_regs
  generic map (
    g_CHANNELS                               => c_SERIAL_REGS_AMP_CHANNELS,
    g_CLOCK_FREQ                             => g_SYS_CLOCK_FREQ,
    g_SCLK_FREQ                              => g_SERIAL_REG_SCLK_FREQ
  )
  port map (
    clk_i                                    => clk_i,
    rst_n_i                                  => rst_n_i,

    amp_sta_ctl_rw_i                         => '1',

    amp_status_reg_clk_o                     => amp_shift_clk_o,
    amp_status_reg_out_i                     => amp_shift_dout_i,
    amp_status_reg_pl_o                      => amp_shift_pl_o,

    amp_ctl_reg_oe_n_o                       => amp_shift_oe_n_o,
    amp_ctl_reg_din_o                        => amp_shift_din_o,
    amp_ctl_reg_str_o                        => amp_shift_str_o,

    amp_iflag_l_o                            => amp_iflag_l,
    amp_tflag_l_o                            => amp_tflag_l,
    amp_iflag_r_o                            => amp_iflag_r,
    amp_tflag_r_o                            => amp_tflag_r,
    amp_en_ch_i                              => amp_enable
  );
end rtl;
