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
      -- Controller feedback valid signal
      ctrl_fb_valid_i: in std_logic;
      -- Controller output signal (2's complement)
      ctrl_sig_o: out std_logic_vector(g_PRECISION-1 downto 0);
      -- Controller output valid signal
      ctrl_sig_valid_o: out std_logic;
      -- Monitoring outputs
      dbg_acc_o : out std_logic_vector(g_PRECISION*2-1 downto 0);
      dbg_acc_valid_o : out std_logic;
      dbg_sum_o : out std_logic_vector(g_PRECISION downto 0);
      dbg_sum_valid_o : out std_logic
    );
end pi_controller;

architecture pi_controller_arch of pi_controller is
  signal pre_acc: signed((g_PRECISION*2) downto 0) := (others => '0');
  signal pre_acc_valid : std_logic;
  signal acc: signed((g_PRECISION*2)-1 downto 0) := (others => '0');
  signal acc_valid : std_logic;
  signal sum: signed(g_PRECISION downto 0) := (others => '0');
  signal sum_valid : std_logic;
  signal err: signed(g_PRECISION-1 downto 0);
  signal err_valid : std_logic;
  signal kp_reg: std_logic_vector(g_PRECISION-1 downto 0);
  signal ti_reg: std_logic_vector(g_PRECISION-1 downto 0);
  signal err_kp_pre: signed((g_PRECISION*2)-1 downto 0);
  signal err_ti_pre: signed((g_PRECISION*2)-1 downto 0);
  signal err_mult_pre_valid : std_logic;
  signal err_kp: signed((g_PRECISION*2)-1 downto 0);
  signal err_ti: signed((g_PRECISION*2)-1 downto 0);
  signal err_mult_valid : std_logic;
  signal err_kp_shifted: signed((g_PRECISION*2)-1 downto 0) := (others => '0');
  signal err_ti_shifted: signed((g_PRECISION*2)-1 downto 0) := (others => '0');
  signal err_mult_shifted_valid : std_logic;
  signal ctrl_fb_valid: std_logic;
  signal ctrl_fb: std_logic_vector(g_PRECISION-1 downto 0);
  signal ctrl_sig: std_logic_vector(g_PRECISION-1 downto 0);
  signal ctrl_sig_valid : std_logic;

  constant c_ctrl_sig_max: std_logic_vector(ctrl_sig'range) := '0' & (ctrl_sig'left-1 downto 0 => '1');
  constant c_ctrl_sig_min: std_logic_vector(ctrl_sig'range) := '1' & (ctrl_sig'left-1 downto 0 => '0');

  -- From wishbone_pkg.vhd
  -- If any of the bits are '1', the whole thing is '1'
  -- This function makes the check explicitly have logarithmic depth.
  function vector_OR(x : std_logic_vector)
    return std_logic
  is
    constant len : integer := x'length;
    constant mid : integer := len / 2;
    alias y : std_logic_vector(len-1 downto 0) is x;
  begin
    if len = 1
    then return y(0);
    else return vector_OR(y(len-1 downto mid)) or
                vector_OR(y(mid-1 downto 0));
    end if;
  end vector_OR;

  -- From wishbone_pkg.vhd
  -- If any of the bits are '0', the whole thing is '0'
  -- This function makes the check explicitly have logarithmic depth.
  function vector_AND(x : std_logic_vector)
    return std_logic
  is
    constant len : integer := x'length;
    constant mid : integer := len / 2;
    alias y : std_logic_vector(len-1 downto 0) is x;
  begin
    if len = 1
    then return y(0);
    else return vector_AND(y(len-1 downto mid)) and
                vector_AND(y(mid-1 downto 0));
    end if;
  end vector_AND;

  function f_replicate(x : std_logic; len : natural)
    return std_logic_vector
  is
    variable v_ret : std_logic_vector(len-1 downto 0) := (others => x);
  begin
    return v_ret;
  end f_replicate;

  -- Converted from Verilog from LBL Bedrock repository:
  -- `define SAT(x,old,new) ((~|x[old:new] | &x[old:new]) ? x[new:0] : {x[old],{new{~x[old]}}})
  function f_saturate(x : std_logic_vector; x_new_msb : natural)
    return std_logic_vector
  is
    constant x_old_msb : natural := x'left;
    variable v_is_in_range : std_logic;
    variable v_x_sat : std_logic_vector(x_new_msb downto 0);
  begin
    -- Check if signed overflow (all bits 0) or signed underflow (all bits 1)
    v_is_in_range := (not vector_OR(x(x_old_msb downto x_new_msb)) or
                (vector_AND(x(x_old_msb downto x_new_msb))));

    if v_is_in_range = '1' then
      -- just drop the redundant MSB bits
      v_x_sat := x(x_new_msb downto 0);
    else
      -- saturate negative 10...0 or positive 01...1
      v_x_sat := x(x_old_msb) & f_replicate(not x(x_old_msb), x_new_msb);
    end if;

    return v_x_sat;
  end f_saturate;

begin

  err_ti_shifted <= shift_right(err_ti, ti_shift_i);
  err_kp_shifted <= shift_right(err_kp, kp_shift_i);
  err_mult_shifted_valid <= err_mult_valid;

  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        pre_acc <= (others => '0');
        pre_acc_valid <= '0';
        acc <= (others => '0');
        acc_valid <= '0';
        sum <= (others => '0');
        sum_valid <= '0';
        err <= (others => '0');
        err_valid <= '0';
        ti_reg <= (others => '0');
        kp_reg <= (others => '0');
        err_ti_pre <= (others => '0');
        err_kp_pre <= (others => '0');
        err_mult_pre_valid <= '0';
        err_ti <= (others => '0');
        err_kp <= (others => '0');
        err_mult_valid <= '0';
        ctrl_sig <= (others => '0');
        ctrl_sig_valid <= '0';
        ctrl_fb <= (others => '0');
        ctrl_fb_valid <= '0';
      else
        ctrl_fb_valid <= ctrl_fb_valid_i;
        if ctrl_fb_valid_i = '1' then
          ctrl_fb <= ctrl_fb_i;
        end if;

        err <= signed(ctrl_sp_i) - signed(ctrl_fb);
        err_valid <= ctrl_fb_valid;

        -- input mult pipeline reg
        ti_reg <= ti_i;
        kp_reg <= kp_i;
        -- mult
        err_ti_pre <= signed(ti_reg) * err;
        err_kp_pre <= signed(kp_reg) * err;
        err_mult_pre_valid <= err_valid;
        -- output mult pipeline reg
        err_ti <= err_ti_pre;
        err_kp <= err_kp_pre;
        err_mult_valid <= err_mult_pre_valid;

        -- integral stage
        if err_mult_shifted_valid = '1' and (
                not ((signed(sum) >= signed(c_ctrl_sig_max) and signed(err_ti_shifted) > 0) or
                (signed(sum) <= signed(c_ctrl_sig_min) and signed(err_ti_shifted) < 0))) then
          pre_acc <= resize(signed(acc), pre_acc'length) +
                     resize(err_ti_shifted, pre_acc'length);
        end if;
        pre_acc_valid <= err_mult_shifted_valid;

        acc <= signed(f_saturate(std_logic_vector(pre_acc), acc'left));
        acc_valid <= pre_acc_valid;

        -- proportional stage
        if acc_valid = '1' then
          sum <= resize(acc(acc'left downto g_PRECISION), sum'length) +
                  resize(err_kp_shifted(err_kp_shifted'left downto g_PRECISION), sum'length);
        end if;
        sum_valid <= acc_valid;

        ctrl_sig <= f_saturate(std_logic_vector(sum), ctrl_sig'left);
        ctrl_sig_valid <= sum_valid;

      end if;
    end if;
  end process;

  ctrl_sig_o <= ctrl_sig;
  ctrl_sig_valid_o <= ctrl_sig_valid;

  -- monitoring
  dbg_acc_o <= std_logic_vector(acc);
  dbg_acc_valid_o <= acc_valid;
  dbg_sum_o <= std_logic_vector(sum);
  dbg_sum_valid_o <= sum_valid;

end pi_controller_arch;
