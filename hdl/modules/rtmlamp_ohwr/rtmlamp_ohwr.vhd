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
  g_SERIAL_REGS_AMP_CHANNELS                 : natural := 12;
  -- Number of ADC bits
  g_ADC_BITS                                 : natural := 16;
  -- Use Chipscope or not
  g_WITH_CHIPSCOPE                           : boolean := false;
  -- Use VIO or not
  g_WITH_VIO                                 : boolean := false
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

  dbg_dac_start_o                            : out  std_logic;
  dbg_dac_data_o                             : out  t_16b_word_array(g_DAC_CHANNELS-1 downto 0);

  ---------------------------------------------------------------------------
  -- PI parameters
  ---------------------------------------------------------------------------
  -- Kp parameter
  pi_kp_i                                    : in   t_pi_coeff_word_array(g_DAC_CHANNELS-1 downto 0);
  -- Ti parameter
  pi_ti_i                                    : in   t_pi_coeff_word_array(g_DAC_CHANNELS-1 downto 0);
  -- Setpoint parameter
  pi_sp_i                                    : in   t_pi_sp_word_array(g_DAC_CHANNELS-1 downto 0);

  -- select if we want a triangular wave directly at the DAC inputs. Limits defined by
  -- pi_sp_i and pi_sp_lim_inf_i
  pi_ol_mode_triang_enable_i                 : in   std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  -- select if we want a square wave directly at the DAC inputs. Limits defined by
  -- pi_sp_i and pi_sp_lim_inf_i
  pi_ol_mode_square_enable_i                 : in   std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  -- defines the period of both triang/square modes in ADC clock ticks
  pi_ol_dac_mode_counter_max_i               : in   unsigned(21 downto 0);
  -- defines the other limit for triang/square modes. pi_sp_i being one and
  -- pi_sp_lim_inf_i the other
  pi_sp_lim_inf_i                            : in   std_logic_vector(g_ADC_BITS-1 downto 0);

  -- select if we want a square wave at the PI inputs
  pi_sp_mode_square_enable_i                 : in   std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  -- enagble or disable PI controller. if pi_enable_i = 0, then dac_data_i/dac_start_i
  -- takes effect and the RTM board can be controller in open_loop. Otherwise, pi_ol modes
   -- take effect and lastly, if everything = 0, pi_sp_i takes effect to set PI setpoint
  pi_enable_i                                : in   std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  -- debug output to monitor PI Setpoint
  dbg_pi_ctrl_sp_o                           : out  t_pi_sp_word_array(g_DAC_CHANNELS-1 downto 0);

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
  -- quasi-offset binary to two's complement conversion factor
  constant c_ADC_OFFB_2_TWOSCOMP_CONV        : signed(g_ADC_BITS-1 downto 0) := to_signed(-16384, g_ADC_BITS);

  constant c_DAC_LDAC_WIDTH                  : real := 30.0e-9; -- minimum of 30.0e-9
  constant c_DAC_LDAC_WAIT_AFTER_CS          : real := 30.0e-9; -- minimum of 30.0e-9

  signal dac_ldac_n                          : std_logic;

  signal adc_start                           : std_logic;
  signal adc_ready                           : std_logic;
  signal adc_data                            : t_16b_word_array(c_MAX_ADC_CHANNELS-1 downto 0);
  signal adc_valid                           : std_logic_vector(c_MAX_ADC_CHANNELS-1 downto 0);

  signal pi_err                              : t_16b_word_array(c_MAX_ADC_CHANNELS-1 downto 0);
  signal pi_err_valid                        : std_logic_vector(c_MAX_ADC_CHANNELS-1 downto 0);

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
  signal dac_valid                           : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dac_data                            : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);

  subtype t_acc_word is std_logic_vector(g_ADC_BITS*2-1 downto 0);
  type t_acc_word_array is array(natural range <>) of t_acc_word;

  subtype t_sum_word is std_logic_vector(g_ADC_BITS downto 0);
  type t_sum_word_array is array(natural range <>) of t_sum_word;

  signal dbg_pi_err_ti                       : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_ctrl_sp                      : t_pi_sp_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_err_kp                       : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_err_mult_valid               : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  signal dbg_pi_acc                          : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_acc_valid                    : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_ti_shifted                   : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_kp_shifted                   : t_acc_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_shifted_valid                : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_sum                          : t_sum_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dbg_pi_sum_valid                    : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  -----------------------------------------------------------------------------
  -- VIO/ILA signals
  -----------------------------------------------------------------------------

  signal probe_in0                           : std_logic_vector(127 downto 0);
  signal probe_in1                           : std_logic_vector(127 downto 0);

  signal probe_out0                          : std_logic_vector(127 downto 0);
  signal probe_out1                          : std_logic_vector(127 downto 0);

  signal data                                : std_logic_vector(255 downto 0);
  signal trig0                               : std_logic_vector(7 downto 0);

  signal pi_kp                               : t_pi_coeff_word_array(g_DAC_CHANNELS-1 downto 0);
  signal pi_ti                               : t_pi_coeff_word_array(g_DAC_CHANNELS-1 downto 0);
  signal pi_sp                               : t_pi_sp_word_array(g_DAC_CHANNELS-1 downto 0);
  signal pi_sp_lim_inf                       : std_logic_vector(g_ADC_BITS-1 downto 0);
  signal pi_enable                           : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal pi_square_enable                    : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal triang_enable                       : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal square_enable                       : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal pi_ti_shift                         : integer range -(2*g_ADC_BITS) to (2*g_ADC_BITS)-1;
  signal pi_kp_shift                         : integer range -(2*g_ADC_BITS) to (2*g_ADC_BITS)-1;
  signal amp_enable                          : std_logic_vector(11 downto 0);

  signal pi_sp_to_pi                         : t_pi_sp_word_array(g_DAC_CHANNELS-1 downto 0);
  signal pi_sp_from_square                   : t_pi_sp_word_array(g_DAC_CHANNELS-1 downto 0);
  signal pi_sp_from_square_valid             : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dac_ol_data_offset_from_square      : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_ol_valid_offset_from_square     : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal pi_sp_from_square_max_min           : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  signal dac_data_vio                        : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_ol_data_offset                  : t_16b_word_array(g_DAC_CHANNELS-1 downto 0) :=
        (others => std_logic_vector(to_signed(32767, 16)));
  signal dac_ol_valid_offset                 : std_logic;

  signal dac_data_from_pi                    : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_cl_data_offset_from_pi          : t_16b_word_array(g_DAC_CHANNELS-1 downto 0) :=
        (others => std_logic_vector(to_signed(32767, 16)));
  signal dac_valid_from_pi                   : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dac_cl_valid_offset_from_pi         : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  signal dac_data_from_triang                : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_ol_data_offset_from_triang      : t_16b_word_array(g_DAC_CHANNELS-1 downto 0) :=
        (others => std_logic_vector(to_signed(32767, 16)));
  signal dac_valid_from_triang               : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dac_ol_valid_offset_from_triang     : std_logic_vector(g_DAC_CHANNELS-1 downto 0);
  signal dac_mode_counter_max                : unsigned(21 downto 0);
  signal dac_period_counter                  : unsigned(21 downto 0);

  subtype t_dac_counter is  signed(pi_sp'length-1 downto 0);
  type t_dac_counter_array is array(natural range <>) of t_dac_counter;

  signal dac_data_counter                    : t_dac_counter_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_data_counter_up                 : std_logic_vector(g_DAC_CHANNELS-1 downto 0);

  attribute MARK_DEBUG                       : string;
  attribute MARK_DEBUG of pi_kp              : signal is "TRUE";
  attribute MARK_DEBUG of pi_ti              : signal is "TRUE";
  attribute MARK_DEBUG of pi_sp              : signal is "TRUE";
  attribute MARK_DEBUG of pi_sp_lim_inf      : signal is "TRUE";
  attribute MARK_DEBUG of pi_square_enable   : signal is "TRUE";
  attribute MARK_DEBUG of pi_enable          : signal is "TRUE";
  attribute MARK_DEBUG of triang_enable      : signal is "TRUE";
  attribute MARK_DEBUG of square_enable      : signal is "TRUE";
  attribute MARK_DEBUG of dac_data_vio       : signal is "TRUE";
  attribute MARK_DEBUG of dac_ol_data_offset : signal is "TRUE";
  attribute MARK_DEBUG of dac_ol_valid_offset : signal is "TRUE";
  attribute MARK_DEBUG of pi_ti_shift        : signal is "TRUE";
  attribute MARK_DEBUG of pi_kp_shift        : signal is "TRUE";
  attribute MARK_DEBUG of amp_enable         : signal is "TRUE";
  attribute MARK_DEBUG of dbg_pi_err_ti      : signal is "TRUE";
  attribute MARK_DEBUG of dac_mode_counter_max : signal is "TRUE";

  attribute DONT_TOUCH                       : string;
  attribute DONT_TOUCH of pi_kp              : signal is "TRUE";
  attribute DONT_TOUCH of pi_ti              : signal is "TRUE";
  attribute DONT_TOUCH of pi_sp              : signal is "TRUE";
  attribute DONT_TOUCH of pi_sp_lim_inf      : signal is "TRUE";
  attribute DONT_TOUCH of pi_square_enable   : signal is "TRUE";
  attribute DONT_TOUCH of pi_enable          : signal is "TRUE";
  attribute DONT_TOUCH of triang_enable      : signal is "TRUE";
  attribute DONT_TOUCH of square_enable      : signal is "TRUE";
  attribute DONT_TOUCH of dac_data_vio       : signal is "TRUE";
  attribute DONT_TOUCH of dac_ol_data_offset : signal is "TRUE";
  attribute DONT_TOUCH of dac_ol_valid_offset : signal is "TRUE";
  attribute DONT_TOUCH of pi_ti_shift        : signal is "TRUE";
  attribute DONT_TOUCH of pi_kp_shift        : signal is "TRUE";
  attribute DONT_TOUCH of amp_enable         : signal is "TRUE";
  attribute DONT_TOUCH of dbg_pi_err_ti      : signal is "TRUE";
  attribute DONT_TOUCH of dac_mode_counter_max : signal is "TRUE";

  function f_replicate(x : std_logic; len : natural)
    return std_logic_vector
  is
    variable v_ret : std_logic_vector(len-1 downto 0) := (others => x);
  begin
    return v_ret;
  end f_replicate;

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
  gen_pi_controller : for i in 0 to g_DAC_CHANNELS-1 generate

    p_err_calc : process(clk_i)
    begin
      if rising_edge(clk_i) then
        if rst_n_i = '0' then
          pi_err(i) <= (others => '0');
          pi_err_valid(i) <= '0';
        else
          pi_err_valid(i) <= adc_octo_done_cnv_pp;
          if adc_octo_done_cnv_pp = '1' then
            pi_err(i) <= std_logic_vector(signed(pi_sp_to_pi(i)) - signed(adc_data(i)));
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

  dac_start <= dac_valid(0);

  gen_dac_data : for i in 0 to g_DAC_CHANNELS-1 generate

    -- already biased
    dac_cl_data_offset_from_pi(i) <= dac_data_from_pi(i);
    dac_cl_valid_offset_from_pi(i) <= dac_valid_from_pi(i);

    dac_ol_data_offset_from_triang(i) <= std_logic_vector(dac_data_from_triang(i) xor
                                                            ('1' & f_replicate('0', dac_data_from_triang(i)'length-1)));
    dac_ol_valid_offset_from_triang(i) <= dac_valid_from_triang(i);

    dac_ol_data_offset_from_square(i) <= std_logic_vector(pi_sp_from_square(i) xor
                                                            ('1' & f_replicate('0', pi_sp_from_square(i)'length-1)));
    dac_ol_valid_offset_from_square(i) <= pi_sp_from_square_valid(i);

    dac_data(i) <= dac_cl_data_offset_from_pi(i) when pi_enable(i) = '1' else
                   dac_ol_data_offset_from_triang(i) when triang_enable(i) = '1' else
                   dac_ol_data_offset_from_square(i) when square_enable(i) = '1' else
                   dac_ol_data_offset(i);
    dac_valid(i) <= dac_cl_valid_offset_from_pi(i) when pi_enable(i) = '1' else
                    dac_ol_valid_offset_from_triang(i) when triang_enable(i) = '1' else
                    dac_ol_valid_offset_from_square(i) when square_enable(i) = '1' else
                    dac_ol_valid_offset;

    pi_sp_to_pi(i) <= pi_sp_from_square(i) when pi_square_enable(i) = '1' else
                      pi_sp(i);

  end generate;

  dbg_pi_ctrl_sp <= pi_sp_to_pi;

  dbg_dac_start_o <= dac_start;

  gen_dac_data_dbg : for i in 0 to g_DAC_CHANNELS-1 generate
    dbg_dac_data_o(i)  <= std_logic_vector(dac_data(i) xor x"8000");
  end generate;

  dbg_pi_ctrl_sp_o <= dbg_pi_ctrl_sp;

  ---------------------------------------------------------------------------
  --                              Triang wave
  ---------------------------------------------------------------------------
  gen_test_patterns : for i in 0 to g_DAC_CHANNELS-1 generate

    p_patterns : process (clk_i)
    begin
      if rising_edge(clk_i) then
        if rst_n_i = '0' then
          dac_data_from_triang(i) <= (others => '0');
          dac_valid_from_triang(i) <= '0';
          dac_period_counter <= (others => '0');
          pi_sp_from_square(i) <= (others => '0');
          pi_sp_from_square_valid(i) <= '0';
          pi_sp_from_square_max_min(i) <= '0';
          dac_data_counter(i) <= (others => '0');
          dac_data_counter_up(i) <= '1';
        else
          if dac_period_counter = dac_mode_counter_max then
            dac_period_counter <= (others => '0');
            dac_valid_from_triang(i) <= '1';
            dac_data_from_triang(i) <= std_logic_vector(dac_data_counter(i));

            pi_sp_from_square_max_min(i) <= not pi_sp_from_square_max_min(i);
            pi_sp_from_square_valid(i) <= '1';
            if pi_sp_from_square_max_min(i) = '0' then
              pi_sp_from_square(i) <= pi_sp(i);
            else
              pi_sp_from_square(i) <= pi_sp_lim_inf;
            end if;

            if dac_data_counter_up(i) = '1' then
              dac_data_counter(i) <= dac_data_counter(i) + 1;
              if dac_data_counter(i) = to_integer(signed(pi_sp(i))) then
                dac_data_counter_up(i) <= '0';
                dac_data_counter(i) <= dac_data_counter(i) - 1;
              end if;
            else
              dac_data_counter(i) <= dac_data_counter(i) - 1;
              if dac_data_counter(i) = to_integer(signed(pi_sp_lim_inf)) then
                dac_data_counter_up(i) <= '1';
                dac_data_counter(i) <= dac_data_counter(i) + 1;
              end if;
            end if;

          else
            pi_sp_from_square_valid(i) <= '0';
            dac_period_counter <= dac_period_counter + 1;
            dac_valid_from_triang(i) <= '0';
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
    amp_en_ch_i                              => amp_enable
  );

  ------------------------------------------------------------------------
  ----                          Chipscope                               --
  ------------------------------------------------------------------------

  gen_with_chipscope : if g_WITH_CHIPSCOPE generate

    ila_core_inst : entity work.ila_t8_d256_s8192_cap
    port map (
      clk             => clk_i,
      probe0          => data,
      probe1          => trig0
    );

    trig0(0)          <= adc_valid(0);
    trig0(1)          <= dac_start;
    trig0(2)          <= '0';
    trig0(3)          <= '0';
    trig0(4)          <= '0';
    trig0(5)          <= '0';
    trig0(6)          <= '0';
    trig0(7)          <= '0';

    data(0)           <= adc_valid(0);
    data(1)           <= dac_start;
    data(2)           <= '0';
    data(3)           <= '0';
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
    data(175 downto 144) <= (others => '0');
    data(192 downto 176) <= (others => '0');

    data(223 downto 193) <= (others => '0');
    data(254 downto 224) <= (others => '0');
    data(255)            <= '0';

  end generate;

  ------------------------------------------------------------------------
  ----                          VIO                                     --
  ------------------------------------------------------------------------

  gen_with_vio : if g_WITH_VIO generate

    cmp_vio_din2_w128_dout2_w128 : entity work.vio_din2_w128_dout2_w128
    port map (
      clk                                      => clk_i,
      probe_in0                                => probe_in0,
      probe_in1                                => probe_in1,
      probe_out0                               => probe_out0,
      probe_out1                               => probe_out1
    );

    probe_in0 <= (others => '0');
    probe_in1 <= (others => '0');

    gen_pi_params_ch : for i in 0 to g_DAC_CHANNELS-1 generate
      pi_kp(i)             <= probe_out0(25 downto 0);
      pi_ti(i)             <= probe_out0(51 downto 26);
      pi_sp(i)             <= probe_out0(67 downto 52);
    end generate;

    dac_mode_counter_max   <= unsigned(probe_out0(89 downto 68));
    amp_enable             <= probe_out0(101 downto 90);
    pi_enable              <= probe_out0(113 downto 102);
    triang_enable          <= probe_out0(125 downto 114);
    dac_ol_valid_offset    <= probe_out0(126);

    dac_data_vio(0)        <= probe_out1(15 downto 0);
    dac_data_vio(1)        <= probe_out1(31 downto 16);
    dac_data_vio(2)        <= probe_out1(47 downto 32);
    dac_data_vio(3)        <= probe_out1(63 downto 48);
    pi_square_enable       <= probe_out1(75 downto 64);
    pi_sp_lim_inf          <= probe_out1(91 downto 76);
    square_enable          <= probe_out1(103 downto 92);

    dac_ol_data_offset(0)  <= std_logic_vector(dac_data_vio(0) xor x"8000");
    dac_ol_data_offset(1)  <= std_logic_vector(dac_data_vio(1) xor x"8000");
    dac_ol_data_offset(2)  <= std_logic_vector(dac_data_vio(2) xor x"8000");
    dac_ol_data_offset(3)  <= std_logic_vector(dac_data_vio(3) xor x"8000");

  end generate;

  gen_without_vio : if not g_WITH_VIO generate

    pi_kp                  <= pi_kp_i;
    pi_ti                  <= pi_ti_i;
    pi_sp                  <= pi_sp_i;

    amp_enable             <= amp_en_ch_i;
    pi_enable              <= pi_enable_i;

    triang_enable          <= pi_ol_mode_triang_enable_i;
    square_enable          <= pi_ol_mode_square_enable_i;
    dac_mode_counter_max   <= pi_ol_dac_mode_counter_max_i;

    pi_square_enable       <= pi_sp_mode_square_enable_i;
    pi_sp_lim_inf          <= pi_sp_lim_inf_i;

    gen_dac_ol_data_offset : for i in 0 to g_DAC_CHANNELS-1 generate
      dac_ol_data_offset(i) <= std_logic_vector(dac_data_i(i) xor x"8000");
    end generate;

    dac_ol_valid_offset    <= dac_start_i;

  end generate;

end rtl;
