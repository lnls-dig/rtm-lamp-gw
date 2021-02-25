------------------------------------------------------------------------------
-- Title      : 74HC595 simulation model
------------------------------------------------------------------------------
-- Author     : Lucas Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-02-24
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: A simple vhdl model of the 74HC595 shift register.
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

entity shift_reg_74hc595_model is
  port (
    mr_n_i   : in  std_logic := '1';
    shcp_i   : in  std_logic;
    stcp_i   : in  std_logic;
    oe_n_i   : in  std_logic;
    ds_i     : in  std_logic := '0';
    q_o      : out std_logic_vector(7 downto 0);
    q7s_o    : out std_logic
  );
end shift_reg_74hc595_model;

architecture shift_reg_74hc595_model_arch of shift_reg_74hc595_model is
  signal qs   : std_logic_vector(7 downto 0);
  signal qp   : std_logic_vector(7 downto 0);
  signal q7s  : std_logic;
begin

  p_oe : process(oe_n_i, qp)
  begin
    if oe_n_i = '0' then
      q_o <= qp;
    else
      q_o <= (others => 'Z');
    end if;
  end process;

  q7s_o <= q7s;

  p_shift_qs : process(mr_n_i, shcp_i)
  begin
    if mr_n_i = '0' then
      qs <= (others => '0');
    elsif rising_edge(shcp_i) then
      qs <= qs(qs'left-1 downto 0) & ds_i;
    end if;
  end process;

  q7s <= qs(7);

  p_load_qp : process(stcp_i)
  begin
    if rising_edge(stcp_i) then
      qp <= qs;
    end if;
  end process;

end shift_reg_74hc595_model_arch;
