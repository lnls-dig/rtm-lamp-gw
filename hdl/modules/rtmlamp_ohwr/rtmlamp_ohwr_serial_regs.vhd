------------------------------------------------------------------------------
-- Title      : RTM LAMP Serial register interface
------------------------------------------------------------------------------
-- Author     : Lucas Maziero Russo
-- Company    : CNPEM LNLS-DIG
-- Created    : 2021-02-24
-- Platform   : FPGA-generic
-------------------------------------------------------------------------------
-- Description: RTM LAMP Serial register interface.
-------------------------------------------------------------------------------
-- Copyright (c) 2021 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2021-02-24  1.0      lucas.russo        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rtmlamp_ohwr_serial_regs is
generic (
  -- Number of AMP channels
  g_CHANNELS                                 : natural := 12;
  -- System clock frequency [Hz]
  g_CLOCK_FREQ                               : natural := 100000000;
  -- Serial registers clock frequency [Hz]
  g_SCLK_FREQ                                : natural := 100000
);
port (
  ---------------------------------------------------------------------------
  -- clock and reset interface
  ---------------------------------------------------------------------------
  clk_i                                      : in std_logic;
  rst_n_i                                    : in std_logic;

  ---------------------------------------------------------------------------
  -- RTM serial interface
  ---------------------------------------------------------------------------
  -- Set to 1 to read and write all AMP parameters listed at the AMP
  -- parallel interface
  amp_sta_ctl_rw_i                           : in std_logic := '1';

  amp_status_reg_clk_o                       : out std_logic;
  amp_status_reg_out_i                       : in std_logic;
  amp_status_reg_pl_o                        : out std_logic;

  amp_ctl_reg_oe_n_o                         : out std_logic;
  amp_ctl_reg_din_o                          : out std_logic;
  amp_ctl_reg_str_o                          : out std_logic;

  ---------------------------------------------------------------------------
  -- AMP parallel interface
  ---------------------------------------------------------------------------
  amp_iflag_l_o                              : out std_logic_vector(g_CHANNELS-1 downto 0);
  amp_tflag_l_o                              : out std_logic_vector(g_CHANNELS-1 downto 0);
  amp_iflag_r_o                              : out std_logic_vector(g_CHANNELS-1 downto 0);
  amp_tflag_r_o                              : out std_logic_vector(g_CHANNELS-1 downto 0);
  amp_en_ch_i                                : in std_logic_vector(g_CHANNELS-1 downto 0)
);
end rtmlamp_ohwr_serial_regs;

architecture rtl of rtmlamp_ohwr_serial_regs is

  -- functions
  function f_log2_ceil(N : natural) return positive is
  begin
    if N <= 2 then
      return 1;
    elsif N mod 2 = 0 then
      return 1 + f_log2_ceil(N/2);
    else
      return 1 + f_log2_ceil((N+1)/2);
    end if;
  end;

  -- constants
  constant c_NUM_TICKS_PER_CLOCK             : integer := 4;
  constant c_SERIAL_DIV                      : natural := g_CLOCK_FREQ/(c_NUM_TICKS_PER_CLOCK*g_SCLK_FREQ)-1;
  constant c_NUM_FLAGS_PER_CHANNEL           : natural := 4;
  constant c_NUM_SERIAL_OUT_BITS_TO_SHIFT    : natural := g_CHANNELS*c_NUM_FLAGS_PER_CHANNEL;
  -- Maximum number of bits that RTM LAMP supports to load in
  -- a serial-in/parallel-out shift register in chain. This corresponds
  -- to 2 serial-in/parallel-out shift registers in tandem.
  constant c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT : natural := 16;
  constant c_SERIAL_OUT_TO_SERIAL_IN_RATIO   : natural := c_NUM_SERIAL_OUT_BITS_TO_SHIFT /
                                                          c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT;

  signal serial_tick                         : std_logic;
  signal serial_divider                      : unsigned(f_log2_ceil(c_SERIAL_DIV)-1 downto 0);

  signal seq_count                           : unsigned(8 downto 0);
  signal amp_en_ch_padded                    : std_logic_vector(c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT-1 downto 0) := (others => '0');
  signal amp_reg_to_device                   : std_logic_vector(c_NUM_SERIAL_OUT_BITS_TO_SHIFT-1 downto 0) := (others => '0');
  signal amp_reg_from_device                 : std_logic_vector(c_NUM_SERIAL_OUT_BITS_TO_SHIFT-1 downto 0) := (others => '0');

  -- Serial types
  type t_serial_transaction is (PARALLEL_LOAD, SERIAL_SHIFT, HOLD);

  type t_state is (IDLE, LOAD, READ_WRITE);

  signal state                               : t_state;

  procedure f_serial_iterate(tick : std_logic;
                          signal counter : inout unsigned;
                          signal val_to_device : in std_logic_vector;
                          signal val_from_device : out std_logic_vector;
                          trans_type : t_serial_transaction;
                          signal reg_clk : out std_logic;
                          signal reg_din : out std_logic;
                          signal reg_pl : out std_logic;
                          signal reg_str : out std_logic;
                          signal reg_oe_n : out std_logic;
                          signal reg_dout : in std_logic;
                          signal state_var : out t_state;
                          next_state : t_state) is
    variable last : boolean;
    variable val_num_bits : integer := val_to_device'length;
  begin

    last := false;

    if(tick = '0') then
      return;
    end if;

    case trans_type is
      when PARALLEL_LOAD =>

        case counter(1 downto 0) is
          -- states 1..0: PARALLEL_LOAD
          when "00" =>
            reg_pl <= '0';
          when "01" =>
            reg_pl <= '1';
          when "10" =>
            reg_pl <= '0';
          when "11" =>
            last := true;
          when others =>
            null;
        end case;

      when SERIAL_SHIFT =>

        case counter(1 downto 0) is
          -- states 1..0: SERIAL_SHIFT
          when "00" =>
            reg_clk <= '0';
            -- reg_din is shifted on positive edge. So we load the value here,
            -- so that on the next state (reg_clk 0 -> 1) it gets shifted
            -- Send MSB first. Careful to not wrap "counter".
            reg_din <= val_to_device(val_to_device'left-
                            to_integer(counter(counter'left downto 2)));
            reg_pl <= '0';
            reg_str <= '0';
          when "01" =>
            reg_clk <= '1';
            -- reg_dout is shifted on negative edge. So we load the current value here,
            -- so that on the next state (reg_clk 1 -> 0) it gets shifted
            -- First output bit is ready to read after PARALLEL_LOAD
            val_from_device(val_from_device'left -
                to_integer(counter(counter'left downto 2))) <= reg_dout;
          when "10" =>
            reg_clk <= '0';

            -- last bit needs to assert strobe so serial data is clocked
            -- onto parallel output. 74HC595 states that the set-up time
            -- SHCP 0->1 (reg_clk) to STCP 0->1 (reg_str) is, at the
            -- worst-case, 24ns, so we only need the "tick" to be larger
            -- than this, which is easily achievable by only separating
            -- reg_clk and reg_str assertion in different states.
            if counter(counter'left downto 2) = to_unsigned(val_num_bits, counter'length)-1 then
              reg_str <= '1';
            end if;
          when "11" =>
            reg_str <= '0';

            if counter(counter'left downto 2) = to_unsigned(val_num_bits, counter'length)-1 then
              -- Enable output onle after the parallel registers are loaded by
              -- reg_str 0 -> 1
              reg_oe_n <= '0';
              last := true;
            end if;
          when others =>
            null;
        end case;

      when HOLD =>

        case counter(1 downto 0) is
          -- states 1..0: HOLD
          when "00" =>
            reg_clk <= '0';
          when "01" =>
            null;
          when "10" =>
            null;
          when "11" =>
            last := true;
          when others =>
            null;
        end case;

    end case;

    if(last) then
      state_var <= next_state;
      counter   <= "000000000";
    else
      counter <= counter + 1;
    end if;

  end f_serial_iterate;

begin

  assert (c_NUM_SERIAL_OUT_BITS_TO_SHIFT mod c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT = 0)
    report "[rtmlamp_ohwr_serial_regs] c_NUM_SERIAL_OUT_BITS_TO_SHIFT(" & Integer'image(c_NUM_SERIAL_OUT_BITS_TO_SHIFT) &
    ") must divide c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT(" & Integer'image(c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT) &
    ")"
    severity failure;

  assert (g_CHANNELS <= 16)
    report "[rtmlamp_ohwr_serial_regs] g_CHANNELS(" & Integer'image(g_CHANNELS) &
    ") unsuppoted. Maximum number of g_CHANNELS must be <= 16"
    severity failure;

  -- Pad word so that this is a multiple of amp_reg_to_device length
  amp_en_ch_padded(amp_en_ch_padded'left downto g_CHANNELS) <= (others => '0');
  amp_en_ch_padded(g_CHANNELS-1 downto 0) <= amp_en_ch_i;

  -- Register to be shifted to RTM reg_din pin. See RTM LAMP schematics for
  -- order.
  --
  -- We need to repeat the shift operation X times, so that at the
  -- end of the shift-out (RTM to FPGA) operation we end up with
  -- the correct shift-in (FPGA to RTM) data at the serial-in/parallel-out
  -- shift registers.
  --
  -- Data in to RTM shift registers follows this pattern, for 12 channels:
  --
  -- amp_reg_from_device(47) <= '0'; -- unused
  -- amp_reg_from_device(46) <= '0'; -- unused
  -- amp_reg_from_device(45) <= '0'; -- unused
  -- amp_reg_from_device(44) <= '0'; -- unused
  -- amp_reg_from_device(43) <= amp_en_ch_i(11);
  -- ...
  -- amp_reg_from_device(32) <= amp_en_ch_i(0);
  -- ...
  -- amp_reg_from_device(15) <= '0'; -- unused
  -- amp_reg_from_device(14) <= '0'; -- unused
  -- amp_reg_from_device(13) <= '0'; -- unused
  -- amp_reg_from_device(12) <= '0'; -- unused
  -- amp_reg_from_device(11) <= amp_en_ch_i(11);
  -- ...
  -- amp_reg_from_device(0) <= amp_en_ch_i(0);
  gen_amp_ch_en_full_word : for i in 0 to c_SERIAL_OUT_TO_SERIAL_IN_RATIO-1 generate
    amp_reg_to_device((i+1)*c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT-1 downto
                       i*c_NUM_MAX_SERIAL_IN_BITS_TO_SHIFT) <= amp_en_ch_padded;
  end generate;

  -- data out from RTM shift registers follows this pattern, for 12 channels:
  --
  -- amp_tflag_r_o(11)               <= amp_reg_from_device(47);
  -- amp_iflag_r_o(11)               <= amp_reg_from_device(46);
  -- amp_tflag_l_o(11)               <= amp_reg_from_device(45);
  -- amp_iflag_l_o(11)               <= amp_reg_from_device(44);
  -- ...
  -- amp_tflag_r_o(0)                <= amp_reg_from_device(3);
  -- amp_iflag_r_o(0)                <= amp_reg_from_device(2);
  -- amp_tflag_l_o(0)                <= amp_reg_from_device(1);
  -- amp_iflag_l_o(0)                <= amp_reg_from_device(0);
  gen_amp_flags : for i in 0 to g_CHANNELS-1 generate
    amp_tflag_r_o(i)               <= amp_reg_from_device(i*c_NUM_FLAGS_PER_CHANNEL+3);
    amp_iflag_r_o(i)               <= amp_reg_from_device(i*c_NUM_FLAGS_PER_CHANNEL+2);
    amp_tflag_l_o(i)               <= amp_reg_from_device(i*c_NUM_FLAGS_PER_CHANNEL+1);
    amp_iflag_l_o(i)               <= amp_reg_from_device(i*c_NUM_FLAGS_PER_CHANNEL);
  end generate;

  p_serial_divider : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        serial_divider <= (others => '0');
        serial_tick    <= '0';
      else
        if(serial_divider = to_unsigned(c_SERIAL_DIV, serial_divider'length)) then
          serial_tick <= '1';
          serial_divider <= (others => '0');
        else
          serial_tick <= '0';
          serial_divider <= serial_divider + 1;
        end if;
      end if;
    end if;
  end process;

  p_serial_fsm : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        seq_count   <= (others => '0');
        state       <= IDLE;
        amp_reg_from_device <= (others => '0');
        amp_ctl_reg_str_o <= '0';
        amp_ctl_reg_oe_n_o <= '1';
        amp_status_reg_clk_o <= '0';
        amp_ctl_reg_din_o <= '0';
        amp_status_reg_pl_o <= '0';
      else
         case state is
            when IDLE =>
              f_serial_iterate(serial_tick, seq_count,
                    amp_reg_to_device, amp_reg_from_device,
                          HOLD,
                          amp_status_reg_clk_o,
                          amp_ctl_reg_din_o,
                          amp_status_reg_pl_o,
                          amp_ctl_reg_str_o,
                          amp_ctl_reg_oe_n_o,
                          amp_status_reg_out_i,
                          state,
                          IDLE);

              if amp_sta_ctl_rw_i = '1' then
                state <= LOAD;
              end if;

            when LOAD =>
              f_serial_iterate(serial_tick, seq_count,
                    amp_reg_to_device, amp_reg_from_device,
                          PARALLEL_LOAD,
                          amp_status_reg_clk_o,
                          amp_ctl_reg_din_o,
                          amp_status_reg_pl_o,
                          amp_ctl_reg_str_o,
                          amp_ctl_reg_oe_n_o,
                          amp_status_reg_out_i,
                          state,
                          READ_WRITE);

            when READ_WRITE =>
              f_serial_iterate(serial_tick, seq_count,
                    amp_reg_to_device, amp_reg_from_device,
                          SERIAL_SHIFT,
                          amp_status_reg_clk_o,
                          amp_ctl_reg_din_o,
                          amp_status_reg_pl_o,
                          amp_ctl_reg_str_o,
                          amp_ctl_reg_oe_n_o,
                          amp_status_reg_out_i,
                          state,
                          IDLE);

            when others =>
                state <= IDLE;

        end case;
      end if;
    end if;
  end process;

end rtl;
