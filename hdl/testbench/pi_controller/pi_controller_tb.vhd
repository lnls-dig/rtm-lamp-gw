------------------------------------------------------------------------------
-- Title      : PI controllertestbench
------------------------------------------------------------------------------
-- Author     : Lucas Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-05-13
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: Simple PI controller test
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2021-05-13  1.0      lucas.russo     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pi_controller_tb is
end pi_controller_tb;

architecture pi_controller_tb_arch of pi_controller_tb is
  signal rst_n: std_logic := '0';
  signal clk: std_logic := '0';
  signal ctrl_out: std_logic_vector(15 downto 0);
  signal ctrl_out_valid: std_logic;
  signal ctrl_fb: std_logic_vector(15 downto 0);
  signal ctrl_fb_valid: std_logic;
begin
  pi_inst: entity work.pi_controller
    port map (
      rst_n_i => rst_n,
      clk_i => clk,
      kp_i => x"7000",
      kp_shift_i => 0,
      ti_i => x"2001",
      ti_shift_i => 0,
      ctrl_sp_i => x"1000",
      ctrl_fb_i => ctrl_fb,
      ctrl_fb_valid_i => ctrl_fb_valid,
      ctrl_sig_o => ctrl_out,
      ctrl_sig_valid_o => ctrl_out_valid
      );

  p_gen_sys_clk: process
  begin
    loop
      wait for 5 ns;
      clk <= not clk;
    end loop;
  end process;

  p_gen_sys_rst_n: process
  begin
    rst_n <= '0';
    for i in 0 to 9 loop
      wait until rising_edge(clk);
    end loop;
    rst_n <= '1';
    wait;
  end process;

  process
  begin
    ctrl_fb <= (others => '0');
    ctrl_fb_valid <= '0';
    wait until rst_n = '1';

    for samples in 0 to 31 loop
      ctrl_fb_valid <= '1';
      wait until rising_edge(clk);
      ctrl_fb_valid <= '0';
      wait until rising_edge(clk);

      for i in 0 to 63 loop
        wait until rising_edge(clk);
      end loop;
    end loop;

    ctrl_fb <= '0' & (14 downto 0 => '1');

    for samples in 0 to 31 loop
      ctrl_fb_valid <= '1';
      wait until rising_edge(clk);
      ctrl_fb_valid <= '0';
      wait until rising_edge(clk);

      for i in 0 to 63 loop
        wait until rising_edge(clk);
      end loop;
    end loop;

    std.env.finish;
  end process;

end pi_controller_tb_arch;
