------------------------------------------------------------------------------
-- Title      : Complete Wishbone to RTM-LAMP simulation
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-GCA
-- Created    : 2022-01-18
-- Platform   : Simulation
-------------------------------------------------------------------------------
-- Description: Write to DAC and PI registers via wishbone, see the behavior
-- of the current and voltage on the load
-------------------------------------------------------------------------------
-- Copyright (c) 2022 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2022-01-18  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
-- RTM LAMP definitions
use work.rtm_lamp_pkg.all;
-- Main Wishbone Definitions
use work.wishbone_pkg.all;
-- generic buffers
use work.platform_generic_pkg.all;
-- wishbone read / write procedures
use work.sim_wishbone.all;
-- rtmlamp_ohwr register constants
use work.wb_rtmlamp_ohwr_regs_consts_pkg.all;

entity xwb_rtmlamp_ohwr_tb is
end entity xwb_rtmlamp_ohwr_tb;

architecture xwb_rtmlamp_ohwr_tb_arch of xwb_rtmlamp_ohwr_tb is
  procedure f_gen_clk(constant freq : in    natural;
                      signal   clk  : inout std_logic) is
  begin
    loop
      wait for (0.5 / real(freq)) * 1 sec;
      clk <= not clk;
    end loop;
  end procedure f_gen_clk;

  procedure f_wait_cycles(signal   clk    : in std_logic;
                          constant cycles : natural) is
  begin
    for i in 0 to cycles loop
      wait until rising_edge(clk);
    end loop;
  end procedure f_wait_cycles;

  constant c_SYS_CLOCK_FREQ      : natural := 100000000;
  constant c_REF_CLOCK_FREQ      : natural := 100000000;
  constant c_FAST_SPI_FREQ       : natural := 400000000;
  constant c_ADC_SCLK_FREQ       : natural := 100000000;
  constant c_DAC_SCLK_FREQ       : natural := 25000000;
  constant c_USE_REF_CLOCK       : boolean := true;
  constant c_RTMLAMP_CHANNELS    : natural := 12;

  signal clk_sys                 : std_logic := '0';
  signal clk_sys_rstn            : std_logic := '0';
  signal clk_rtm_ref             : std_logic := '0';
  signal clk_rtm_ref_rstn        : std_logic := '0';
  signal clk_fast_spi            : std_logic := '0';
  signal clk_fast_spi_rstn       : std_logic := '0';

  signal intr_amp_flags_update   : std_logic;

  signal wb_slave_i              : t_wishbone_slave_in;
  signal wb_slave_o              : t_wishbone_slave_out;

  -- Start with all amplifier flags set to '1' (no faults)
  signal amp_iflag_l             : std_logic_vector(11 downto 0) := (others => '1');
  signal amp_iflag_r             : std_logic_vector(11 downto 0) := (others => '1');
  signal amp_tflag_l             : std_logic_vector(11 downto 0) := (others => '1');
  signal amp_tflag_r             : std_logic_vector(11 downto 0) := (others => '1');

  signal trig                    : std_logic_vector(c_RTMLAMP_CHANNELS-1 downto 0) := (others => '0');
  signal pi_sp_ext               : t_pi_sp_word_array(c_RTMLAMP_CHANNELS-1 downto 0) := (others => x"0000");
begin
  f_gen_clk(c_SYS_CLOCK_FREQ, clk_sys);
  f_gen_clk(c_REF_CLOCK_FREQ, clk_rtm_ref);
  f_gen_clk(c_FAST_SPI_FREQ, clk_fast_spi);

  process
    variable v_sp_eff: std_logic_vector(31 downto 0);
    variable v_amp_flags: std_logic_vector(31 downto 0);
  begin
    init(wb_slave_i);

    -- Reset all cores
    f_wait_cycles(clk_sys, 10);

    clk_sys_rstn <= '1';
    clk_rtm_ref_rstn <= '1';
    clk_fast_spi_rstn <= '1';

    f_wait_cycles(clk_sys, 10);

    -- Enable CH0 amplifier (for now it has no effect, the amplifier is always
    -- enabled in the rtm_lamp_model), set mode to open loop manual control
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR,
               (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET + 2) downto
                c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET => "000",
                others => '0'));

    -- Write to the CH0 DAC via wishbone (2's complement)
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_DAC_ADDR,
               ((c_WB_RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_OFFSET + 15) downto
                c_WB_RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_OFFSET => std_logic_vector(to_signed(0, 16)),
                others => '0'));

    -- Set CH0 PI Kp to 5 000 000
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_KP_ADDR,
               std_logic_vector(to_unsigned(5000000, 32)));

    -- Set CH0 PI Ti to 500 000
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_TI_ADDR,
               std_logic_vector(to_unsigned(500000, 32)));

    -- Set CH0 PI setpoint to -1000
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_SP_ADDR,
               std_logic_vector(to_signed(-1000, 32)));

    -- Set CH0 mode to closed-loop manual control
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR,
               (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET + 2) downto
                c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET => "010",
                others => '0'));
    -- Wait 5 us
    f_wait_cycles(clk_sys, 500);

    -- Read the effective set point value
    read32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_SP_EFF_ADDR,
              v_sp_eff);

    -- Check if the effective set point is -1000
    assert v_sp_eff(15 downto 0) = std_logic_vector(to_signed(-1000, 16));

    -- Wait for 50 us
    f_wait_cycles(clk_sys, 5000);

    -- Set CH0 mode to closed-loop external control
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR,
               (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET + 2) downto
                c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET => "100",
                others => '0'));

    -- Set the external setpoint to 1000 for CH0
    pi_sp_ext(0) <= std_logic_vector(to_signed(1000, 16));

    -- Wait 5 us
    f_wait_cycles(clk_sys, 500);

    -- Read the effective set point value
    read32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_SP_EFF_ADDR,
              v_sp_eff);

    -- Check if the effective set point is 1000
    assert v_sp_eff(15 downto 0) = std_logic_vector(to_signed(1000, 16));

    -- Wait for 50 us
    f_wait_cycles(clk_sys, 5000);

    -- Enable external trigger
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR,
               (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET + 2) downto
                c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET => "100",
                c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_TRIG_EN_OFFSET => '1',
                others => '0'));

    -- Set the external setpoint to -5000 for CH0
    pi_sp_ext(0) <= std_logic_vector(to_signed(-5000, 16));

    -- Wait 5 us
    f_wait_cycles(clk_sys, 500);

    -- Read the effective set point value
    read32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_SP_EFF_ADDR,
              v_sp_eff);

    -- Check if the effective set point still 1000
    assert v_sp_eff(15 downto 0) = std_logic_vector(to_signed(1000, 16));

    -- Wait for 20 us
    f_wait_cycles(clk_sys, 2000);

    -- Send trigger to CH0
    trig(0) <= '1';
    f_wait_cycles(clk_sys, 1);
    trig(0) <= '0';

    -- Wait 5 us
    f_wait_cycles(clk_sys, 500);

    -- Read the effective set point value
    read32_pl(clk_sys, wb_slave_i, wb_slave_o, c_WB_RTMLAMP_OHWR_REGS_CH_0_SP_EFF_ADDR,
              v_sp_eff);

    -- Check if the effective set point has changed to -5000 after the trigger
    assert v_sp_eff(15 downto 0) = std_logic_vector(to_signed(-5000, 16));

    ---------------------------------------------------------------------------
    -- Test amplifier overcurrent and overtemperature flags
    ---------------------------------------------------------------------------

    -- Generate overcurrent and overtemperature condition
    amp_iflag_l <= x"000";
    amp_iflag_r <= x"000";
    amp_tflag_l <= x"000";
    amp_tflag_r <= x"000";

    -- Wait for 2 scans before reading the channel status register
    wait until rising_edge(intr_amp_flags_update);
    wait until rising_edge(intr_amp_flags_update);

    -- Check if all overtemperature and overcurrent flags are asserted
    for ch in 0 to 11 loop
      read32_pl(clk_sys, wb_slave_i, wb_slave_o,
                c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_ADDR +
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_SIZE * ch),
                v_amp_flags);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_LATCH_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_LATCH_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_LATCH_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_LATCH_OFFSET) = '0';
    end loop;

    -- Deassert the overcurrent and overtemperature flags
    amp_iflag_l <= x"FFF";
    amp_iflag_r <= x"FFF";
    amp_tflag_l <= x"FFF";
    amp_tflag_r <= x"FFF";

    -- Wait for 2 scans before reading the channel status register
    wait until rising_edge(intr_amp_flags_update);
    wait until rising_edge(intr_amp_flags_update);

    -- Check if the latched flags are asserted and the non latched
    -- flags are deasserted
    for ch in 0 to 11 loop
      read32_pl(clk_sys, wb_slave_i, wb_slave_o,
                c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_ADDR +
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_SIZE * ch),
                v_amp_flags);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_LATCH_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_LATCH_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_LATCH_OFFSET) = '0';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_LATCH_OFFSET) = '0';
    end loop;

    -- Generate a pattern of overcurrent and overtemperature flags
    amp_iflag_l <= x"A37";
    amp_iflag_r <= x"529";
    amp_tflag_l <= x"9E6";
    amp_tflag_r <= x"1C4";

    -- Clear latched status flags
    for ch in 0 to 11 loop
      write32_pl(clk_sys, wb_slave_i, wb_slave_o,
                 c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR +
                 (c_WB_RTMLAMP_OHWR_REGS_CH_0_SIZE * ch),
                 (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                  (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET + 2) downto
                  c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET => "100",
                  c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_TRIG_EN_OFFSET => '1',
                  c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_RST_LATCH_STS_OFFSET => '1',
                  others => '0'));
    end loop;

    -- Wait for 2 scans before reading the channel status register
    wait until rising_edge(intr_amp_flags_update);
    wait until rising_edge(intr_amp_flags_update);

    -- Check if the flag pattern is correct
    for ch in 0 to 11 loop
      read32_pl(clk_sys, wb_slave_i, wb_slave_o,
                c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_ADDR +
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_SIZE * ch),
                v_amp_flags);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_OFFSET) = amp_iflag_l(ch);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_OFFSET) = amp_iflag_r(ch);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_OFFSET) = amp_tflag_l(ch);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_OFFSET) = amp_tflag_r(ch);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_LATCH_OFFSET) = amp_iflag_l(ch);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_LATCH_OFFSET) = amp_iflag_r(ch);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_LATCH_OFFSET) = amp_tflag_l(ch);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_LATCH_OFFSET) = amp_tflag_r(ch);
    end loop;

    -- Deassert the overcurrent and overtemperature flags
    amp_iflag_l <= x"FFF";
    amp_iflag_r <= x"FFF";
    amp_tflag_l <= x"FFF";
    amp_tflag_r <= x"FFF";

    -- Wait for 2 scans before reading the channel status register
    wait until rising_edge(intr_amp_flags_update);
    wait until rising_edge(intr_amp_flags_update);

    -- Clear latched status flags
    for ch in 0 to 11 loop
      write32_pl(clk_sys, wb_slave_i, wb_slave_o,
                 c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR +
                 (c_WB_RTMLAMP_OHWR_REGS_CH_0_SIZE * ch),
                 (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                  (c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET + 2) downto
                  c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET => "100",
                  c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_TRIG_EN_OFFSET => '1',
                  c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_RST_LATCH_STS_OFFSET => '1',
                  others => '0'));
    end loop;

    -- Check if all flags are deasserted
    for ch in 0 to 11 loop
      read32_pl(clk_sys, wb_slave_i, wb_slave_o,
                c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_ADDR +
                (c_WB_RTMLAMP_OHWR_REGS_CH_0_SIZE * ch),
                v_amp_flags);
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_LATCH_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_LATCH_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_LATCH_OFFSET) = '1';
      assert v_amp_flags(c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_LATCH_OFFSET) = '1';
    end loop;

    std.env.finish;
  end process;

  cmp_xwb_rtmlamp_ohwr_glue: entity work.xwb_rtmlamp_ohwr_glue
    generic map(
      -- Set the magnet inductance and resistance to smaller values,
      -- so we can minimize the simulation time required for the current
      -- setpoint to be reached.
      g_MAG_IND               => 500.0e-6,
      g_MAG_RES               => 0.25
      )
    port map(
      clk_sys_i               => clk_sys,
      clk_sys_rstn_i          => clk_sys_rstn,
      clk_rtm_ref_i           => clk_rtm_ref,
      clk_rtm_ref_rstn_i      => clk_rtm_ref_rstn,
      clk_fast_spi_i          => clk_fast_spi,
      clk_fast_spi_rstn_i     => clk_fast_spi_rstn,

      intr_amp_flags_update_o => intr_amp_flags_update,

      wb_slave_i              => wb_slave_i,
      wb_slave_o              => wb_slave_o,

      amp_iflag_l_i           => amp_iflag_l,
      amp_iflag_r_i           => amp_iflag_r,
      amp_tflag_l_i           => amp_tflag_l,
      amp_tflag_r_i           => amp_tflag_r,

      trig_i                  => trig,
      pi_sp_ext_i             => pi_sp_ext
      );

end architecture xwb_rtmlamp_ohwr_tb_arch;
