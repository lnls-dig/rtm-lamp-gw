------------------------------------------------------------------------------
-- Title      : Magnet model test bench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-09-26
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: Vary the voltage applied to the magnet_model model (resistor -
--              inductor) to show the resulting current waveform.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-09-26  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

entity magnet_model_tb is
  port (
    cur_out: out real
    );
end magnet_model_tb;

architecture magnet_model_tb_arch of magnet_model_tb is
  signal volt_in: real := 0.0;
begin

  magnet_model_inst: entity work.magnet_model
    generic map (
      r => 1.0,
      l => 3.5e-3,
      time_step => 1.0e-5
      )
    port map (
      volt_in => volt_in,
      cur_out => cur_out
      );

  process
  begin
    wait for 1 ms;
    volt_in <= 4.0;
    wait for 5 ms;
    volt_in <= 1.0;
    wait for 5 ms;
    std.env.finish;
  end process;

end magnet_model_tb_arch;
