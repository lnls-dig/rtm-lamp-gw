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
use ieee.numeric_std.all;

use work.wishbone_pkg.all;

package rtm_lamp_pkg is
  --------------------------------------------------------------------
  -- Constants
  --------------------------------------------------------------------
  -- Number of bits for PI coeficients. Must match register map!
  constant c_PI_COEFF_BITS                   : natural := 26;
  -- Number of bits for PI setpoint. Must match register map!
  constant c_PI_SP_BITS                      : natural := 16;

  --------------------------------------------------------------------
  -- Types
  --------------------------------------------------------------------
  subtype t_16b_word is std_logic_vector(15 downto 0);
  type t_16b_word_array is array(natural range <>) of t_16b_word;

  subtype t_pi_coeff_word is std_logic_vector(c_PI_COEFF_BITS-1 downto 0);
  type t_pi_coeff_word_array is array(natural range <>) of t_pi_coeff_word;

  subtype t_pi_sp_word is std_logic_vector(c_PI_SP_BITS-1 downto 0);
  type t_pi_sp_word_array is array(natural range <>) of t_pi_sp_word;
  type t_rtmlamp_ch_mode is (OL_MODE, OL_TEST_SQR_MODE, CL_MODE, CL_TEST_SQR_MODE);

  type t_rtmlamp_ch_ctrl_in is record
    -- Power amplifier enable
    amp_en      : std_logic;
    -- Operation mode, open loop, closed loop, test square wave
    mode        : t_rtmlamp_ch_mode;
    -- PI controller proportional constant
    pi_kp       : t_pi_coeff_word;
    -- PI controller integral constant
    pi_ti       : t_pi_coeff_word;
    -- PI controller set point, only used in CL_MODE
    pi_sp       : t_pi_sp_word;
    -- Limit 'a' value, used to set the square-wave range for CL_TEST_SQR_MODE
    -- and OL_TEST_SQR_MODE
    lim_a       : t_pi_sp_word;
    -- Limit 'b' value, used to set the square-wave range for CL_TEST_SQR_MODE
    -- and OL_TEST_SQR_MODE
    lim_b       : t_pi_sp_word;
    -- Counter to generate the time base for the square-wave. Units are half
    -- the period of clk_i
    cnt         : unsigned(21 downto 0);
    -- DAC voltage output, only used in OL_MODE
    dac_data    : t_16b_word;
  end record t_rtmlamp_ch_ctrl_in;
  type t_rtmlamp_ch_ctrl_in_array is array(natural range <>) of t_rtmlamp_ch_ctrl_in;

  type t_rtmlamp_ch_ctrl_out is record
    amp_iflag_l       : std_logic;
    amp_tflag_l       : std_logic;
    amp_iflag_r       : std_logic;
    amp_tflag_r       : std_logic;
    dac_data_eff      : t_16b_word;   -- Effective DAC value
    pi_sp_eff         : t_pi_sp_word; -- Effective SP value
    adc_data          : t_16b_word;
  end record t_rtmlamp_ch_ctrl_out;
  type t_rtmlamp_ch_ctrl_out_array is array(natural range <>) of t_rtmlamp_ch_ctrl_out;

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
    g_SYS_CLOCK_FREQ                         : natural := 100_000_000;
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
    done_cnv_pp_ref_sys_o                    : out std_logic;
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
    clk_i                                      : in  std_logic;
    rst_n_i                                    : in  std_logic;

    clk_ref_i                                  : in  std_logic := '0';
    rst_ref_n_i                                : in  std_logic := '1';

    rst_fast_spi_n_i                           : in  std_logic;
    clk_fast_spi_i                             : in  std_logic;

    ---------------------------------------------------------------------------
    -- Wishbone Control Interface signals
    ---------------------------------------------------------------------------
    wb_slv_i                                   : in  t_wishbone_slave_in;
    wb_slv_o                                   : out t_wishbone_slave_out;

    ---------------------------------------------------------------------------
    -- RTM ADC interface
    ---------------------------------------------------------------------------
    adc_octo_cnv_o                             : out std_logic;
    adc_octo_sck_p_o                           : out std_logic;
    adc_octo_sck_n_o                           : out std_logic;
    adc_octo_sck_ret_p_i                       : in  std_logic;
    adc_octo_sck_ret_n_i                       : in  std_logic;
    adc_octo_sdoa_p_i                          : in  std_logic;
    adc_octo_sdoa_n_i                          : in  std_logic;
    adc_octo_sdob_p_i                          : in  std_logic;
    adc_octo_sdob_n_i                          : in  std_logic;
    adc_octo_sdoc_p_i                          : in  std_logic;
    adc_octo_sdoc_n_i                          : in  std_logic;
    adc_octo_sdod_p_i                          : in  std_logic;
    adc_octo_sdod_n_i                          : in  std_logic;

    -- Only used when g_CHANNELS > 8
    adc_quad_cnv_o                             : out std_logic;
    adc_quad_sck_p_o                           : out std_logic;
    adc_quad_sck_n_o                           : out std_logic;
    adc_quad_sck_ret_p_i                       : in  std_logic := '0';
    adc_quad_sck_ret_n_i                       : in  std_logic := '1';
    adc_quad_sdoa_p_i                          : in  std_logic := '0';
    adc_quad_sdoa_n_i                          : in  std_logic := '1';
    adc_quad_sdoc_p_i                          : in  std_logic := '0';
    adc_quad_sdoc_n_i                          : in  std_logic := '1';

    ---------------------------------------------------------------------------
    -- RTM DAC interface
    ---------------------------------------------------------------------------
    dac_cs_n_o                                 : out std_logic;
    dac_ldac_n_o                               : out std_logic;
    dac_sck_o                                  : out std_logic;
    dac_sdi_o                                  : out std_logic_vector(g_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- RTM Serial registers interface
    ---------------------------------------------------------------------------
    amp_shift_clk_o                            : out std_logic;
    amp_shift_dout_i                           : in  std_logic := '0';
    amp_shift_pl_o                             : out std_logic;

    amp_shift_oe_n_o                           : out std_logic;
    amp_shift_din_o                            : out std_logic;
    amp_shift_str_o                            : out std_logic;

    ---------------------------------------------------------------------------
    -- External triggers for SP and DAC. Clock domain: clk_i
    ---------------------------------------------------------------------------
    trig_i                                     : in  std_logic_vector(g_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- Output triggers for over-current/temperature detection. Clock domain: clk_i
    ---------------------------------------------------------------------------
    trig_o                                     : out std_logic_vector(g_CHANNELS-1 downto 0);

    ---------------------------------------------------------------------------
    -- PI parameters
    ---------------------------------------------------------------------------
    -- External PI setpoint data. It is used when ch.x.ctl.mode (wishbone
    -- register) is set to 0b100
    pi_sp_ext_i                                : in  t_pi_sp_word_array(g_CHANNELS-1 downto 0);
    ---------------------------------------------------------------------------
    -- Interrupts
    ---------------------------------------------------------------------------
    -- This flag will generate a valid signal for one clock cycle after every
    -- update to the amplifier overcurrent and overtemperature flags
    intr_amp_flags_update_o                    : out std_logic := '0';

    ---------------------------------------------------------------------------
    -- Debug data
    ---------------------------------------------------------------------------
    adc_data_o                                 : out t_16b_word_array(g_CHANNELS-1 downto 0);
    pi_sp_eff_o                                : out t_pi_sp_word_array(g_CHANNELS-1 downto 0);
    dac_data_eff_o                             : out t_16b_word_array(g_CHANNELS-1 downto 0);
    data_valid_o                               : out std_logic
  );
  end component;

  --------------------------------------------------------------------
  -- SDB Devices Structures
  --------------------------------------------------------------------

  -- FOFB CC
  constant c_xwb_rtm_lamp_regs_sdb : t_sdb_device := (
    abi_class     => x"0000",                   -- undocumented device
    abi_ver_major => x"02",
    abi_ver_minor => x"03",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"4",                      -- 32-bit port granularity (0100)
    sdb_component => (
    addr_first    => x"0000000000000000",
    addr_last     => x"0000000000000FFF",
    product => (
    vendor_id     => x"1000000000001215",       -- LNLS
    device_id     => x"a1248bec",
    version       => x"00000003",
    date          => x"20211301",
    name          => "LNLS_RTM_LAMP_REGS ")));

end rtm_lamp_pkg;
