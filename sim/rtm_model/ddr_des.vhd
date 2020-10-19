------------------------------------------------------------------------------
-- Title      : DDR deserializer
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-06
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Generic DDR signal deserializer
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

entity ddr_des is
  generic(
    bits : integer := 32;
    polarity: boolean := true;
    msb_first: boolean := true
    );
  port(
    clk_ddr_i        : in  std_logic;
    data_ddr_i       : in  std_logic;
    data_latch_i     : in  std_logic;
    parallel_o       : out std_logic_vector(bits-1 downto 0)
    );
end ddr_des;

architecture ddr_des_arch of ddr_des is
  signal ddr_reg_pos : std_logic_vector((bits/2 - 1) downto 0);
  signal ddr_reg_neg : std_logic_vector((bits/2 - 1) downto 0);
begin

  process(clk_ddr_i)
  begin
    if rising_edge(clk_ddr_i) then
      if msb_first then
        ddr_reg_pos <= ddr_reg_pos(ddr_reg_pos'high - 1 downto ddr_reg_pos'low) & data_ddr_i;
      else
        ddr_reg_pos <= data_ddr_i & ddr_reg_pos(ddr_reg_pos'high downto ddr_reg_pos'low + 1);
      end if;
    elsif falling_edge(clk_ddr_i) then
      if msb_first then
        ddr_reg_neg <= ddr_reg_neg(ddr_reg_neg'high - 1 downto ddr_reg_neg'low) & data_ddr_i;
      else
        ddr_reg_neg <= data_ddr_i & ddr_reg_neg(ddr_reg_neg'high downto ddr_reg_neg'low + 1);
      end if;
    end if;
  end process;

  process(data_latch_i)
  begin
    if rising_edge(data_latch_i) then
      if polarity then
        for i in 0 to (bits/2 - 1) loop
            parallel_o(i * 2 + 1) <= ddr_reg_pos(i);
            parallel_o(i * 2) <= ddr_reg_neg(i);
          end loop;
        else
          for i in 0 to (bits/2 - 1) loop
            parallel_o(i * 2) <= ddr_reg_pos(i);
            parallel_o(i * 2 + 1) <= ddr_reg_neg(i);
          end loop;
      end if;
    end if;
  end process;

end ddr_des_arch;
