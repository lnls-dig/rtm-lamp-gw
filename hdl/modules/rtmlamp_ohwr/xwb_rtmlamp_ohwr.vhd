------------------------------------------------------------------------------
-- Title      : XWB RTM LAMP interface
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
-- reduce OR
use work.gencores_pkg.all;

entity xwb_rtmlamp_ohwr is
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
  -- DAC clock frequency [Hz]. Must be a multiple of g_DAC_SCLK_FREQ
  g_DAC_MASTER_CLOCK_FREQ                    : natural := 100000000;
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

  clk_master_adc_i                           : in   std_logic;
  rst_master_adc_n_i                         : in   std_logic;

  clk_master_dac_i                           : in   std_logic;
  rst_master_dac_n_i                         : in   std_logic;

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
end xwb_rtmlamp_ohwr;

architecture rtl of xwb_rtmlamp_ohwr is

  -----------------------------
  -- General Constants
  -----------------------------
  -- Number of bits in Wishbone register interface. Plus 2 to account for BYTE addressing
  constant c_PERIPH_ADDR_SIZE               : natural := 7+2;
  -- Maximum number os channels
  constant c_MAX_CHANNELS                   : natural := 12;

  -----------------------------
  -- RTM signals
  -----------------------------
  signal dac_data                           : t_16b_word_array(g_DAC_CHANNELS-1 downto 0);
  signal dac_start                          : std_logic;
  signal dac_data_from_wb                   : std_logic;
  signal dac_data_wb                        : t_16b_word_array(c_MAX_CHANNELS-1 downto 0) := (others => (others =>'0'));
  signal dac_wr_wb                          : std_logic_vector(c_MAX_CHANNELS-1 downto 0) := (others => '0');

  signal amp_iflag_l                        : std_logic_vector(c_MAX_CHANNELS-1 downto 0) := (others => '0');
  signal amp_tflag_l                        : std_logic_vector(c_MAX_CHANNELS-1 downto 0) := (others => '0');
  signal amp_iflag_r                        : std_logic_vector(c_MAX_CHANNELS-1 downto 0) := (others => '0');
  signal amp_tflag_r                        : std_logic_vector(c_MAX_CHANNELS-1 downto 0) := (others => '0');
  signal amp_en_ch                          : std_logic_vector(c_MAX_CHANNELS-1 downto 0) := (others => '0');

  type wb_channel_in_regs is record
    sta_amp_iflag_l  : std_logic;
    sta_amp_tflag_l  : std_logic;
    sta_amp_iflag_r  : std_logic;
    sta_amp_tflag_r  : std_logic;
  end record;

  type wb_channel_in_regs_array is array(natural range <>) of wb_channel_in_regs;

  type wb_channel_out_regs is record
    ctl_amp_en    : std_logic;
    dac_data      : t_16b_word;
    dac_wr        : std_logic;
  end record;

  type wb_channel_out_regs_array is array(natural range <>) of wb_channel_out_regs;

  type wb_out_regs is record
    dac_data_from_wb  : std_logic;
  end record;

  signal wb_regs_channel_in                     : wb_channel_in_regs_array(c_MAX_CHANNELS-1 downto 0);
  signal wb_regs_channel_out                    : wb_channel_out_regs_array(c_MAX_CHANNELS-1 downto 0);

  signal wb_regs_out                            : wb_out_regs;

  -----------------------------
  -- Wishbone slave adapter signals/structures
  -----------------------------
  signal wb_slv_adp_out                      : t_wishbone_master_out;
  signal wb_slv_adp_in                       : t_wishbone_master_in;
  signal resized_addr                        : std_logic_vector(c_wishbone_address_width-1 downto 0);

  -- Extra Wishbone registering stage
  signal wb_slave_in                         : t_wishbone_slave_in_array (0 downto 0);
  signal wb_slave_out                        : t_wishbone_slave_out_array(0 downto 0);
  signal wb_slave_in_reg0                    : t_wishbone_slave_in_array (0 downto 0);
  signal wb_slave_out_reg0                   : t_wishbone_slave_out_array(0 downto 0);

  -----------------------------
  -- Functions
  -----------------------------

  -- Map Wishbone MODE/GRANULARITY to all components
  -- according to this module generics
  type t_wb_generics is record
    reg_in_mode         : t_wishbone_interface_mode;
    reg_in_granularity  : t_wishbone_address_granularity;
    reg_out_mode        : t_wishbone_interface_mode;
    reg_out_granularity : t_wishbone_address_granularity;
    slave_mode          : t_wishbone_interface_mode;
    slave_granularity   : t_wishbone_address_granularity;
  end record;

  function f_wb_generics (with_reg_link : boolean; mode : t_wishbone_interface_mode; granularity : t_wishbone_address_granularity)
    return t_wb_generics is
      variable v_wb_generic : t_wb_generics;
   begin
      if with_reg_link then
        v_wb_generic.reg_in_mode := mode;
        v_wb_generic.reg_in_granularity := granularity;
        -- Use CLASSIC/BYTE as xwb_register_links needs them, so convert
        -- only once in our wb_slave_adapter
        -- Otherwise a wb_slave adapter will convert them to CLASSIC/BYTE.
        v_wb_generic.reg_out_mode := CLASSIC;
        v_wb_generic.reg_out_granularity := BYTE;
        v_wb_generic.slave_mode := CLASSIC;
        v_wb_generic.slave_granularity := BYTE;
      else
        -- Unused
        v_wb_generic.reg_in_mode := CLASSIC;
        v_wb_generic.reg_in_granularity := BYTE;
        v_wb_generic.reg_out_mode := CLASSIC;
        v_wb_generic.reg_out_granularity := BYTE;
        -- Use the passed generics
        v_wb_generic.slave_mode := mode;
        v_wb_generic.slave_granularity := granularity;
      end if;
      return v_wb_generic;
   end f_wb_generics;

   constant c_WB_GENERICS : t_wb_generics :=
      f_wb_generics (g_WITH_EXTRA_WB_REG, g_INTERFACE_MODE, g_ADDRESS_GRANULARITY);

begin

  -----------------------------
  -- Insert extra Wishbone registering stage for ease timing.
  -----------------------------
  gen_with_extra_wb_reg : if g_WITH_EXTRA_WB_REG generate

    cmp_register_link : xwb_register_link -- puts a register of delay between crossbars
    generic map (
      g_WB_IN_MODE                          => c_WB_GENERICS.reg_in_mode,
      g_WB_IN_GRANULARITY                   => c_WB_GENERICS.reg_in_granularity,
      g_WB_OUT_MODE                         => c_WB_GENERICS.reg_out_mode,
      g_WB_OUT_GRANULARITY                  => c_WB_GENERICS.reg_out_granularity
    )
    port map (
      clk_sys_i                             => clk_i,
      rst_n_i                               => rst_n_i,
      slave_i                               => wb_slave_in_reg0(0),
      slave_o                               => wb_slave_out_reg0(0),
      master_i                              => wb_slave_out(0),
      master_o                              => wb_slave_in(0)
    );

    wb_slave_in_reg0(0)  <= wb_slv_i;
    wb_slv_o             <= wb_slave_out_reg0(0);

  end generate;

  gen_without_extra_wb_reg : if not g_WITH_EXTRA_WB_REG generate

    -- External master connection
    wb_slave_in(0)  <= wb_slv_i;
    wb_slv_o        <= wb_slave_out(0);

  end generate;

  -----------------------------
  -- Slave adapter for Wishbone Register Interface
  -----------------------------
  cmp_slave_adapter : wb_slave_adapter
  generic map (
    g_master_use_struct                      => true,
    -- Cheby with WBGEN register map requires mode to be PIPELINED
    g_master_mode                            => PIPELINED,
    -- Cheby with WBGEN register map requires granularity to be WORD
    g_master_granularity                     => WORD,
    g_slave_use_struct                       => false,
    g_slave_mode                             => c_WB_GENERICS.slave_mode,
    g_slave_granularity                      => c_WB_GENERICS.slave_granularity
  )
  port map (
    clk_sys_i                                => clk_i,
    rst_n_i                                  => rst_n_i,
    master_i                                 => wb_slv_adp_in,
    master_o                                 => wb_slv_adp_out,
    sl_adr_i                                 => resized_addr,
    sl_dat_i                                 => wb_slave_in(0).dat,
    sl_sel_i                                 => wb_slave_in(0).sel,
    sl_cyc_i                                 => wb_slave_in(0).cyc,
    sl_stb_i                                 => wb_slave_in(0).stb,
    sl_we_i                                  => wb_slave_in(0).we,
    sl_dat_o                                 => wb_slave_out(0).dat,
    sl_ack_o                                 => wb_slave_out(0).ack,
    sl_rty_o                                 => wb_slave_out(0).rty,
    sl_err_o                                 => wb_slave_out(0).err,
    sl_stall_o                               => wb_slave_out(0).stall
  );

  -- By doing this zeroing we avoid the issue related to BYTE -> WORD  conversion
  -- slave addressing (possibly performed by the slave adapter component)
  -- in which a bit in the MSB of the peripheral addressing part (31 - 5 in our case)
  -- is shifted to the internal register adressing part (4 - 0 in our case).
  -- Therefore, possibly changing the these bits!
  resized_addr(c_PERIPH_ADDR_SIZE-1 downto 0)
                                             <= wb_slave_in(0).adr(c_PERIPH_ADDR_SIZE-1 downto 0);
  resized_addr(c_WISHBONE_ADDRESS_WIDTH-1 downto c_PERIPH_ADDR_SIZE)
                                             <= (others => '0');

  -----------------------------
  -- RTM LAMP register map
  -----------------------------
  cmp_rtmlamp_regs : entity work.wb_rtmlamp_ohwr_regs
    port map (
      rst_n_i                                => rst_n_i,
      clk_sys_i                              => clk_i,
      wb_adr_i                               => wb_slv_adp_out.adr(6 downto 0),
      wb_dat_i                               => wb_slv_adp_out.dat,
      wb_dat_o                               => wb_slv_adp_in.dat,
      wb_cyc_i                               => wb_slv_adp_out.cyc,
      wb_sel_i                               => wb_slv_adp_out.sel,
      wb_stb_i                               => wb_slv_adp_out.stb,
      wb_we_i                                => wb_slv_adp_out.we,
      wb_ack_o                               => wb_slv_adp_in.ack,
      wb_stall_o                             => wb_slv_adp_in.stall,
      dac_master_clk_i                       => clk_master_dac_i,

      rtmlamp_ohwr_regs_sta_reserved_i          => (others => '0'),

      rtmlamp_ohwr_regs_ctl_dac_data_from_wb_o  => wb_regs_out.dac_data_from_wb,
      rtmlamp_ohwr_regs_ctl_reserved_i          => (others => '0'),

      rtmlamp_ohwr_regs_ch_0_sta_amp_iflag_l_i  => wb_regs_channel_in(0).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_0_sta_amp_tflag_l_i  => wb_regs_channel_in(0).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_0_sta_amp_iflag_r_i  => wb_regs_channel_in(0).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_0_sta_amp_tflag_r_i  => wb_regs_channel_in(0).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_0_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_0_ctl_amp_en_o       => wb_regs_channel_out(0).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_0_dac_data_o         => wb_regs_channel_out(0).dac_data,
      rtmlamp_ohwr_regs_ch_0_dac_wr_o           => wb_regs_channel_out(0).dac_wr,
      rtmlamp_ohwr_regs_ch_1_sta_amp_iflag_l_i  => wb_regs_channel_in(1).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_1_sta_amp_tflag_l_i  => wb_regs_channel_in(1).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_1_sta_amp_iflag_r_i  => wb_regs_channel_in(1).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_1_sta_amp_tflag_r_i  => wb_regs_channel_in(1).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_1_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_1_ctl_amp_en_o       => wb_regs_channel_out(1).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_1_dac_data_o         => wb_regs_channel_out(1).dac_data,
      rtmlamp_ohwr_regs_ch_1_dac_wr_o           => wb_regs_channel_out(1).dac_wr,
      rtmlamp_ohwr_regs_ch_2_sta_amp_iflag_l_i  => wb_regs_channel_in(2).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_2_sta_amp_tflag_l_i  => wb_regs_channel_in(2).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_2_sta_amp_iflag_r_i  => wb_regs_channel_in(2).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_2_sta_amp_tflag_r_i  => wb_regs_channel_in(2).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_2_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_2_ctl_amp_en_o       => wb_regs_channel_out(2).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_2_dac_data_o         => wb_regs_channel_out(2).dac_data,
      rtmlamp_ohwr_regs_ch_2_dac_wr_o           => wb_regs_channel_out(2).dac_wr,
      rtmlamp_ohwr_regs_ch_3_sta_amp_iflag_l_i  => wb_regs_channel_in(3).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_3_sta_amp_tflag_l_i  => wb_regs_channel_in(3).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_3_sta_amp_iflag_r_i  => wb_regs_channel_in(3).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_3_sta_amp_tflag_r_i  => wb_regs_channel_in(3).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_3_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_3_ctl_amp_en_o       => wb_regs_channel_out(3).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_3_dac_data_o         => wb_regs_channel_out(3).dac_data,
      rtmlamp_ohwr_regs_ch_3_dac_wr_o           => wb_regs_channel_out(3).dac_wr,
      rtmlamp_ohwr_regs_ch_4_sta_amp_iflag_l_i  => wb_regs_channel_in(4).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_4_sta_amp_tflag_l_i  => wb_regs_channel_in(4).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_4_sta_amp_iflag_r_i  => wb_regs_channel_in(4).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_4_sta_amp_tflag_r_i  => wb_regs_channel_in(4).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_4_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_4_ctl_amp_en_o       => wb_regs_channel_out(4).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_4_dac_data_o         => wb_regs_channel_out(4).dac_data,
      rtmlamp_ohwr_regs_ch_4_dac_wr_o           => wb_regs_channel_out(4).dac_wr,
      rtmlamp_ohwr_regs_ch_5_sta_amp_iflag_l_i  => wb_regs_channel_in(5).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_5_sta_amp_tflag_l_i  => wb_regs_channel_in(5).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_5_sta_amp_iflag_r_i  => wb_regs_channel_in(5).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_5_sta_amp_tflag_r_i  => wb_regs_channel_in(5).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_5_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_5_ctl_amp_en_o       => wb_regs_channel_out(5).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_5_dac_data_o         => wb_regs_channel_out(5).dac_data,
      rtmlamp_ohwr_regs_ch_5_dac_wr_o           => wb_regs_channel_out(5).dac_wr,
      rtmlamp_ohwr_regs_ch_6_sta_amp_iflag_l_i  => wb_regs_channel_in(6).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_6_sta_amp_tflag_l_i  => wb_regs_channel_in(6).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_6_sta_amp_iflag_r_i  => wb_regs_channel_in(6).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_6_sta_amp_tflag_r_i  => wb_regs_channel_in(6).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_6_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_6_ctl_amp_en_o       => wb_regs_channel_out(6).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_6_dac_data_o         => wb_regs_channel_out(6).dac_data,
      rtmlamp_ohwr_regs_ch_6_dac_wr_o           => wb_regs_channel_out(6).dac_wr,
      rtmlamp_ohwr_regs_ch_7_sta_amp_iflag_l_i  => wb_regs_channel_in(7).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_7_sta_amp_tflag_l_i  => wb_regs_channel_in(7).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_7_sta_amp_iflag_r_i  => wb_regs_channel_in(7).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_7_sta_amp_tflag_r_i  => wb_regs_channel_in(7).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_7_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_7_ctl_amp_en_o       => wb_regs_channel_out(7).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_7_dac_data_o         => wb_regs_channel_out(7).dac_data,
      rtmlamp_ohwr_regs_ch_7_dac_wr_o           => wb_regs_channel_out(7).dac_wr,
      rtmlamp_ohwr_regs_ch_8_sta_amp_iflag_l_i  => wb_regs_channel_in(8).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_8_sta_amp_tflag_l_i  => wb_regs_channel_in(8).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_8_sta_amp_iflag_r_i  => wb_regs_channel_in(8).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_8_sta_amp_tflag_r_i  => wb_regs_channel_in(8).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_8_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_8_ctl_amp_en_o       => wb_regs_channel_out(8).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_8_dac_data_o         => wb_regs_channel_out(8).dac_data,
      rtmlamp_ohwr_regs_ch_8_dac_wr_o           => wb_regs_channel_out(8).dac_wr,
      rtmlamp_ohwr_regs_ch_9_sta_amp_iflag_l_i  => wb_regs_channel_in(9).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_9_sta_amp_tflag_l_i  => wb_regs_channel_in(9).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_9_sta_amp_iflag_r_i  => wb_regs_channel_in(9).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_9_sta_amp_tflag_r_i  => wb_regs_channel_in(9).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_9_sta_reserved_i     => (others => '0'),
      rtmlamp_ohwr_regs_ch_9_ctl_amp_en_o       => wb_regs_channel_out(9).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_9_dac_data_o         => wb_regs_channel_out(9).dac_data,
      rtmlamp_ohwr_regs_ch_9_dac_wr_o           => wb_regs_channel_out(9).dac_wr,
      rtmlamp_ohwr_regs_ch_10_sta_amp_iflag_l_i => wb_regs_channel_in(10).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_10_sta_amp_tflag_l_i => wb_regs_channel_in(10).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_10_sta_amp_iflag_r_i => wb_regs_channel_in(10).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_10_sta_amp_tflag_r_i => wb_regs_channel_in(10).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_10_sta_reserved_i    => (others => '0'),
      rtmlamp_ohwr_regs_ch_10_ctl_amp_en_o      => wb_regs_channel_out(10).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_10_dac_data_o        => wb_regs_channel_out(10).dac_data,
      rtmlamp_ohwr_regs_ch_10_dac_wr_o          => wb_regs_channel_out(10).dac_wr,
      rtmlamp_ohwr_regs_ch_11_sta_amp_iflag_l_i => wb_regs_channel_in(11).sta_amp_iflag_l,
      rtmlamp_ohwr_regs_ch_11_sta_amp_tflag_l_i => wb_regs_channel_in(11).sta_amp_tflag_l,
      rtmlamp_ohwr_regs_ch_11_sta_amp_iflag_r_i => wb_regs_channel_in(11).sta_amp_iflag_r,
      rtmlamp_ohwr_regs_ch_11_sta_amp_tflag_r_i => wb_regs_channel_in(11).sta_amp_tflag_r,
      rtmlamp_ohwr_regs_ch_11_sta_reserved_i    => (others => '0'),
      rtmlamp_ohwr_regs_ch_11_ctl_amp_en_o      => wb_regs_channel_out(11).ctl_amp_en,
      rtmlamp_ohwr_regs_ch_11_dac_data_o        => wb_regs_channel_out(11).dac_data,
      rtmlamp_ohwr_regs_ch_11_dac_wr_o          => wb_regs_channel_out(11).dac_wr
    );

  -- Why can't this be nicer? All I want is a record with a record of arrays...
  -- I want to be able to do: rtmlamp_ohwr_regs_in.ch_sta[0].amp_iflag_l
  gen_amp_flags : for i in 0 to c_MAX_CHANNELS-1 generate

    wb_regs_channel_in(i).sta_amp_iflag_l  <= amp_iflag_l(i);
    wb_regs_channel_in(i).sta_amp_tflag_l  <= amp_tflag_l(i);
    wb_regs_channel_in(i).sta_amp_iflag_r  <= amp_iflag_r(i);
    wb_regs_channel_in(i).sta_amp_tflag_r  <= amp_tflag_r(i);

    amp_en_ch(i)   <= wb_regs_channel_out(i).ctl_amp_en;
    dac_data_wb(i) <= wb_regs_channel_out(i).dac_data;
    dac_wr_wb(i)   <= wb_regs_channel_out(i).dac_wr;

  end generate;

  dac_data_from_wb <= wb_regs_out.dac_data_from_wb;

  gen_dac_data_mux : for i in 0 to dac_data'length-1 generate

    dac_data(i) <= dac_data_i(i) when dac_data_from_wb = '0' else
                   dac_data_wb(i);

  end generate;

  dac_start <= dac_start_i when dac_data_from_wb = '0' else f_reduce_or(dac_wr_wb);

  -----------------------------
  -- RTM LAMP
  -----------------------------
  cmp_rtmlamp_ohwr : rtmlamp_ohwr
  generic map (
    g_SYS_CLOCK_FREQ                           => g_SYS_CLOCK_FREQ,
    g_REF_CLK_FREQ                             => g_REF_CLK_FREQ,
    g_USE_REF_CLK                              => g_USE_REF_CLK ,
    g_CLK_FAST_SPI_FREQ                        => g_CLK_FAST_SPI_FREQ,
    g_ADC_SCLK_FREQ                            => g_ADC_SCLK_FREQ,
    g_ADC_CHANNELS                             => g_ADC_CHANNELS,
    g_ADC_FIX_INV_INPUTS                       => g_ADC_FIX_INV_INPUTS,
    g_DAC_MASTER_CLOCK_FREQ                    => g_DAC_MASTER_CLOCK_FREQ,
    g_DAC_SCLK_FREQ                            => g_DAC_SCLK_FREQ,
    g_DAC_CHANNELS                             => g_DAC_CHANNELS,
    g_SERIAL_REG_SCLK_FREQ                     => g_SERIAL_REG_SCLK_FREQ ,
    g_SERIAL_REGS_AMP_CHANNELS                 => g_SERIAL_REGS_AMP_CHANNELS
  )
  port map (
    ---------------------------------------------------------------------------
    -- clock and reset interface
    ---------------------------------------------------------------------------
    clk_i                                      => clk_i,
    rst_n_i                                    => rst_n_i,

    clk_ref_i                                  => clk_ref_i,
    rst_ref_n_i                                => rst_ref_n_i,

    rst_fast_spi_n_i                           => rst_fast_spi_n_i,
    clk_fast_spi_i                             => clk_fast_spi_i,

    clk_master_adc_i                           => clk_master_adc_i,
    rst_master_adc_n_i                         => rst_master_adc_n_i,

    clk_master_dac_i                           => clk_master_dac_i,
    rst_master_dac_n_i                         => rst_master_dac_n_i,

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
    dac_ldac_n_o                               => dac_ldac_n_o,
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
    adc_data_o                                 => adc_data_o,
    adc_valid_o                                => adc_valid_o,

    ---------------------------------------------------------------------------
    -- DAC parallel interface
    ---------------------------------------------------------------------------
    dac_start_i                                => dac_start,
    dac_data_i                                 => dac_data,
    dac_ready_o                                => dac_ready_o,
    dac_done_pp_o                              => dac_done_pp_o,

    ---------------------------------------------------------------------------
    -- AMP parallel interface
    ---------------------------------------------------------------------------
    amp_sta_ctl_rw_i                           => '1',

    amp_iflag_l_o                              => amp_iflag_l,
    amp_tflag_l_o                              => amp_tflag_l,
    amp_iflag_r_o                              => amp_iflag_r,
    amp_tflag_r_o                              => amp_tflag_r,
    amp_en_ch_i                                => amp_en_ch
  );

end rtl;
