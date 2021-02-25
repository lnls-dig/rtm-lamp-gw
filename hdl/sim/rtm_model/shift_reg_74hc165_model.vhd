------------------------------------------------------------------------------
-- Title      : 74HC165 simulation model
------------------------------------------------------------------------------
-- Author     : Lucas Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-02-24
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: A simple vhdl model of the 74HC165 shift register.
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2021-02-24  1.0      lucas.russo     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_reg_74hc165_model is
  port (
    pl_n_i   : in  std_logic;
    ce_n_i   : in  std_logic := '0';
    dp_i     : in  std_logic_vector(7 downto 0);
    cp_i     : in  std_logic;
    ds_i     : in  std_logic := '0';
    q7_o     : out std_logic;
    q7_n_o   : out std_logic
  );
end shift_reg_74hc165_model;

architecture shift_reg_74hc165_model_arch of shift_reg_74hc165_model is
  signal q   : std_logic_vector(7 downto 0);
  signal q7  : std_logic;
begin

  q7_o <= q7;
  q7_n_o <= not q7;

  p_load_shift : process(pl_n_i, cp_i)
  begin
    if pl_n_i = '0' then
      q <= dp_i;
    elsif rising_edge(cp_i) then
      if ce_n_i = '0' then
        q <= q(q'left-1 downto 0) & ds_i;
      end if;
    end if;
  end process;

  q7 <= q(7);

end shift_reg_74hc165_model_arch;
