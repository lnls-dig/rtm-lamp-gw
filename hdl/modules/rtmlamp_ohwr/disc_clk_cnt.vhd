-------------------------------------------------------------------------------
-- Title      : Counter for discontinuous clock sources
-------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-GCA
-- Platform   : FPGA-generic
-- Standard   : VHDL 2008
-------------------------------------------------------------------------------
-- Description: This is a special type of counter that can be used with
--              discontinuous clock sources used in synchronous serial
--              protocols like SPI and I2C. It uses gray encoding internally
--              to guarantee that bit errors due metastability don't produce
--              invalid values when reading from 'clk_i' clock domain.
-------------------------------------------------------------------------------
-- Copyright (c) 2022 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author                Description
-- 2022-11-04  1.0      augusto.fraga         Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.gencores_pkg.all;

entity disc_clk_cnt is
  generic (
    -- Counter bit width
    g_CNT_SIZE  : natural
    );
  port (
    clk_i       : in  std_logic;
    -- Clear counter (clock domain: clk_i)
    clear_cnt_i : in  std_logic;
    -- Counter value (clock domain: clk_i)
    cnt_o       : out unsigned(g_CNT_SIZE-1 downto 0);

    -- Discontinous clock source
    clk_disc_i  : in  std_logic;
    -- Increment counter (clock domain: clk_disc_i)
    inc_i       : in  std_logic
    );
end disc_clk_cnt;

architecture rtl of disc_clk_cnt is
  signal cnt        : std_logic_vector(g_CNT_SIZE-1 downto 0) := (others => '0');
  signal cnt_sync   : unsigned(g_CNT_SIZE-1 downto 0) := (others => '0');
  signal cnt_shadow : unsigned(g_CNT_SIZE-1 downto 0) := (others => '0');
begin

  cnt_o <= cnt_sync + cnt_shadow;

  process(clk_i) is
  begin
    if rising_edge(clk_i) then
      cnt_sync <= unsigned(f_gray_decode(cnt, 1));
      if clear_cnt_i = '1' then
        -- cnt_shadow is used to 'clear' cnt_o by storing '-cnt_sync' in two's
        -- complement
        cnt_shadow <= not(cnt_sync) + 1;
      end if;
    end if;
  end process;

  process(clk_disc_i)
  begin
    if rising_edge(clk_disc_i) then
      if inc_i = '1' then
        -- Use gray encoding for cnt
        cnt <= f_gray_encode(std_logic_vector(unsigned(f_gray_decode(cnt, 1)) + 1));
      end if;
    end if;
  end process;
end architecture rtl;
