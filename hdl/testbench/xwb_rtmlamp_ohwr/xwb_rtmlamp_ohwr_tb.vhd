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
use work.rtmlamp_ohwr_regs_consts_pkg.all;

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

  constant c_SYS_CLOCK_FREQ                  : natural := 100000000;
  constant c_REF_CLOCK_FREQ                  : natural := 100000000;
  constant c_FAST_SPI_FREQ                   : natural := 400000000;
  constant c_ADC_SCLK_FREQ                   : natural := 100000000;
  constant c_DAC_SCLK_FREQ                   : natural := 25000000;
  constant c_USE_REF_CLOCK                   : boolean := true;
  constant c_ADC_CHANNELS                    : natural := 12;
  constant c_DAC_CHANNELS                    : natural := 12;

  signal clk_sys                             : std_logic := '0';
  signal clk_sys_rstn                        : std_logic := '0';
  signal clk_rtm_ref                         : std_logic := '0';
  signal clk_rtm_ref_rstn                    : std_logic := '0';
  signal clk_fast_spi                        : std_logic := '0';
  signal clk_fast_spi_rstn                   : std_logic := '0';

  signal wb_slave_i                          : t_wishbone_slave_in;
  signal wb_slave_o                          : t_wishbone_slave_out;
begin
  f_gen_clk(c_SYS_CLOCK_FREQ, clk_sys);
  f_gen_clk(c_REF_CLOCK_FREQ, clk_rtm_ref);
  f_gen_clk(c_FAST_SPI_FREQ, clk_fast_spi);

  process
    variable data : std_logic_vector(31 downto 0);
  begin
    init(wb_slave_i);
    wait for 100 ns;
    clk_sys_rstn <= '1';
    clk_rtm_ref_rstn <= '1';
    clk_fast_spi_rstn <= '1';
    wait for 100 ns;

    -- Enable CH0 amplifier (for now it has no effect, the amplifier is always
    -- enabled in the rtm_lamp_model)
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR,
               (c_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                others => '0'));

    -- DAC data from wishbone
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CTL_ADDR,
               (c_RTMLAMP_OHWR_REGS_CTL_DAC_DATA_FROM_WB_OFFSET => '1',
                others => '0'));

    -- Write to the CH0 DAC via wishbone (2's complement)
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CH_0_DAC_ADDR,
               (c_RTMLAMP_OHWR_REGS_CH_0_DAC_WR_OFFSET => '1',
                (c_RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_OFFSET + 15) downto
                c_RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_OFFSET => std_logic_vector(to_signed(0, 16)),
                others => '0'));

    -- Set CH0 PI Kp to 5 000 000
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CH_0_PI_KP_ADDR,
               std_logic_vector(to_unsigned(5000000, 32)));

    -- Set CH0 PI Ti to 2048
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CH_0_PI_TI_ADDR,
               std_logic_vector(to_unsigned(2048, 32)));

    -- Set CH0 PI setpoint to 100
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CH_0_PI_SP_ADDR,
               std_logic_vector(to_signed(100, 32)));

    -- Enable CH0 PI controller
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR,
               (c_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET => '1',
                c_RTMLAMP_OHWR_REGS_CH_0_CTL_PI_ENABLE_OFFSET => '1',
                others => '0'));

    -- DAC data from PI controller
    write32_pl(clk_sys, wb_slave_i, wb_slave_o, c_RTMLAMP_OHWR_REGS_CTL_ADDR,
               (c_RTMLAMP_OHWR_REGS_CTL_DAC_DATA_FROM_WB_OFFSET => '0',
                others => '0'));

    wait for 20 us;
    std.env.finish;
  end process;

  cmp_xwb_rtmlamp_ohwr_glue: entity work.xwb_rtmlamp_ohwr_glue
    port map(
      clk_sys_i               => clk_sys,
      clk_sys_rstn_i          => clk_sys_rstn,
      clk_rtm_ref_i           => clk_rtm_ref,
      clk_rtm_ref_rstn_i      => clk_rtm_ref_rstn,
      clk_fast_spi_i          => clk_fast_spi,
      clk_fast_spi_rstn_i     => clk_fast_spi_rstn,

      wb_slave_i              => wb_slave_i,
      wb_slave_o              => wb_slave_o
      );

end architecture xwb_rtmlamp_ohwr_tb_arch;
