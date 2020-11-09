------------------------------------------------------------------------------
-- Title      : DAC8831 model testbench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-09-30
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: Write to the DAC register and check the output voltages.
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

entity dac8831_model_tb is
  generic(
    ref: real := 4.0
    );
  port(
    vout_o : out real
    );
end dac8831_model_tb;

architecture dac8831_model_tb_arch of dac8831_model_tb is
  constant dac_val1 : std_logic_vector(15 downto 0) := x"8000";
  constant dac_val2 : std_logic_vector(15 downto 0) := x"4000";
  signal cs : std_logic := '1';
  signal sck : std_logic := '0';
  signal ldac : std_logic := '1';
  signal sdi : std_logic := '0';
begin

  dac8831_model_inst: entity work.dac8831_model
    generic map(ref)
    port map(
      cs_i => cs,
      sck_i => sck,
      sdi_i => sdi,
      ldac_i => ldac,
      vout_o => vout_o
      );

  process
  begin
    wait for 10 ns;
    cs <= '0';
    wait for 10 ns;
    for i in 0 to 15 loop
      sck <= '0';
      sdi <= dac_val1(15 - i);
      wait for 10 ns;
      sck <= '1';
      wait for 10 ns;
    end loop;
    sck <= '0';
    cs <= '1';
    wait for 10 ns;
    ldac <= '0';
    wait for 10 ns;
    ldac <= '1';
    wait for 20 ns;
    ldac <= '0';
    wait for 10 ns;
        cs <= '0';
    wait for 10 ns;
    for i in 0 to 15 loop
      sck <= '0';
      sdi <= dac_val2(15 - i);
      wait for 10 ns;
      sck <= '1';
      wait for 10 ns;
    end loop;
    sck <= '0';
    cs <= '1';
    wait for 10 ns;
    sck <= '0';
    wait for 10 ns;
    std.env.finish;
  end process;

end dac8831_model_tb_arch;
