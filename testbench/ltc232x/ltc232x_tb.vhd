------------------------------------------------------------------------------
-- Title      : LTC2320 model testbench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-01
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: Apply different voltages to each ADC channel and read the
--              converted digital value back.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-10-01  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ltc232x_model_tb is
  port (
    sdoa_o: out std_logic;
    sdob_o: out std_logic;
    sdoc_o: out std_logic;
    sdod_o: out std_logic;
    clk_o: out std_logic;
    signal ch1_o, ch2_o, ch3_o, ch4_o: out std_logic_vector(15 downto 0);
    signal ch5_o, ch6_o, ch7_o, ch8_o: out std_logic_vector(15 downto 0)
    );
end ltc232x_model_tb;

architecture ltc232x_model_tb_arch of ltc232x_model_tb is
  signal cnv_n: std_logic := '0';
  signal clk_i: std_logic := '0';
  signal analog_i: real_vector (1 to 8) :=
    (2.735, 2.048, 4.096, -1.024, -2.048, -4.096, 3.000, 2.0);
  signal samp_start: std_logic := '0';
  signal sdoa_delay, sdob_delay, sdoc_delay, sdod_delay: std_logic;
begin

  ltc2320_inst: entity work.ltc232x_model
    port map (
      cnv_n_i => cnv_n,
      clk_i => clk_i,
      clk_o => clk_o,
      sdoa_o => sdoa_o,
      sdob_o => sdob_o,
      sdoc_o => sdoc_o,
      sdod_o => sdod_o,
      analog_i => analog_i
      );

  -- The datalines should be delayed in relation to the returned adc
  -- clock when reading in DDR mode
  sdoa_delay <= transport sdoa_o after 1 ns;
  sdob_delay <= transport sdob_o after 1 ns;
  sdoc_delay <= transport sdoc_o after 1 ns;
  sdod_delay <= transport sdod_o after 1 ns;

  process
  begin
    wait for 10 ns;
    cnv_n <= '1';
    wait for 30 ns;
    cnv_n <= '0';
    wait for 500 ns;
    samp_start <= '1';
    wait for 1 ns;
    for i in 0 to 15 loop
      clk_i <= '1';
      wait for 10 ns;
      clk_i <= '0';
      wait for 10 ns;
    end loop;
    wait for 10 ns;
    std.env.finish;
  end process;

  process(clk_o)
  begin
    if clk_o'event then
        ch1_o <= ch1_o(14 downto 0) & ch2_o(15);
        ch3_o <= ch3_o(14 downto 0) & ch4_o(15);
        ch5_o <= ch5_o(14 downto 0) & ch6_o(15);
        ch7_o <= ch7_o(14 downto 0) & ch8_o(15);
        ch2_o <= ch2_o(14 downto 0) & sdoa_delay;
        ch4_o <= ch4_o(14 downto 0) & sdob_delay;
        ch6_o <= ch6_o(14 downto 0) & sdoc_delay;
        ch8_o <= ch8_o(14 downto 0) & sdod_delay;
    end if;
  end process;

end ltc232x_model_tb_arch;
