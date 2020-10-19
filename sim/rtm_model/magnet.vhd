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

entity magnet is
  generic(
    r: real := 1.0;                     -- Series resistance [Ohms]
    l: real := 3.5e-3;                  -- Inductance [H]
    time_step: real := 1.0e-5           -- Time step [s]
    );
  port(
    volt_in: in real;
    cur_out: out real := 0.0
    );
end magnet;

architecture magnet_arch of magnet is
  signal current: real := 0.0;
begin

  cur_out <= current;

  process
  begin
    loop
      wait for time_step * 1 sec;
      current <= current + (time_step / l) * (volt_in - r * current);
    end loop;
  end process;

end magnet_arch;
