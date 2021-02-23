------------------------------------------------------------------------------
-- Title      : D flip-flop testbench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-09-25
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: D flip-flop testbench
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-09-25  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ffd_tb is
  port (
    q_o   : out std_logic;
    q_n_o : out std_logic
    );
end ffd_tb;

architecture ffd_tb_arch of ffd_tb is
  signal clk: std_logic := '0';
  signal clr_n: std_logic := '1';
  signal d: std_logic := '0';
begin
  cmp_ffd: entity work.ffd
    port map (
      clk_i => clk,
      q_o => q_o,
      q_n_o => q_n_o,
      d_i => d,
      clr_n_i => clr_n
      );

  p_drive_ffd: process
  begin
    d <= '1';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    clk <= '0';
    wait for 1 ns;
    clr_n <= '0';
    clk <= '1';
    wait for 1 ns;
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    clr_n <= '1';
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    clk <= '0';
    d <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
    clk <= '0';
    wait for 1 ns;
    std.env.finish;
  end process;

end ffd_tb_arch;
