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

-- RTM LAMP wishbone registers
use work.wb_rtmlamp_ohwr_regs_pkg.all;
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
  -- Number channels (8 or 12)
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
  -- PI parameters
  ---------------------------------------------------------------------------
  -- External PI setpoint data. It is used when ch.x.ctl.mode (wishbone
  -- register) is set to 0b100
  pi_sp_ext_i                                : in  t_pi_sp_word_array(g_CHANNELS-1 downto 0);

  ---------------------------------------------------------------------------
  -- Debug data
  ---------------------------------------------------------------------------
  adc_data_o                                 : out t_16b_word_array(g_CHANNELS-1 downto 0);
  pi_sp_eff_o                                : out t_pi_sp_word_array(g_CHANNELS-1 downto 0);
  dac_data_eff_o                             : out t_16b_word_array(g_CHANNELS-1 downto 0);
  data_valid_o                               : out std_logic
);
end xwb_rtmlamp_ohwr;

architecture rtl of xwb_rtmlamp_ohwr is

  -----------------------------
  -- General Constants
  -----------------------------
  -- Number of bits in Wishbone register interface. Plus 2 to account for BYTE addressing
  constant c_PERIPH_ADDR_SIZE                : natural := 13+2;
  -- Maximum number os channels
  constant c_MAX_CHANNELS                    : natural := 12;

  constant c_WB_CH_CTL_MODE_OL               : std_logic_vector(2 downto 0) := "000";
  constant c_WB_CH_CTL_MODE_OL_TEST_SQR      : std_logic_vector(2 downto 0) := "001";
  constant c_WB_CH_CTL_MODE_CL               : std_logic_vector(2 downto 0) := "010";
  constant c_WB_CH_CTL_MODE_CL_TEST_SQR      : std_logic_vector(2 downto 0) := "011";
  constant c_WB_CH_CTL_MODE_CL_EXT           : std_logic_vector(2 downto 0) := "100";

  -----------------------------
  -- RTM signals
  -----------------------------
  signal ch_ctrl_in                          : t_rtmlamp_ch_ctrl_in_array(g_CHANNELS-1 downto 0);
  signal ch_ctrl_out                         : t_rtmlamp_ch_ctrl_out_array(g_CHANNELS-1 downto 0);
  signal wb_regs_slv_in                      : t_rtmlamp_ohwr_ch_regs_slave_in_array(0 to c_MAX_CHANNELS-1);
  signal wb_regs_slv_out                     : t_rtmlamp_ohwr_ch_regs_slave_out_array(0 to c_MAX_CHANNELS-1);

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
    g_master_mode                            => g_INTERFACE_MODE,
    -- Cheby with default register map requires granularity to be BYTE
    g_master_granularity                     => BYTE,
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
      clk_i                                  => clk_i,
      wb_i                                   => wb_slv_adp_out,
      wb_o                                   => wb_slv_adp_in,
      sta_reserved_i                         => (others => '0'),
      ctl_reserved_o                         => open,
      rtmlamp_ohwr_ch_regs_i                 => wb_regs_slv_out,
      rtmlamp_ohwr_ch_regs_o                 => wb_regs_slv_in
    );

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      -- Connect wishbone registers to the status and control signals of the
      -- rtmlamp_ohwr core
      gen_per_channel : for i in 0 to g_CHANNELS-1 loop
        wb_regs_slv_out(i).sta_amp_iflag_l <= ch_ctrl_out(i).amp_iflag_l;
        wb_regs_slv_out(i).sta_amp_iflag_r <= ch_ctrl_out(i).amp_iflag_r;
        wb_regs_slv_out(i).sta_amp_tflag_l <= ch_ctrl_out(i).amp_tflag_l;
        wb_regs_slv_out(i).sta_amp_tflag_r <= ch_ctrl_out(i).amp_tflag_r;
        wb_regs_slv_out(i).adc_dac_eff_adc <= ch_ctrl_out(i).adc_data;
        wb_regs_slv_out(i).adc_dac_eff_dac <= ch_ctrl_out(i).dac_data_eff;
        wb_regs_slv_out(i).sp_eff_sp <= ch_ctrl_out(i).pi_sp_eff;

        case wb_regs_slv_in(i).ctl_mode is
          when c_WB_CH_CTL_MODE_OL          => ch_ctrl_in(i).mode <= OL_MODE;
          when c_WB_CH_CTL_MODE_OL_TEST_SQR => ch_ctrl_in(i).mode <= OL_TEST_SQR_MODE;
          when c_WB_CH_CTL_MODE_CL          => ch_ctrl_in(i).mode <= CL_MODE;
          when c_WB_CH_CTL_MODE_CL_TEST_SQR => ch_ctrl_in(i).mode <= CL_TEST_SQR_MODE;
          when c_WB_CH_CTL_MODE_CL_EXT      => ch_ctrl_in(i).mode <= CL_MODE;
          when others                       => ch_ctrl_in(i).mode <= OL_MODE;
        end case;

        -- If the triggered mode is enabled, write to dac_data and pi_sp only
        -- when receiving an external trigger. Otherwise, always write.
        if wb_regs_slv_in(i).ctl_trig_en = '0' or
           (wb_regs_slv_in(i).ctl_trig_en = '1' and trig_i(i) = '1') then
          ch_ctrl_in(i).dac_data <= wb_regs_slv_in(i).dac_data;
          case wb_regs_slv_in(i).ctl_mode is
            when c_WB_CH_CTL_MODE_CL_EXT => ch_ctrl_in(i).pi_sp <= pi_sp_ext_i(i);
            when others                  => ch_ctrl_in(i).pi_sp <= wb_regs_slv_in(i).pi_sp_data;
          end case;
        end if;

        ch_ctrl_in(i).amp_en <= wb_regs_slv_in(i).ctl_amp_en;
        ch_ctrl_in(i).pi_kp <= wb_regs_slv_in(i).pi_kp_data;
        ch_ctrl_in(i).pi_ti <= wb_regs_slv_in(i).pi_ti_data;
        ch_ctrl_in(i).lim_a <= wb_regs_slv_in(i).lim_a;
        ch_ctrl_in(i).lim_b <= wb_regs_slv_in(i).lim_b;
        ch_ctrl_in(i).cnt <= unsigned(wb_regs_slv_in(i).cnt_data);

        adc_data_o(i) <= ch_ctrl_out(i).adc_data;
        pi_sp_eff_o(i) <= ch_ctrl_out(i).pi_sp_eff;
        dac_data_eff_o(i) <= ch_ctrl_out(i).dac_data_eff;
      end loop;
    end if;
  end process;

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
    g_CHANNELS                                 => g_CHANNELS,
    g_ADC_FIX_INV_INPUTS                       => g_ADC_FIX_INV_INPUTS,
    g_DAC_SCLK_FREQ                            => g_DAC_SCLK_FREQ,
    g_SERIAL_REG_SCLK_FREQ                     => g_SERIAL_REG_SCLK_FREQ,
    g_ADC_BITS                                 => g_ADC_BITS
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

    -- Only used when g_CHANNELS > 8
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
    -- Channel control
    ---------------------------------------------------------------------------
    ch_ctrl_i                                  => ch_ctrl_in,
    ch_ctrl_o                                  => ch_ctrl_out,
    data_valid_o                               => data_valid_o
  );

end rtl;
