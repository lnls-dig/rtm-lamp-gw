------------------------------------------------------------------------------
-- Title      : LTC2320 / LTC2324 simulation model (LVDS DDR)
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-09-30
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: A simple vhdl model of the LTC232x ADC digital and analog
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

entity ltc232x_model is
  generic (
    g_ref:      real := 4.096;
    g_channels: integer := 8;
    g_ddr_mode: boolean := true
    );
  port (
    cnv_n_i: in  std_logic;
    clk_i:   in  std_logic;
    clk_o:   out std_logic;
    sdoa_o:  out std_logic;
    sdob_o:  out std_logic;
    sdoc_o:  out std_logic;
    sdod_o:  out std_logic;
    analog_i: in real_vector (1 to g_channels)
    );
end ltc232x_model;

architecture ltc232x_model_arch of ltc232x_model is
  type acq_vector is array(1 to g_channels) of std_logic_vector(15 downto 0);
  signal analog_aq: acq_vector := (others => x"0000");
  signal delayed_cnv_n: std_logic;
  signal chn_off: integer range 1 to g_channels := 1; -- Channel offset
  signal bit_indx: integer range 0 to 15 := 15; -- Current output bit index

  function ana_to_dig(ain: real; ref: real) return std_logic_vector is
    variable ratio: real;
  begin
    ratio := ain / ref;

    if ratio > 1.0 then
      ratio := 1.0;
    elsif ratio < -1.0 then
      ratio := -1.0;
    end if;
    return std_logic_vector(to_signed(integer(ratio * 32767.0), 16));
  end function;
begin

  assert (g_channels = 8 or g_channels = 4) report "LTC232x can only have 8 or 4 g_channels" severity error;

  delayed_cnv_n <= transport cnv_n_i after (g_channels / 4) * 220 ns;
  clk_o <= transport clk_i after 2 ns;

  process(chn_off, bit_indx, analog_aq)
  begin
    if g_channels = 8 then
      sdoa_o <= analog_aq(chn_off)(bit_indx);
      sdob_o <= analog_aq(((chn_off + 1) mod g_channels) + 1)(bit_indx);
      sdoc_o <= analog_aq(((chn_off + 3) mod g_channels) + 1)(bit_indx);
      sdod_o <= analog_aq(((chn_off + 5) mod g_channels) + 1)(bit_indx);
    elsif g_channels = 4 then
      sdoa_o <= analog_aq(chn_off)(bit_indx);
      sdob_o <= analog_aq(((chn_off) mod g_channels) + 1)(bit_indx);
      sdoc_o <= analog_aq(((chn_off + 1) mod g_channels) + 1)(bit_indx);
      sdod_o <= analog_aq(((chn_off + 2) mod g_channels) + 1)(bit_indx);
    end if;
  end process;

  p_conv_clk_data: process(delayed_cnv_n, clk_o)
  begin
    if falling_edge(delayed_cnv_n) then
      for i in 1 to g_channels loop
        analog_aq(i) <= ana_to_dig(analog_i(i), g_ref);
      end loop;
      bit_indx <= 15;
      chn_off <= 1;
    elsif falling_edge(clk_o) or (rising_edge(clk_o) and g_ddr_mode) then
      if bit_indx > 0 then
        bit_indx <= bit_indx - 1;
      else
        bit_indx <= 15;
        if chn_off < g_channels then
          chn_off <= chn_off + 1;
        else
          chn_off <= 1;
        end if;
      end if;
    end if;
  end process;

end ltc232x_model_arch;
