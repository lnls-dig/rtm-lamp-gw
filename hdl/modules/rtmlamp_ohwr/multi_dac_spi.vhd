------------------------------------------------------------------------------
-- Title      : Multiple SPI DAC controller
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-11-13
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Control multiple 16 bits SPI DACs sharing the CS and SCK
-- signals.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-11-13  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.rtm_lamp_pkg.all;

entity multi_dac_spi is
  generic(
    g_CLK_FREQ:      natural := 100_000_000; -- Core clock frequency [Hz], should
                                             -- be an integer multiple of
                                             -- g_SCLK_FREQ, at least double the frequency
    g_SCLK_FREQ:     natural := 50_000_000;  -- DAC sck frequency [Hz]
    g_NUM_DACS:      natural := 8;           -- Number of DACs to control
    g_CPOL:          boolean := false        -- Clock polarity:
                                             --   false - bit shifted on
                                             --   falling edge;
                                             --   true - bit shifted on
                                             --   rising edge;
    );
  port(
    clk_i:       in  std_logic;         -- Master system clock
    rst_n_i:     in  std_logic;         -- Synchrnous reset (active low)
    start_i:     in  std_logic;         -- Start the transfer
    ready_o:     out std_logic := '0';  -- '0': there is an ongoing transfer
                                        -- '1': ready to start a new transfer
    done_pp_o:   out std_logic;         -- pulse when finished transferred
    data_i:      in  t_16b_word_array(g_NUM_DACS-1 downto 0);
    dac_cs_n_o:  out std_logic;  -- DAC chip select
    dac_sck_o:   out std_logic;  -- DAC data clock
    dac_sdi_o:   out std_logic_vector(g_NUM_DACS-1 downto 0) -- Serial data outputs
    );
end multi_dac_spi;

architecture multi_dac_spi_arch of multi_dac_spi is
  constant c_SCK_DIV_CNT: natural := (g_CLK_FREQ / (2*g_sclk_freq)) - 1;
  constant c_NUM_DATA_BITS: natural := 16;
  type t_state is (IDLE, CS_DELAY, TRANSFERING);
  signal state: t_state := IDLE;
  signal dac_sck: std_logic := '0';
  signal data_buf: t_16b_word_array(g_NUM_DACS-1 downto 0);
  signal bit_cnt: natural range 0 to c_NUM_DATA_BITS := c_NUM_DATA_BITS-1;
begin

  dac_sck_o <= not dac_sck when g_CPOL else dac_sck;

  gen_dac_sdi:
  for i in 0 to g_NUM_DACS-1 generate
    dac_sdi_o(i) <= data_buf(i)(data_buf(i)'left);
  end generate;

  p_dac_ctrl: process(clk_i)
    variable v_sck_div_cnt: integer range 0 to c_SCK_DIV_CNT := 0;
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        state <= IDLE;
        dac_cs_n_o <= '1';
        bit_cnt <= c_NUM_DATA_BITS-1;
        v_sck_div_cnt := 0;
        dac_sck <= '0';
        -- if we are in reset state we can't be ready
        ready_o <= '0';
        done_pp_o <= '0';
      else
        done_pp_o <= '0';

        case state is
          when IDLE =>
            ready_o <= '1';

            if start_i = '1' then
              dac_cs_n_o <= '0';
              state <= CS_DELAY;
              data_buf <= data_i;
              ready_o <= '0';
            end if;

          when CS_DELAY =>
            if v_sck_div_cnt = c_SCK_DIV_CNT then
              v_sck_div_cnt := 0;
              state <= TRANSFERING;
            else
              v_sck_div_cnt := v_sck_div_cnt + 1;
            end if;

          when TRANSFERING =>
            if v_sck_div_cnt = c_SCK_DIV_CNT then
              v_sck_div_cnt := 0;

              if dac_sck = '1' then
                if bit_cnt = 0 then
                  state <= IDLE;
                  ready_o <= '1';        -- Signals that the module is ready
                                         -- to start a new transfer
                  done_pp_o <= '1';
                  dac_cs_n_o <= '1';
                  bit_cnt <= c_NUM_DATA_BITS-1;
                  v_sck_div_cnt := 0;
                  dac_sck <= '0';
                else
                  bit_cnt <= bit_cnt - 1;

                  for i in 0 to g_NUM_DACS-1 loop
                    data_buf(i) <= data_buf(i)(data_buf(i)'left-1 downto 0) & '0';
                  end loop;
                end if;
              end if;

              dac_sck <= not dac_sck;
            else
              v_sck_div_cnt := v_sck_div_cnt + 1;
            end if;
        end case;
      end if;
    end if;
  end process;
end multi_dac_spi_arch;
