------------------------------------------------------------------------------
-- Title      : RTM-LAMP simulation model
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-01
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: RTM-LAMP simulation model, including DACs, ADCs and a basic
--              resistor-inductor model. It presents a 1:1 signal interface,
--              so it can be swaped for the real hardware.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-10-01  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity rtm_lamp_model is
  generic(
    g_ADC_REF: real := 4.096;          -- ADC voltage reference [V]
    g_DAC_REF: real := 4.0;            -- DAC voltage reference [V]
    g_MAG_RES: real := 1.0;            -- Magnet resistance [Ohms]
    g_MAG_IND: real := 3.5e-3;         -- Magnet inductance [H]
    g_MAG_TIME_STEP: real := 1.0e-6;   -- Magnet simulation time step [s]
    g_ADC_DDR_MODE: boolean := true
    );
  port(
    rtm_lamp_sync_clk_i: in std_logic; -- ADC and DAC synchronization clock
                                       -- for conversion start

    adc_cnv_i: in std_logic;           -- ADC conversion start

    adc_octo_clk_i: in std_logic;      -- ADC octo data clock input
    adc_octo_clk_o: out std_logic;     -- ADC octo data clock output
    adc_octo_sdoa_o: out std_logic;
    adc_octo_sdob_o: out std_logic;
    adc_octo_sdoc_o: out std_logic;
    adc_octo_sdod_o: out std_logic;

    adc_quad_clk_i: in std_logic;      -- ADC quad data clock input
    adc_quad_clk_o: out std_logic;     -- ADC quad data clock output
    adc_quad_sdoa_o: out std_logic;
    adc_quad_sdoc_o: out std_logic;

    dac_ldac_i: in std_logic;          -- DAC load
    dac_cs_i: in std_logic;            -- DAC chip select
    dac_sck_i: in std_logic;           -- DAC data clock
    dac_sdi_i: in std_logic_vector (0 to 11); -- DAC data input (12 channels)

    shift_pl_i : in std_logic;         -- Amplifier shift registers parallel load
    shift_clk_i : in std_logic;        -- Amplifier shift registers clock
    shift_dout_o : out std_logic;      -- Amplifier flags shift register output

    shift_str_i : in std_logic;        -- Amplifier enable shift register strobe
    shift_oe_n_i : in std_logic;       -- Amplifier enable output enable
    shift_din_i : in std_logic         -- Amplifier enable data input
    );
end rtm_lamp_model;

architecture rtm_lamp_model_arch of rtm_lamp_model is
  signal voltages: real_vector(0 to 11) := (others => 0.0);
  signal voltages_dac: real_vector(0 to 11) := (others => 0.0);
  signal currents: real_vector(0 to 11) := (others => 0.0);
  signal currents_adc: real_vector(0 to 11) := (others => 0.0);
  signal adc_cnv_sync: std_logic; -- ADC conversion start (synchronized)
  signal dac_ldac_sync: std_logic; -- DAC load (synchronized)

  type t_array_8b_word is array(natural range <>) of std_logic_vector(7 downto 0);
  signal amp_iflag_l : std_logic_vector(11 downto 0);
  signal amp_tflag_l : std_logic_vector(11 downto 0);
  signal amp_iflag_r : std_logic_vector(11 downto 0);
  signal amp_tflag_r : std_logic_vector(11 downto 0);
  signal amp_flags_dp : t_array_8b_word(5 downto 0) := (others => (others => '0'));
  signal amp_flags_q7 : std_logic_vector(5 downto 0);
  signal amp_flags_q7_n : std_logic_vector(5 downto 0);
  signal amp_flags_ds : std_logic_vector(6 downto 0);

  signal amp_en_q : t_array_8b_word(1 downto 0) := (others => (others => '0'));
  signal amp_en_q7s : std_logic_vector(1 downto 0);
  signal amp_en_ds : std_logic_vector(2 downto 0);

begin
  cmp_adc_ff: entity work.ffd             -- ADC CNV synchronization flip-flop
    port map(
      clk_i => rtm_lamp_sync_clk_i,
      d_i => '1',
      clr_n_i => adc_cnv_i,
      q_n_o => adc_cnv_sync,
      q_o => open
      );

  cmp_dac_ff: entity work.ffd             -- DAC LDAC synchronization flip-flop
    port map(
      clk_i => rtm_lamp_sync_clk_i,
      d_i => '1',
      clr_n_i => dac_ldac_i,
      q_n_o => dac_ldac_sync,
      q_o => open
      );

  dac_to_voltage:                       -- Map dac output voltage from 0.0 <-> 4.0V to
                                        -- -4.0 <-> 4.0V
  for i in 0 to 11 generate
    voltages(i) <= (voltages_dac(i) - 2.0) * 2.0;
  end generate;

  current_to_adc:                       -- Map input current from -1.0 <-> 1.0A to
                                        -- 0.0 <-> 4.0V (adc input)
  for i in 0 to 11 generate
    currents_adc(i) <= maximum((currents(i) + 1.0) * 2.0, 0.0);
  end generate;

  dac_and_magnets:
  for i in 0 to 11 generate
    cmp_magnet: entity work.magnet_model
      generic map(
        g_RES => g_MAG_RES,
        g_IND => g_MAG_IND,
        g_TIME_STEP => g_MAG_TIME_STEP
        )
      port map(
        volt_i => voltages(i),
        cur_o => currents(i)
        );

    cmp_dac: entity work.dac8831_model
      generic map(
        g_REF => g_DAC_REF
        )
      port map(
        cs_i => dac_cs_i,
        sck_i => dac_sck_i,
        sdi_i => dac_sdi_i(i),
        ldac_i => dac_ldac_sync,
        vout_o => voltages_dac(i)
        );
  end generate;

  cmp_ltc2320: entity work.ltc232x_model
    generic map(
      g_REF => g_ADC_REF,
      g_CHANNELS => 8,
      g_DDR_MODE => g_ADC_DDR_MODE
      )
    port map(
      cnv_n_i => adc_cnv_sync,
      clk_i => adc_octo_clk_i,
      clk_o => adc_octo_clk_o,
      sdoa_o => adc_octo_sdoa_o,
      sdob_o => adc_octo_sdob_o,
      sdoc_o => adc_octo_sdoc_o,
      sdod_o => adc_octo_sdod_o,
      analog_i => currents_adc(0 to 7)
      );

  cmp_ltc2324: entity work.ltc232x_model
    generic map(
      g_REF => g_ADC_REF,
      g_CHANNELS => 4,
      g_DDR_MODE => g_ADC_DDR_MODE
      )
    port map(
      cnv_n_i => adc_cnv_sync,
      clk_i => adc_quad_clk_i,
      clk_o => adc_quad_clk_o,
      sdoa_o => adc_quad_sdoa_o,
      sdob_o => open,
      sdoc_o => adc_quad_sdoc_o,
      sdod_o => open,
      analog_i => currents_adc(8 to 11)
      );

  -- generate some flags pattern
  amp_iflag_l <= "010101010101"; -- x"555"
  amp_tflag_l <= "101010101010"; -- x"AAA"
  amp_iflag_r <= "000011110000"; -- x"0F0"
  amp_tflag_r <= "111100001111"; -- x"F0F"

  amp_flags_dp(0) <= amp_tflag_r(1) &
                     amp_iflag_r(1) &
                     amp_tflag_l(1) &
                     amp_iflag_l(1) &
                     amp_tflag_r(0) &
                     amp_iflag_r(0) &
                     amp_tflag_l(0) &
                     amp_iflag_l(0);
  amp_flags_ds(0) <= '0';

  gen_amp_flags_regs: for i in 0 to 5 generate

    amp_flags_dp(i) <= amp_tflag_r(2*i+1) &
                       amp_iflag_r(2*i+1) &
                       amp_tflag_l(2*i+1) &
                       amp_iflag_l(2*i+1) &
                       amp_tflag_r(2*i) &
                       amp_iflag_r(2*i) &
                       amp_tflag_l(2*i) &
                       amp_iflag_l(2*i);

    cmp_shift_reg_74hc165_model : entity work.shift_reg_74hc165_model
    port map (
      pl_n_i   => not shift_pl_i,
      ce_n_i   => '0',
      dp_i     => amp_flags_dp(i),
      -- RTM LAMP inverts the shift clock signal for the 74HC165 CIs
      cp_i     => not shift_clk_i,
      ds_i     => amp_flags_ds(i),
      q7_o     => amp_flags_q7(i),
      q7_n_o   => amp_flags_q7_n(i)
    );

    amp_flags_ds(i+1) <= amp_flags_q7(i);

  end generate;

  -- RTM LAMP inverts the inverted output port.
  shift_dout_o <= not amp_flags_q7_n(5);

  amp_en_ds(0) <= shift_din_i;

  gen_amp_en_regs: for i in 0 to 1 generate

    cmp_shift_reg_74hc595_model : entity work.shift_reg_74hc595_model
    port map (
      mr_n_i   => '1',
      shcp_i   => shift_clk_i,
      stcp_i   => shift_str_i,
      oe_n_i   => shift_oe_n_i,
      ds_i     => amp_en_ds(i),
      q_o      => amp_en_q(i),
      q7s_o    => amp_en_q7s(i)
    );

    amp_en_ds(i+1) <= amp_en_q7s(i);

  end generate;

end rtm_lamp_model_arch;
