------------------------------------------------------------------------------
-- Title      : LTC232x acquisition module
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-22
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Flexible acquisition module for LTC232x ADCs
--
-- Supported configurations:
-- +----------+------------+
-- | Channels | Data Lines |
-- +----------+------------+
-- |     8    | 8, 4, 2, 1 |
-- +----------+------------+
-- |     4    |   4, 2, 1  |
-- +----------+------------+
-- |     2    |    2, 1    |
-- +----------+------------+
-- |     1    |     1      |
-- +----------+------------+
--
-- This core supports both LVDS and CMOS modes:
-- +---------------------------------------------+
-- |                 8 channels                  |
-- +------------+----------------+---------------+
-- | Data lines |    CMOS Mode   |   LVDS mode   |
-- +------------+----------------+---------------+
-- |            | sdo1 => sdo1a  |               |
-- |            | sdo2 => sdo2   |               |
-- |            | sdo3 => sdo3b  |               |
-- |      8     | sdo4 => sdo4   |      N/A      |
-- |            | sdo5 => sdo5c  |               |
-- |            | sdo6 => sdo6   |               |
-- |            | sdo7 => sdo7d  |               |
-- |            | sdo8 => sdo8   |               |
-- +------------+----------------+---------------+
-- |            | sdo1 => sdo1a  | sdoa => sdo1a |
-- |      4     | sdo3 => sdo3b  | sdob => sdo3b |
-- |            | sdo5 => sdo5c  | sdoc => sdo5c |
-- |            | sdo7 => sdo7d  | sdod => sdo7d |
-- +------------+----------------+---------------+
-- |      2     | sdo1 => sdo1a  | sdoa => sdo1a |
-- |            | sdo5 => sdo5c  | sdoc => sdo5c |
-- +------------+----------------+---------------+
-- |      1     | sdo1 => sdo1a  | sdoa => sdo1a |
-- +------------+----------------+---------------+
--
-- +---------------------------------------------+
-- |                 4 channels                  |
-- +------------+----------------+---------------+
-- | Data lines |    CMOS Mode   |   LVDS mode   |
-- +------------+----------------+---------------+
-- |      8     |      N/A       |      N/A      |
-- +------------+----------------+---------------+
-- |            | sdo1 => sdo1a  | sdoa => sdo1a |
-- |      4     | sdo2 => sdo3b  | sdob => sdo3b |
-- |            | sdo3 => sdo5c  | sdoc => sdo5c |
-- |            | sdo4 => sdo7d  | sdod => sdo7d |
-- +------------+----------------+---------------+
-- |      2     | sdo1 => sdo1a  | sdoa => sdo1a |
-- |            | sdo3 => sdo5c  | sdoc => sdo5c |
-- +------------+----------------+---------------+
-- |      1     | sdo1 => sdo1a  | sdoa => sdo1a |
-- +------------+----------------+---------------+
--
-- +---------------------------------------------+
-- |                 2 channels                  |
-- +------------+----------------+---------------+
-- | Data lines |    CMOS Mode   |   LVDS mode   |
-- +------------+----------------+---------------+
-- |      8     |      N/A       |      N/A      |
-- +------------+----------------+---------------+
-- |      4     |      N/A       |      N/A      |
-- +------------+----------------+---------------+
-- |      2     | sdo1 => sdo1a  | sdo1 => sdo1a |
-- |            | sdo2 => sdo5c  | sdo2 => sdo5c |
-- +------------+----------------+---------------+
-- |      1     | sdo1 => sdo1a  | sdo1 => sdo1a |
-- +------------+----------------+---------------+
--
-- +---------------------------------------------+
-- |                 1 channel                   |
-- +------------+----------------+---------------+
-- | Data lines |    CMOS Mode   |   LVDS mode   |
-- +------------+----------------+---------------+
-- |      8     |      N/A       |      N/A      |
-- +------------+----------------+---------------+
-- |      4     |      N/A       |      N/A      |
-- +------------+----------------+---------------+
-- |      2     |      N/A       |      N/A      |
-- +------------+----------------+---------------+
-- |      1     | sdo1 => sdo1a  | sdo1 => sdo1a |
-- +------------+----------------+---------------+
--
-- Only SDR mode is supported now, DDR mode may be implemented in the future.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-10-22  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

library work;
use work.genram_pkg.all;

entity ltc232x_acq is
  generic(
    g_clk_freq:   natural := 100_000_000; -- Core clock frequency [Hz], should
                                          -- be an integer multiple of
                                          -- g_sclk_freq, at least double the frequency
                                          --
    g_sclk_freq:  natural := 50_000_000;  -- ADC sck frequency [Hz]
    g_bits:       natural := 16;          -- Sample bit size
    g_channels:   natural := 8;           -- Number of channels
    g_data_lines: natural := 8;           -- Number of data lines
    g_cnv_wait:   real := 450.0e-9        -- Conversion wait time
    );
  port(
    rst_n_i:    in  std_logic;                           -- Reset
    clk_i:      in  std_logic;                           -- Core clock
    start_i:    in  std_logic;                           -- Start the conversion
    cnv_o:      out std_logic := '0';                    -- Drives the CNV signal
    sck_o:      out std_logic := '0';                    -- ADC input clock
    sck_ret_i:  in  std_logic;                           -- ADC return clock
    ready_o:    out std_logic := '0';                    -- '0': ongoing conversion
                                                         -- '1': ready to start conversion
    sdo1a_i:    in  std_logic;                           -- ADC output SDO1/SDOA
    sdo2_i:     in  std_logic := '0';                    -- ADC output SDO2
    sdo3b_i:    in  std_logic := '0';                    -- ADC output SDO3/SDOB
    sdo4_i:     in  std_logic := '0';                    -- ADC output SDO4
    sdo5c_i:    in  std_logic := '0';                    -- ADC output SDO5/SDOC
    sdo6_i:     in  std_logic := '0';                    -- ADC output SDO6
    sdo7d_i:    in  std_logic := '0';                    -- ADC output SDO7/SDOD
    sdo8_i:     in  std_logic := '0';                    -- ADC output SDO8
    ch1_o:      out std_logic_vector(g_bits-1 downto 0); -- CH1 parallel output
    ch2_o:      out std_logic_vector(g_bits-1 downto 0); -- CH2 parallel output
    ch3_o:      out std_logic_vector(g_bits-1 downto 0); -- CH3 parallel output
    ch4_o:      out std_logic_vector(g_bits-1 downto 0); -- CH4 parallel output
    ch5_o:      out std_logic_vector(g_bits-1 downto 0); -- CH5 parallel output
    ch6_o:      out std_logic_vector(g_bits-1 downto 0); -- CH6 parallel output
    ch7_o:      out std_logic_vector(g_bits-1 downto 0); -- CH7 parallel output
    ch8_o:      out std_logic_vector(g_bits-1 downto 0); -- CH8 parallel output
    valid_o:    out std_logic                            -- data valid output
    );
end ltc232x_acq;

architecture ltc232x_acq_arch of ltc232x_acq is
  constant c_DDR_MODE: boolean := false; -- DDR mode not supported yet
  constant c_WAIT_CONV_CYCLES: natural := integer(ceil(g_cnv_wait * real(g_clk_freq)));
  constant c_CONV_HIGH_CYCLES: natural := integer(ceil(30.0e-9 * real(g_clk_freq)));
  constant c_BITS_PER_LINE: natural := ((g_bits * g_channels) / g_data_lines);
  constant c_SCK_CLK_RATIO: natural := (g_clk_freq / g_sclk_freq);
  constant c_SCK_CLK_DIV_CNT: natural := (c_sck_clk_ratio / 2) - 1;
  type state_t is (idle, conv_high, wait_conv, read_data);
  signal state: state_t := idle;
  signal sck_o_s: std_logic := '0';
  signal fifo_rd: std_logic := '0';
  signal fifo_rd_empty: std_logic;
  signal fifo_in: std_logic_vector(g_data_lines-1 downto 0);
  signal fifo_out: std_logic_vector(g_data_lines-1 downto 0);
  signal ch1_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
  signal ch2_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
  signal ch3_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
  signal ch4_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
  signal ch5_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
  signal ch6_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
  signal ch7_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
  signal ch8_o_s: std_logic_vector(g_bits-1 downto 0) := (others =>'0');
begin

  sck_o <= sck_o_s;

  ch1_o <= ch1_o_s;
  ch2_o <= ch2_o_s;
  ch3_o <= ch3_o_s;
  ch4_o <= ch4_o_s;
  ch5_o <= ch5_o_s;
  ch6_o <= ch6_o_s;
  ch7_o <= ch7_o_s;
  ch8_o <= ch8_o_s;

  ltc_8_datalines:
  if g_data_lines = 8 generate
    fifo_in <= (sdo1a_i, sdo2_i, sdo3b_i, sdo4_i,
                sdo5c_i, sdo6_i, sdo7d_i, sdo8_i);
  end generate;

  ltc_4_datalines:
  if g_data_lines = 4 generate
    fifo_in <= (sdo1a_i, sdo3b_i, sdo5c_i, sdo7d_i);
  end generate;

  ltc_2_datalines:
  if g_data_lines = 2 generate
    fifo_in <= (sdo1a_i, sdo5c_i);
  end generate;

  ltc_1_dataline:
  if g_data_lines = 1 generate
    fifo_in(0) <= sdo1a_i;
  end generate;

  cmp_fifo: generic_async_fifo          -- Dual clocked FIFO buffer to cross
    generic map(                        -- the dada read from sck_ret_i clock
      g_data_width => g_data_lines,     -- to clk_i
      g_size => 8
      )
    port map(
      rst_n_i => rst_n_i,
      clk_wr_i => sck_ret_i,
      we_i => '1',
      d_i => fifo_in,
      clk_rd_i => clk_i,
      rd_i => fifo_rd,
      rd_empty_o => fifo_rd_empty,
      q_o => fifo_out
      );

  p_read_ltc232x: process(clk_i)
    variable bit_cnt: integer range 0 to c_BITS_PER_LINE := 0;
    variable bit_read_cnt: integer range 0 to c_BITS_PER_LINE := 0;
    variable wait_cnt: integer range 0 to c_WAIT_CONV_CYCLES := 0;
    variable sck_div_cnt: integer range 0 to c_SCK_CLK_DIV_CNT := 0;
    variable delayed_read_fifo: boolean := false;
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then               -- Reset the state machine
        state <= idle;
        bit_cnt := 0;
        bit_read_cnt := 0;
        wait_cnt := 0;
        sck_div_cnt := 0;
        delayed_read_fifo := false;
        cnv_o <= '0';
        sck_o_s <= '0';
        ready_o <= '1';
        valid_o <= '0';
      else
        -- valid signal is only asserted for 1 clock cycle
        valid_o <= '0';

        -- The FSM has 4 states:
        --
        -- idle:
        --   Wait for a high level in start_i;
        --
        -- conv_high:
        --   Hold the CNV signal high for 30ns minimum to start the
        --   conversion;
        --
        -- wait_conv:
        --   Wait for the conversion to finish, conversion time is set
        --   by g_cnv_wait;
        --
        -- read_data:
        --   Read the converted data through the serial lines.
        case state is
          when idle =>
            if start_i = '0' then
              state <= idle;
            else
              cnv_o <= '1';
              state <= conv_high;
              ready_o <= '0';
            end if;

          when conv_high =>
            if wait_cnt = c_CONV_HIGH_CYCLES then
              wait_cnt := 0;
              cnv_o <= '0';
              state <= wait_conv;
            else
              wait_cnt := wait_cnt + 1;
            end if;

          when wait_conv =>
            if wait_cnt = c_WAIT_CONV_CYCLES then
              wait_cnt := 0;
              state <= read_data;
            else
              wait_cnt := wait_cnt + 1;
            end if;

          when read_data =>
            -- ADC clock generation logic
            if sck_div_cnt = c_SCK_CLK_DIV_CNT then
              sck_div_cnt := 0;
                if bit_cnt /= c_BITS_PER_LINE then
                  if sck_o_s = '1' or c_DDR_MODE then
                    bit_cnt := bit_cnt + 1;
                  end if;
                  sck_o_s <= not sck_o_s;
                end if;
            else
              sck_div_cnt := sck_div_cnt + 1;
            end if;

            -- Check if there is data to be read from the FIFO
            if delayed_read_fifo then
              -- Each combination of the number of data lines and input
              -- channels requires a different capture logic.
              if g_data_lines = 8 and g_channels = 8 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & fifo_out(7);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & fifo_out(6);
                ch3_o_s <= ch3_o_s(g_bits-2 downto 0) & fifo_out(5);
                ch4_o_s <= ch4_o_s(g_bits-2 downto 0) & fifo_out(4);
                ch5_o_s <= ch5_o_s(g_bits-2 downto 0) & fifo_out(3);
                ch6_o_s <= ch6_o_s(g_bits-2 downto 0) & fifo_out(2);
                ch7_o_s <= ch7_o_s(g_bits-2 downto 0) & fifo_out(1);
                ch8_o_s <= ch8_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 4 and g_channels = 8 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & ch2_o_s(g_bits-1);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & fifo_out(3);
                ch3_o_s <= ch3_o_s(g_bits-2 downto 0) & ch4_o_s(g_bits-1);
                ch4_o_s <= ch4_o_s(g_bits-2 downto 0) & fifo_out(2);
                ch5_o_s <= ch5_o_s(g_bits-2 downto 0) & ch6_o_s(g_bits-1);
                ch6_o_s <= ch6_o_s(g_bits-2 downto 0) & fifo_out(1);
                ch7_o_s <= ch7_o_s(g_bits-2 downto 0) & ch8_o_s(g_bits-1);
                ch8_o_s <= ch8_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 2 and g_channels = 8 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & ch2_o_s(g_bits-1);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & ch3_o_s(g_bits-1);
                ch3_o_s <= ch3_o_s(g_bits-2 downto 0) & ch4_o_s(g_bits-1);
                ch4_o_s <= ch4_o_s(g_bits-2 downto 0) & fifo_out(1);
                ch5_o_s <= ch5_o_s(g_bits-2 downto 0) & ch6_o_s(g_bits-1);
                ch6_o_s <= ch6_o_s(g_bits-2 downto 0) & ch7_o_s(g_bits-1);
                ch7_o_s <= ch7_o_s(g_bits-2 downto 0) & ch8_o_s(g_bits-1);
                ch8_o_s <= ch8_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 1 and g_channels = 8 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & ch2_o_s(g_bits-1);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & ch3_o_s(g_bits-1);
                ch3_o_s <= ch3_o_s(g_bits-2 downto 0) & ch4_o_s(g_bits-1);
                ch4_o_s <= ch4_o_s(g_bits-2 downto 0) & ch5_o_s(g_bits-1);
                ch5_o_s <= ch5_o_s(g_bits-2 downto 0) & ch6_o_s(g_bits-1);
                ch6_o_s <= ch6_o_s(g_bits-2 downto 0) & ch7_o_s(g_bits-1);
                ch7_o_s <= ch7_o_s(g_bits-2 downto 0) & ch8_o_s(g_bits-1);
                ch8_o_s <= ch8_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 4 and g_channels = 4 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & fifo_out(3);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & fifo_out(2);
                ch3_o_s <= ch3_o_s(g_bits-2 downto 0) & fifo_out(1);
                ch4_o_s <= ch4_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 2 and g_channels = 4 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & ch2_o_s(g_bits-1);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & fifo_out(1);
                ch3_o_s <= ch3_o_s(g_bits-2 downto 0) & ch4_o_s(g_bits-1);
                ch4_o_s <= ch4_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 1 and g_channels = 4 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & ch2_o_s(g_bits-1);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & ch3_o_s(g_bits-1);
                ch3_o_s <= ch3_o_s(g_bits-2 downto 0) & ch4_o_s(g_bits-1);
                ch4_o_s <= ch4_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 2 and g_channels = 2 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & fifo_out(1);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 1 and g_channels = 2 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & ch2_o_s(g_bits-1);
                ch2_o_s <= ch2_o_s(g_bits-2 downto 0) & fifo_out(0);
              elsif g_data_lines = 1 and g_channels = 1 then
                ch1_o_s <= ch1_o_s(g_bits-2 downto 0) & fifo_out(0);
              end if;

              -- Count the amount of bits read in a single dataline
              -- until all data is transfered
              if bit_read_cnt = c_BITS_PER_LINE-1 then
                sck_div_cnt := 0;
                bit_read_cnt := 0;
                bit_cnt := 0;
                state <= idle;
                ready_o <= '1';        -- Signals that the module is ready
                                       -- to start a new conversion

                valid_o <= '1';
                fifo_rd <= '0';
                sck_o_s <= '0';
                delayed_read_fifo := false;
              else
                bit_read_cnt := bit_read_cnt + 1;
              end if;
            end if;

            -- Reading the FIFO output should be delayed by 1 clock
            -- cycle
            delayed_read_fifo := (fifo_rd_empty = '0' and fifo_rd = '1');

            -- Only enable reading if the FIFO isn't empty
            fifo_rd <= not fifo_rd_empty;
        end case;
      end if;
    end if;
  end process;
end ltc232x_acq_arch;
