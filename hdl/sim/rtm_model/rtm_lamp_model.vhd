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
    dac_sdi_i: in std_logic_vector (0 to 11) -- DAC data input (12 channels)
    );
end rtm_lamp_model;

architecture rtm_lamp_model_arch of rtm_lamp_model is
  signal voltages: real_vector(0 to 11) := (others => 0.0);
  signal voltages_dac: real_vector(0 to 11) := (others => 0.0);
  signal currents: real_vector(0 to 11) := (others => 0.0);
  signal currents_adc: real_vector(0 to 11) := (others => 0.0);
  signal adc_cnv_sync: std_logic; -- ADC conversion start (synchronized)
  signal dac_ldac_sync: std_logic; -- DAC load (synchronized)
begin
  cmp_dac_ff: entity work.ffd             -- DAC LDAC synchronization flip-flop
    port map(
      clk_i => rtm_lamp_sync_clk_i,
      d_i => '1',
      clr_n_i => adc_cnv_i,
      q_n_o => adc_cnv_sync,
      q_o => open
      );

  cmp_adc_ff: entity work.ffd             -- ADC CNV synchronization flip-flop
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
end rtm_lamp_model_arch;
