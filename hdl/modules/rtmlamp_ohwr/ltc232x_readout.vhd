------------------------------------------------------------------------------
-- Title      : LTC232x readout module
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-22
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: Flexible readout module for LTC232x ADCs
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
-- 2021-03-03  1.1      lucas.russo     Split conv/readout funcionality in 2 modules
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.genram_pkg.all;
use work.gencores_pkg.all;

entity ltc232x_readout is
  generic(
    -- Core clock frequency [Hz], should
    -- be an integer multiple of
    -- g_SCLK_FREQ, at least 4x the frequency
    g_CLK_FAST_SPI_FREQ                      : natural := 400_000_000;
    -- ADC sck frequency [Hz]
    g_SCLK_FREQ                              : natural := 100_000_000;
    -- Sample bit size
    g_BITS                                   : natural := 16;
    -- Number of channels
    g_CHANNELS                               : natural := 8;
    -- Number of data lines
    g_DATA_LINES                             : natural := 8
    );
  port(
    -- Reset
    rst_fast_spi_n_i                         : in  std_logic;
    -- Core clock
    clk_fast_spi_i                           : in  std_logic;
    -- Start the readout
    start_i                                  : in  std_logic;
    -- ADC input clock
    sck_o                                    : out std_logic := '0';
    -- ADC return clock
    sck_ret_i                                : in  std_logic;
    -- '0': ongoing conversion
    -- '1': ready to start conversion
    ready_o                                  : out std_logic := '0';
    -- pulse when finished acquisition
    done_pp_o                                : out std_logic;
    -- ADC output SDO1/SDOA
    sdo1a_i                                  : in  std_logic;
    -- ADC output SDO2
    sdo2_i                                   : in  std_logic := '0';
    -- ADC output SDO3/SDOB
    sdo3b_i                                  : in  std_logic := '0';
    -- ADC output SDO4
    sdo4_i                                   : in  std_logic := '0';
    -- ADC output SDO5/SDOC
    sdo5c_i                                  : in  std_logic := '0';
    -- ADC output SDO6
    sdo6_i                                   : in  std_logic := '0';
    -- ADC output SDO7/SDOD
    sdo7d_i                                  : in  std_logic := '0';
    -- ADC output SDO8
    sdo8_i                                   : in  std_logic := '0';
    -- CH1 parallel output
    ch1_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH2 parallel output
    ch2_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH3 parallel output
    ch3_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH4 parallel output
    ch4_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH5 parallel output
    ch5_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH6 parallel output
    ch6_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH7 parallel output
    ch7_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- CH8 parallel output
    ch8_o                                    : out std_logic_vector(g_BITS-1 downto 0);
    -- data valid output
    valid_o                                  : out std_logic
    );
end ltc232x_readout;

architecture ltc232x_readout_arch of ltc232x_readout is
  constant c_DDR_MODE: boolean := false; -- DDR mode not supported yet
  constant c_BITS_PER_LINE: natural := ((g_BITS * g_CHANNELS) / g_DATA_LINES);
  constant c_SCK_CLK_RATIO: natural := (g_CLK_FAST_SPI_FREQ / g_SCLK_FREQ);
  constant c_SCK_CLK_DIV_CNT: natural := (c_SCK_CLK_RATIO / 2) - 1;

  -- place all SPI readout signals into IOB for optimal timing
  attribute IOB              : string;
  attribute IOB of sck_ret_i : signal is "TRUE";
  attribute IOB of sdo1a_i   : signal is "TRUE";
  attribute IOB of sdo2_i    : signal is "TRUE";
  attribute IOB of sdo3b_i   : signal is "TRUE";
  attribute IOB of sdo4_i    : signal is "TRUE";
  attribute IOB of sdo5c_i   : signal is "TRUE";
  attribute IOB of sdo6_i    : signal is "TRUE";
  attribute IOB of sdo7d_i   : signal is "TRUE";
  attribute IOB of sdo8_i    : signal is "TRUE";

  type t_state is (IDLE, READ_DATA);
  signal state: t_state := IDLE;

  signal sck_o_s: std_logic := '0';
  signal ch1_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');
  signal ch2_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');
  signal ch3_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');
  signal ch4_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');
  signal ch5_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');
  signal ch6_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');
  signal ch7_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');
  signal ch8_o_s: std_logic_vector(g_BITS-1 downto 0) := (others =>'0');

  signal sck_ret_pp       : std_logic;
  signal sck_ret_reg_pp   : std_logic;
  signal sdo_sync_in      : std_logic_vector(g_DATA_LINES-1 downto 0) := (others => '0');
  signal sdo_sync_out     : std_logic_vector(g_DATA_LINES-1 downto 0) := (others => '0');
  signal sdo_sync_reg_out : std_logic_vector(g_DATA_LINES-1 downto 0) := (others => '0');

  signal bit_cnt: integer range 0 to c_BITS_PER_LINE := 0;
  signal bit_read_cnt: integer range 0 to c_BITS_PER_LINE := 0;
  signal sck_div_cnt: integer range 0 to c_SCK_CLK_DIV_CNT := 0;

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

  ---------------------------------------------
  -- Sync stages for SCK_RET and SDO
  ---------------------------------------------

  cmp_sync_sck_ret : gc_sync_ffs
  port map (
    clk_i         => clk_fast_spi_i,
    rst_n_i       => rst_fast_spi_n_i,
    data_i        => sck_ret_i,
    ppulse_o      => sck_ret_pp
  );

  -- additional regs to ease timing
  cmp_sck_ret_reg : gc_sync_register
  generic map (
    g_width         => 1
  )
  port map (
    clk_i           => clk_fast_spi_i,
    rst_n_a_i       => rst_fast_spi_n_i,
    d_i(0)          => sck_ret_pp,
    q_o(0)          => sck_ret_reg_pp
  );

  ltc_8_datalines:
  if g_DATA_LINES = 8 generate
    sdo_sync_in <= (sdo1a_i, sdo2_i, sdo3b_i, sdo4_i,
                sdo5c_i, sdo6_i, sdo7d_i, sdo8_i);
  end generate;

  ltc_4_datalines:
  if g_DATA_LINES = 4 generate
    sdo_sync_in <= (sdo1a_i, sdo3b_i, sdo5c_i, sdo7d_i);
  end generate;

  ltc_2_datalines:
  if g_DATA_LINES = 2 generate
    sdo_sync_in <= (sdo1a_i, sdo5c_i);
  end generate;

  ltc_1_dataline:
  if g_DATA_LINES = 1 generate
    sdo_sync_in(0) <= sdo1a_i;
  end generate;

  gen_sdo_sync : for i in 0 to g_DATA_LINES-1 generate
    cmp_sync_sdo : gc_sync_ffs
    port map (
      clk_i         => clk_fast_spi_i,
      rst_n_i       => rst_fast_spi_n_i,
      data_i        => sdo_sync_in(i),
      synced_o      => sdo_sync_out(i)
    );
  end generate;

  -- additional regs to ease timing
  cmp_sdo_reg : gc_sync_register
  generic map (
    g_width         => g_DATA_LINES
  )
  port map (
    clk_i           => clk_fast_spi_i,
    rst_n_a_i       => rst_fast_spi_n_i,
    d_i             => sdo_sync_out,
    q_o             => sdo_sync_reg_out
  );

  p_read_ltc232x: process(clk_fast_spi_i)
  begin
    if rising_edge(clk_fast_spi_i) then
      if rst_fast_spi_n_i = '0' then               -- Reset the state machine
        state <= IDLE;
        bit_cnt <= 0;
        bit_read_cnt <= 0;
        sck_div_cnt <= 0;
        sck_o_s <= '0';
        -- if we are in reset state we can't be ready
        ready_o <= '0';
        done_pp_o <= '0';
        valid_o <= '0';
      else
        done_pp_o <= '0';
        -- valid signal is only asserted for 1 clock cycle
        valid_o <= '0';

        -- The FSM has 2 states:
        --
        -- IDLE:
        --   Wait for a high level in start_i;
        --
        -- READ_DATA:
        --   Read the converted data through the serial lines.
        case state is
          when IDLE =>
            ready_o <= '1';

            if start_i = '0' then
              state <= IDLE;
            else
              state <= READ_DATA;
              ready_o <= '0';
            end if;

          when READ_DATA =>
            -- ADC clock generation logic
            if sck_div_cnt = c_SCK_CLK_DIV_CNT then
              sck_div_cnt <= 0;
                if bit_cnt /= c_BITS_PER_LINE then
                  if sck_o_s = '1' or c_DDR_MODE then
                    bit_cnt <= bit_cnt + 1;
                  end if;
                  sck_o_s <= not sck_o_s;
                end if;
            else
              sck_div_cnt <= sck_div_cnt + 1;
            end if;

            if sck_ret_reg_pp = '1' then
              -- Each combination of the number of data lines and input
              -- channels requires a different capture logic.
              if g_DATA_LINES = 8 and g_CHANNELS = 8 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(7);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(6);
                ch3_o_s <= ch3_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(5);
                ch4_o_s <= ch4_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(4);
                ch5_o_s <= ch5_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(3);
                ch6_o_s <= ch6_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(2);
                ch7_o_s <= ch7_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(1);
                ch8_o_s <= ch8_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 4 and g_CHANNELS = 8 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & ch2_o_s(g_BITS-1);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(3);
                ch3_o_s <= ch3_o_s(g_BITS-2 downto 0) & ch4_o_s(g_BITS-1);
                ch4_o_s <= ch4_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(2);
                ch5_o_s <= ch5_o_s(g_BITS-2 downto 0) & ch6_o_s(g_BITS-1);
                ch6_o_s <= ch6_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(1);
                ch7_o_s <= ch7_o_s(g_BITS-2 downto 0) & ch8_o_s(g_BITS-1);
                ch8_o_s <= ch8_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 2 and g_CHANNELS = 8 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & ch2_o_s(g_BITS-1);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & ch3_o_s(g_BITS-1);
                ch3_o_s <= ch3_o_s(g_BITS-2 downto 0) & ch4_o_s(g_BITS-1);
                ch4_o_s <= ch4_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(1);
                ch5_o_s <= ch5_o_s(g_BITS-2 downto 0) & ch6_o_s(g_BITS-1);
                ch6_o_s <= ch6_o_s(g_BITS-2 downto 0) & ch7_o_s(g_BITS-1);
                ch7_o_s <= ch7_o_s(g_BITS-2 downto 0) & ch8_o_s(g_BITS-1);
                ch8_o_s <= ch8_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 1 and g_CHANNELS = 8 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & ch2_o_s(g_BITS-1);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & ch3_o_s(g_BITS-1);
                ch3_o_s <= ch3_o_s(g_BITS-2 downto 0) & ch4_o_s(g_BITS-1);
                ch4_o_s <= ch4_o_s(g_BITS-2 downto 0) & ch5_o_s(g_BITS-1);
                ch5_o_s <= ch5_o_s(g_BITS-2 downto 0) & ch6_o_s(g_BITS-1);
                ch6_o_s <= ch6_o_s(g_BITS-2 downto 0) & ch7_o_s(g_BITS-1);
                ch7_o_s <= ch7_o_s(g_BITS-2 downto 0) & ch8_o_s(g_BITS-1);
                ch8_o_s <= ch8_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 4 and g_CHANNELS = 4 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(3);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(2);
                ch3_o_s <= ch3_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(1);
                ch4_o_s <= ch4_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 2 and g_CHANNELS = 4 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & ch2_o_s(g_BITS-1);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(1);
                ch3_o_s <= ch3_o_s(g_BITS-2 downto 0) & ch4_o_s(g_BITS-1);
                ch4_o_s <= ch4_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 1 and g_CHANNELS = 4 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & ch2_o_s(g_BITS-1);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & ch3_o_s(g_BITS-1);
                ch3_o_s <= ch3_o_s(g_BITS-2 downto 0) & ch4_o_s(g_BITS-1);
                ch4_o_s <= ch4_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 2 and g_CHANNELS = 2 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(1);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 1 and g_CHANNELS = 2 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & ch2_o_s(g_BITS-1);
                ch2_o_s <= ch2_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              elsif g_DATA_LINES = 1 and g_CHANNELS = 1 then
                ch1_o_s <= ch1_o_s(g_BITS-2 downto 0) & sdo_sync_reg_out(0);
              end if;

              -- Count the amount of bits read in a single dataline
              -- until all data is transfered
              if bit_read_cnt = c_BITS_PER_LINE-1 then
                sck_div_cnt <= 0;
                bit_read_cnt <= 0;
                bit_cnt <= 0;
                state <= IDLE;
                ready_o <= '1';        -- Signals that the module is ready
                                       -- to start a new readout
                done_pp_o <= '1';

                valid_o <= '1';
                sck_o_s <= '0';
              else
                bit_read_cnt <= bit_read_cnt + 1;
              end if;
            end if;

        end case;
      end if;
    end if;
  end process;

end ltc232x_readout_arch;
