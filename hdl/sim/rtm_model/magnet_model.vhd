------------------------------------------------------------------------------
-- Title      : Magnet simulation model
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-09-26
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: A simple resistor - inductor model of an electromagnet.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-09-26  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

entity magnet_model is
  generic(
    g_RES:       real := 1.0;           -- Series resistance [Ohms]
    g_IND:       real := 3.5e-3;        -- Inductance [H]
    g_TIME_STEP: real := 1.0e-5         -- Time step [s]
    );
  port(
    volt_i: in  real;
    cur_o:  out real := 0.0
    );
end magnet_model;

architecture magnet_model_arch of magnet_model is
  signal current: real := 0.0;
begin

  cur_o <= current;

  p_calc_cur: process
  begin
    loop
      wait for g_TIME_STEP * 1 sec;
      current <= current + (g_TIME_STEP / g_IND) * (volt_i - g_RES * current);
    end loop;
  end process;

end magnet_model_arch;
