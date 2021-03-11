------------------------------------------------------------------------------
-- Title      : RTM-LAMP model testbench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-06
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: Drive all 12 current channels and read back the currents.
--              Currents outside +- 1A will saturate the ADC, the maximum
--              driving voutage per channel is 4V.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-10-06  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

use work.rtm_lamp_pkg.all;

entity rtm_lamp_model_tb is
end rtm_lamp_model_tb;

architecture rtm_lamp_model_tb_arch of rtm_lamp_model_tb is
  -- Frequency in Hz, Period in s
  constant c_CLK_ADCDAC_MASTER_PERIOD : real := 5.0e-9;
  constant c_CLK_ADCDAC_MASTER_PERIOD_HALF : real := c_CLK_ADCDAC_MASTER_PERIOD/2.0;
  constant c_CLK_ADCDAC_MASTER_FREQ : natural := integer(floor(1.0/c_CLK_ADCDAC_MASTER_PERIOD));

  constant c_CLK_SYS_PERIOD : real := 10.0e-9;
  constant c_CLK_SYS_PERIOD_HALF : real := c_CLK_SYS_PERIOD/2.0;
  constant c_CLK_SYS_FREQ : natural := integer(floor(1.0/c_CLK_SYS_PERIOD));

  constant c_CLK_SCLK_PERIOD : real := 10.0e-9;
  constant c_CLK_SCLK_PERIOD_HALF : real := c_CLK_SCLK_PERIOD/2.0;
  constant c_CLK_SCLK_FREQ : natural := integer(floor(1.0/c_CLK_SCLK_PERIOD));

  constant c_CLK_DAC_SCLK_PERIOD : real := 40.0e-9;
  constant c_CLK_DAC_SCLK_PERIOD_HALF : real := c_CLK_DAC_SCLK_PERIOD/2.0;
  constant c_CLK_DAC_SCLK_FREQ : natural := integer(floor(1.0/c_CLK_DAC_SCLK_PERIOD));

  constant c_CLK_SERIAL_REGS_PERIOD : real := 10.0e-6;
  constant c_CLK_SERIAL_REGS_PERIOD_HALF : real := c_CLK_SERIAL_REGS_PERIOD/2.0;
  constant c_CLK_SERIAL_REGS_FREQ : natural := integer(floor(1.0/c_CLK_SERIAL_REGS_PERIOD));

  constant c_CLK_SYNC_PERIOD : real := 14.42e-9;
  constant c_CLK_SYNC_PERIOD_HALF : real := c_CLK_SYNC_PERIOD/2.0;
  constant c_CLK_SYNC_FREQ : natural := integer(floor(1.0/c_CLK_SYNC_PERIOD));

  signal clk_sys           : std_logic := '0';
  signal rst_n             : std_logic := '0';
  signal clk_master        : std_logic := '0';
  signal rst_master_n      : std_logic := '0';
  signal clk_sclk          : std_logic := '0';
  signal rst_sclk_n        : std_logic := '0';
  signal clk_sync          : std_logic := '0';
  signal rst_sync_n        : std_logic := '0';
  signal dac_samples       : t_16b_word_array(11 downto 0) := (others => x"8000");
  signal dac_ready         : std_logic;
  signal dac_done_pp       : std_logic;
  signal adc_data          : t_16b_word_array(11 downto 0);
  signal adc_valid         : std_logic_vector(11 downto 0);
  signal adc_cnv           : std_logic := '0';
  signal adc_octo_clk      : std_logic := '0';
  signal adc_octo_clk_out  : std_logic;
  signal adc_octo_clk_out_n : std_logic;
  signal adc_octo_sdoa     : std_logic;
  signal adc_octo_sdoa_n   : std_logic;
  signal adc_octo_sdob     : std_logic;
  signal adc_octo_sdob_n   : std_logic;
  signal adc_octo_sdoc     : std_logic;
  signal adc_octo_sdoc_n   : std_logic;
  signal adc_octo_sdod     : std_logic;
  signal adc_octo_sdod_n   : std_logic;
  signal adc_quad_clk      : std_logic := '0';
  signal adc_quad_clk_out  : std_logic;
  signal adc_quad_clk_out_n : std_logic;
  signal adc_quad_sdoa     : std_logic;
  signal adc_quad_sdoa_n   : std_logic;
  signal adc_quad_sdoc     : std_logic;
  signal adc_quad_sdoc_n   : std_logic;
  signal dac_ldac          : std_logic := '0';
  signal dac_cs            : std_logic := '1';
  signal dac_sck           : std_logic := '0';
  signal dac_sdi           : std_logic_vector(11 downto 0) := x"000";
  signal shift_pl          : std_logic;
  signal shift_clk         : std_logic;
  signal shift_dout        : std_logic;
  signal shift_str         : std_logic;
  signal shift_oe_n        : std_logic;
  signal shift_din         : std_logic;
  signal amp_iflag_l       : std_logic_vector(11 downto 0);
  signal amp_tflag_l       : std_logic_vector(11 downto 0);
  signal amp_iflag_r       : std_logic_vector(11 downto 0);
  signal amp_tflag_r       : std_logic_vector(11 downto 0);
  signal amp_en_ch         : std_logic_vector(11 downto 0);

  procedure f_wait_until( signal net    : in std_logic;
                          repeat        : positive := 1;
                          condition     : std_logic := '1') is
  begin

    for i in 0 to repeat-1 loop
      wait until net = condition;
    end loop;

  end f_wait_until;
begin

  p_gen_sys_clk: process
  begin
    loop
      wait for c_CLK_SYS_PERIOD_HALF * 1.0e9 * 1 ns;
      clk_sys <= not clk_sys;
    end loop;
  end process;

  p_gen_sys_rst_n: process
  begin
    rst_n <= '0';
    f_wait_until(clk_sys, 10);
    rst_n <= '1';
    wait;
  end process;

  p_gen_master_clk: process
  begin
    loop
      wait for c_CLK_ADCDAC_MASTER_PERIOD_HALF * 1.0e9 * 1 ns;
      clk_master <= not clk_master;
    end loop;
  end process;

  p_rst_master_n: process
  begin
    rst_master_n <= '0';
    f_wait_until(clk_master, 10);
    rst_master_n <= '1';
    wait;
  end process;

  p_gen_sync_clk: process
  begin
    loop
      wait for c_CLK_SYNC_PERIOD_HALF * 1.0e9 * 1 ns;
      clk_sync <= not clk_sync;
    end loop;
  end process;

  p_rst_sync_n: process
  begin
    rst_sync_n <= '0';
    f_wait_until(clk_sync, 10);
    rst_sync_n <= '1';
    wait;
  end process;

  cmp_rtm_lamp_model: entity work.rtm_lamp_model
    generic map(
      g_ADC_DDR_MODE => false
    )
    port map(
      rtm_lamp_sync_clk_i => clk_sync, -- ADC and DAC synchronization clock
                                                -- for conversion start

      adc_cnv_i => adc_cnv,             -- ADC conversion start

      adc_octo_clk_i => adc_octo_clk,     -- ADC octo data clock input
      adc_octo_clk_o => adc_octo_clk_out, -- ADC octo data clock output
      adc_octo_sdoa_o => adc_octo_sdoa,
      adc_octo_sdob_o => adc_octo_sdob,
      adc_octo_sdoc_o => adc_octo_sdoc,
      adc_octo_sdod_o => adc_octo_sdod,

      adc_quad_clk_i => adc_quad_clk,     -- ADC quad data clock input
      adc_quad_clk_o => adc_quad_clk_out, -- ADC quad data clock output
      adc_quad_sdoa_o => adc_quad_sdoa,
      adc_quad_sdoc_o => adc_quad_sdoc,

      dac_ldac_i => dac_ldac,          -- DAC load
      dac_cs_i => dac_cs,              -- DAC chip select
      dac_sck_i => dac_sck,            -- DAC data clock
      dac_sdi_i => dac_sdi,            -- DAC data input (12 channels)

      shift_pl_i   => shift_pl,      -- Amplifier shift registers parallel load
      shift_clk_i  => shift_clk,     -- Amplifier shift registers clock
      shift_dout_o => shift_dout,     -- Amplifier flags shift register output

      shift_str_i  => shift_str,     -- Amplifier enable shift register strobe
      shift_oe_n_i => shift_oe_n,    -- Amplifier enable output enable
      shift_din_i  => shift_din      -- Amplifier enable data input
      );

  adc_octo_clk_out_n <= not adc_octo_clk_out;
  adc_octo_sdoa_n <= not adc_octo_sdoa;
  adc_octo_sdob_n <= not adc_octo_sdob;
  adc_octo_sdoc_n <= not adc_octo_sdoc;
  adc_octo_sdod_n <= not adc_octo_sdod;

  adc_quad_clk_out_n <= not adc_quad_clk_out;
  adc_quad_sdoa_n <= not adc_quad_sdoa;
  adc_quad_sdoc_n <= not adc_quad_sdoc;

  cmp_rtmlamp_ohwr : rtmlamp_ohwr
  generic map (
    g_SYS_CLOCK_FREQ                           => c_CLK_SYS_FREQ,
    g_REF_CLK_FREQ                             => c_CLK_SYNC_FREQ,
    g_USE_REF_CLK                              => true,
    g_ADC_MASTER_CLOCK_FREQ                    => c_CLK_ADCDAC_MASTER_FREQ,
    g_ADC_SCLK_FREQ                            => c_CLK_SCLK_FREQ,
    g_ADC_CHANNELS                             => 12,
    g_ADC_FIX_INV_INPUTS                       => true,
    g_DAC_MASTER_CLOCK_FREQ                    => c_CLK_ADCDAC_MASTER_FREQ,
    g_DAC_SCLK_FREQ                            => c_CLK_DAC_SCLK_FREQ,
    g_DAC_CHANNELS                             => 12,
    g_SERIAL_REG_SCLK_FREQ                     => c_CLK_SERIAL_REGS_FREQ,
    g_SERIAL_REGS_AMP_CHANNELS                 => 12
  )
  port map (
    clk_i                                      => clk_sys,
    rst_n_i                                    => rst_n,

    clk_ref_i                                  => clk_sync,
    rst_ref_n_i                                => rst_sync_n,

    clk_master_adc_i                           => clk_master,
    rst_master_adc_n_i                         => rst_master_n,

    clk_master_dac_i                           => clk_master,
    rst_master_dac_n_i                         => rst_master_n,

    ---------------------------------------------------------------------------
    -- RTM ADC interface
    ---------------------------------------------------------------------------
    adc_octo_cnv_o                             => adc_cnv,
    adc_octo_sck_p_o                           => adc_octo_clk,
    adc_octo_sck_n_o                           => open,
    adc_octo_sck_ret_p_i                       => adc_octo_clk_out,
    adc_octo_sck_ret_n_i                       => adc_octo_clk_out_n,
    adc_octo_sdoa_p_i                          => adc_octo_sdoa,
    adc_octo_sdoa_n_i                          => adc_octo_sdoa_n,
    adc_octo_sdob_p_i                          => adc_octo_sdob,
    adc_octo_sdob_n_i                          => adc_octo_sdob_n,
    adc_octo_sdoc_p_i                          => adc_octo_sdoc,
    adc_octo_sdoc_n_i                          => adc_octo_sdoc_n,
    adc_octo_sdod_p_i                          => adc_octo_sdod,
    adc_octo_sdod_n_i                          => adc_octo_sdod_n,

    -- Only used when g_ADC_CHANNELS > 8
    adc_quad_sck_p_o                           => adc_octo_clk,
    adc_quad_sck_n_o                           => open,
    adc_quad_sck_ret_p_i                       => adc_quad_clk_out,
    adc_quad_sck_ret_n_i                       => adc_quad_clk_out_n,
    adc_quad_sdoa_p_i                          => adc_quad_sdoa,
    adc_quad_sdoa_n_i                          => adc_quad_sdoa_n,
    adc_quad_sdoc_p_i                          => adc_quad_sdoc,
    adc_quad_sdoc_n_i                          => adc_quad_sdoc_n,

    ---------------------------------------------------------------------------
    -- RTM DAC interface
    ---------------------------------------------------------------------------
    dac_cs_n_o                                 => dac_cs,
    dac_ldac_n_o                               => dac_ldac,
    dac_sck_o                                  => dac_sck,
    dac_sdi_o                                  => dac_sdi,

    ---------------------------------------------------------------------------
    -- RTM Serial registers interface
    ---------------------------------------------------------------------------
    amp_shift_clk_o                            => shift_clk,
    amp_shift_dout_i                           => shift_dout,
    amp_shift_pl_o                             => shift_pl,

    amp_shift_oe_n_o                           => shift_oe_n,
    amp_shift_din_o                            => shift_din,
    amp_shift_str_o                            => shift_str,

    ---------------------------------------------------------------------------
    -- FPGA interface
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- ADC parallel interface
    ---------------------------------------------------------------------------
    adc_start_i                                => '1',
    adc_data_o                                 => adc_data,
    adc_valid_o                                => adc_valid,

    ---------------------------------------------------------------------------
    -- DAC parallel interface
    ---------------------------------------------------------------------------
    dac_start_i                                => '1',
    dac_data_i                                 => dac_samples,
    dac_ready_o                                => dac_ready,
    dac_done_pp_o                              => dac_done_pp,

    ---------------------------------------------------------------------------
    -- AMP parallel interface
    ---------------------------------------------------------------------------

    amp_iflag_l_o                              => amp_iflag_l,
    amp_tflag_l_o                              => amp_tflag_l,
    amp_iflag_r_o                              => amp_iflag_r,
    amp_tflag_r_o                              => amp_tflag_r,
    amp_en_ch_i                                => amp_en_ch
  );

  p_set_amp_en: process
  begin
    f_wait_until(rst_n, 1, '1');
    amp_en_ch <= "010101010101";
    f_wait_until(clk_sys, 10000*100);
    amp_en_ch <= "101010101010";
    f_wait_until(clk_sys, 10000*100);
    amp_en_ch <= "000011110000";
    f_wait_until(clk_sys, 10000*100);
    amp_en_ch <= "111100001111";
    f_wait_until(clk_sys, 10000*100);
    wait;
  end process;

  p_set_vout: process
  begin
    f_wait_until(rst_n, 1, '1');
    f_wait_until(clk_sys, 300000);
    dac_samples <= (x"0000", x"1000", x"3000", x"4000",
                    x"5000", x"6000", x"7000", x"8000",
                    x"9000", x"A000", x"B000", x"C000");
    f_wait_until(clk_sys, 10000*100);
    dac_samples <= (others => x"FFFF");
    f_wait_until(clk_sys, 300000);
    dac_samples <= (x"EEEE", x"DDDD", x"CCCC", x"BBBB",
                    x"AAAA", x"9999", x"8888", x"7777",
                    x"6666", x"5555", x"4444", x"3333");
    f_wait_until(clk_sys, 300000);
    std.env.finish;
  end process;

end rtm_lamp_model_tb_arch;
