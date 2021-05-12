------------------------------------------------------------------------------
-- Title      : Proportional Integral controller
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-05-11
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Proportional Integral controller with saturation arithmetic
-- and anti-windup
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-05-11  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pi_controller is
  generic
    (
      -- Number of bits for
      g_PRECISION: integer := 16
    );
  port
    (
      -- Reset
      rst_n_i:    in  std_logic;
      -- Core clock
      clk_i:      in  std_logic;
      -- Proportional constant (2's complement)
      kp_i:       in  std_logic_vector(g_PRECISION-1 downto 0);
      -- Number of bit shifts to the right for kp
      kp_shift_i: in  integer range 0 to (2*g_PRECISION)-1;
      -- Integral constant (2's complement)
      ti_i:       in  std_logic_vector(g_PRECISION-1 downto 0);
      -- Number of bit shifts to the right for ti
      ti_shift_i: in  integer range 0 to (2*g_PRECISION)-1;
      -- Controller set-point (2's complement)
      ctrl_sp_i: in  std_logic_vector(g_PRECISION-1 downto 0);
      -- Controller feedback signal (2's complement)
      ctrl_fb_i:  in  std_logic_vector(g_PRECISION-1 downto 0);
      -- Controller output signal (2's complement)
      ctrl_sig_o: out std_logic_vector(g_PRECISION-1 downto 0)
    );
end pi_controller;

architecture pi_controller_arch of pi_controller is
  signal acc: signed((g_PRECISION*2)-1 downto 0) := (others => '0');
  signal sum: signed(g_PRECISION downto 0) := (others => '0');
  signal err: signed(g_PRECISION-1 downto 0) := (others => '0');
  signal err_kp_shifted: signed((g_PRECISION*2)-1 downto 0) := (others => '0');
  signal err_ti_shifted: signed((g_PRECISION*2)-1 downto 0) := (others => '0');

  constant c_ctrl_sig_o_max: std_logic_vector(ctrl_sig_o'range) := '0' & (ctrl_sig_o'left-1 downto 0 => '1');
  constant c_ctrl_sig_o_min: std_logic_vector(ctrl_sig_o'range) := '1' & (ctrl_sig_o'left-1 downto 0 => '0');
begin

  ctrl_sig_o <= c_ctrl_sig_o_max when signed(sum) > signed(c_ctrl_sig_o_max) else
                c_ctrl_sig_o_min when signed(sum) < signed(c_ctrl_sig_o_min) else
                std_logic_vector(resize(sum, ctrl_sig_o'length));

  err <= signed(ctrl_sp_i) - signed(ctrl_fb_i);

  process(clk_i)
    constant c_acc_max: signed(acc'range) := '0' & (acc'left-1 downto 0 => '1');
    constant c_acc_min: signed(acc'range) := '1' & (acc'left-1 downto 0 => '0');
    variable pre_acc: signed((g_PRECISION*2) downto 0) := (others => '0');
  begin
    if rising_edge(clk_i) then
      err_ti_shifted <= shift_right(signed(ti_i) * err, ti_shift_i);
      err_kp_shifted <= shift_right(signed(kp_i) * err, kp_shift_i);

      if not ((signed(sum) >= signed(c_ctrl_sig_o_max) and signed(err_ti_shifted) > 0) or
              (signed(sum) <= signed(c_ctrl_sig_o_min) and signed(err_ti_shifted) < 0)) then
        pre_acc := resize(signed(acc), pre_acc'length) + resize(err_ti_shifted, pre_acc'length);
        acc <= c_acc_max when signed(pre_acc) > signed(c_acc_max) else
               c_acc_min when signed(pre_acc) < signed(c_acc_min) else
               resize(pre_acc, acc'length);
      end if;
      sum <= resize(acc(acc'left downto g_PRECISION), sum'length) + resize(err_kp_shifted(err_kp_shifted'left downto g_PRECISION), sum'length);
    end if;
  end process;
end pi_controller_arch;
