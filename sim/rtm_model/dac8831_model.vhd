------------------------------------------------------------------------------
-- Title      : DAC8831 simulation model
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-09-30
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: A simple vhdl model of the DAC8831 DAC digital and analog
--              interfaces.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-09-30  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dac8831_model is
  generic(
    g_ref  : real := 4.0);
  port(
    cs_i   : in  std_logic;
    sck_i  : in  std_logic;
    sdi_i  : in  std_logic;
    ldac_i : in  std_logic;
    vout_o : out real := 0.0);
end dac8831_model;

architecture dac8831_model_arch of dac8831_model is
  signal data_buf : std_logic_vector(15 downto 0);
  signal vout_buf: real := 0.0;

  function dig_to_ana(data: std_logic_vector (15 downto 0); reference: real)
    return real is
  begin
    return (real(to_integer(unsigned(data))) / 65536.0) * reference;
  end function;
begin

  p_recv_data: process(cs_i, sck_i)
    variable bit_indx : integer := 15;
  begin
    if falling_edge(cs_i) then
      bit_indx := 15;
    elsif cs_i = '0' then
      if rising_edge(sck_i) then
        data_buf(bit_indx) <= sdi_i;
      else
        if bit_indx > 0 then
          bit_indx := bit_indx - 1;
        end if;
      end if;
    elsif rising_edge(cs_i) then
      vout_buf <= dig_to_ana(data_buf, g_ref);
    end if;
  end process;

  with ldac_i select
    vout_o <=
    vout_buf when '0',
    vout_o when others;

end dac8831_model_arch;
