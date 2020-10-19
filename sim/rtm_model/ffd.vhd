------------------------------------------------------------------------------
-- Title      : D flip flop
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-09-25
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: D flip flop
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

entity ffd is
  port (
    d: in std_logic;
    clk: in std_logic;
    clr_n: in std_logic;
    q: out std_logic;
    q_n: out std_logic
    );
end ffd;

architecture ffd_arch of ffd is
  signal q_state: std_logic := '0';
begin
  q <= q_state;
  q_n <= not q_state;

  process(clr_n, clk)
  begin
    if clr_n = '0' then
      q_state <= '0';
    elsif rising_edge(clk) then
      q_state <= d;
    end if;
  end process;

end ffd_arch;
