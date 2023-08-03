-------------------------------------------------------------------------------
-- Title      : CNV and LDAC pulse generator
-------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-GIE
-- Platform   : FPGA-generic
-- Standard   : VHDL 2008
-------------------------------------------------------------------------------
-- Description: Generate synchronized out of phase CNV and LDAC pulses
-------------------------------------------------------------------------------
-- Copyright (c) 2023 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author                Description
-- 2023-07-17  1.0      augusto.fraga         Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cnv_ldac_pulse_gen is
  generic (
    g_ldac_width    : natural range 1 to 256;
    g_ldac_polarity : string := "ACTIVE_HIGH";
    g_cnv_width     : natural range 1 to 256;
    g_cnv_polarity  : string := "ACTIVE_HIGH"
  );
  port (
    clk_i        : std_logic;
    rst_n        : std_logic;
    cnv_o        : std_logic;
    ldac_o       : std_logic
  );
end entity;

architecture rtl of cnv_ldac_pulse_gen is
begin
end architecture;
