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
    signal ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8: out std_logic_vector(15 downto 0)
    );
end ltc232x_model_tb;

architecture ltc232x_model_tb_arch of ltc232x_model_tb is
  signal cnv_n: std_logic := '0';
  signal clk_i: std_logic := '0';
  signal analog_i: real_vector (1 to 8) :=
    (2.735, 2.048, 4.096, -1.024, -2.048, -4.096, 3.000, 2.0);
  signal samp_start: std_logic := '0';
  signal ch1_buf, ch2_buf, ch3_buf, ch4_buf: std_logic_vector(15 downto 0);
  signal ch5_buf, ch6_buf, ch7_buf, ch8_buf: std_logic_vector(15 downto 0);
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

  process(cnv_n, clk_i, clk_o)
    variable bit_indx: integer := 15;
    variable chn_off: std_logic := '0';
  begin
    if falling_edge(cnv_n) then
      bit_indx := 15;
      chn_off := '0';
    elsif clk_o'event then
      if bit_indx = 0 then
        bit_indx := 15;
        chn_off := not chn_off;
        ch1 <= ch1_buf;
        ch2 <= ch2_buf;
        ch3 <= ch3_buf;
        ch4 <= ch4_buf;
        ch5 <= ch5_buf;
        ch6 <= ch6_buf;
        ch7 <= ch7_buf;
        ch8 <= ch8_buf;
      else
        bit_indx := bit_indx - 1;
      end if;
    end if;

    if clk_i'event then
      if chn_off = '0' then
        ch1_buf(bit_indx) <= sdoa_o;
        ch3_buf(bit_indx) <= sdob_o;
        ch5_buf(bit_indx) <= sdoc_o;
        ch7_buf(bit_indx) <= sdod_o;
      else
        ch2_buf(bit_indx) <= sdoa_o;
        ch4_buf(bit_indx) <= sdob_o;
        ch6_buf(bit_indx) <= sdoc_o;
        ch8_buf(bit_indx) <= sdod_o;
      end if;
    end if;
  end process;

end ltc232x_model_tb_arch;
