-- Do not edit.  Generated on Fri Feb 26 19:20:12 2021 by lerwys
-- With Cheby 1.4.dev0 and these options:
--  -i rtmlamp_ohwr_regs.cheby --hdl vhdl --gen-hdl wb_rtmlamp_ohwr_regs.vhd --doc html --gen-doc doc/wb_rtmlamp_ohwr_regs_wb.html --gen-c wb_rtmlamp_ohwr_regs.h --consts-style verilog --gen-consts ../../../sim/regs/wb_rtmlamp_ohwr_regs.vh


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wishbone_pkg.all;

package wb_rtmlamp_ohwr_regs_pkg is
  type t_rtmlamp_ohwr_regs_master_out is record
    ch_0_ctl_amp_en  : std_logic;
    ch_0_ctl_reserved : std_logic_vector(30 downto 0);
    ch_1_ctl_amp_en  : std_logic;
    ch_1_ctl_reserved : std_logic_vector(30 downto 0);
    ch_2_ctl_amp_en  : std_logic;
    ch_2_ctl_reserved : std_logic_vector(30 downto 0);
    ch_3_ctl_amp_en  : std_logic;
    ch_3_ctl_reserved : std_logic_vector(30 downto 0);
    ch_4_ctl_amp_en  : std_logic;
    ch_4_ctl_reserved : std_logic_vector(30 downto 0);
    ch_5_ctl_amp_en  : std_logic;
    ch_5_ctl_reserved : std_logic_vector(30 downto 0);
    ch_6_ctl_amp_en  : std_logic;
    ch_6_ctl_reserved : std_logic_vector(30 downto 0);
    ch_7_ctl_amp_en  : std_logic;
    ch_7_ctl_reserved : std_logic_vector(30 downto 0);
    ch_8_ctl_amp_en  : std_logic;
    ch_8_ctl_reserved : std_logic_vector(30 downto 0);
    ch_9_ctl_amp_en  : std_logic;
    ch_9_ctl_reserved : std_logic_vector(30 downto 0);
    ch_10_ctl_amp_en : std_logic;
    ch_10_ctl_reserved : std_logic_vector(30 downto 0);
    ch_11_ctl_amp_en : std_logic;
    ch_11_ctl_reserved : std_logic_vector(30 downto 0);
  end record t_rtmlamp_ohwr_regs_master_out;
  subtype t_rtmlamp_ohwr_regs_slave_in is t_rtmlamp_ohwr_regs_master_out;

  type t_rtmlamp_ohwr_regs_slave_out is record
    ch_0_sta_amp_iflag_l : std_logic;
    ch_0_sta_amp_tflag_l : std_logic;
    ch_0_sta_amp_iflag_r : std_logic;
    ch_0_sta_amp_tflag_r : std_logic;
    ch_0_sta_reserved : std_logic_vector(27 downto 0);
    ch_1_sta_amp_iflag_l : std_logic;
    ch_1_sta_amp_tflag_l : std_logic;
    ch_1_sta_amp_iflag_r : std_logic;
    ch_1_sta_amp_tflag_r : std_logic;
    ch_1_sta_reserved : std_logic_vector(27 downto 0);
    ch_2_sta_amp_iflag_l : std_logic;
    ch_2_sta_amp_tflag_l : std_logic;
    ch_2_sta_amp_iflag_r : std_logic;
    ch_2_sta_amp_tflag_r : std_logic;
    ch_2_sta_reserved : std_logic_vector(27 downto 0);
    ch_3_sta_amp_iflag_l : std_logic;
    ch_3_sta_amp_tflag_l : std_logic;
    ch_3_sta_amp_iflag_r : std_logic;
    ch_3_sta_amp_tflag_r : std_logic;
    ch_3_sta_reserved : std_logic_vector(27 downto 0);
    ch_4_sta_amp_iflag_l : std_logic;
    ch_4_sta_amp_tflag_l : std_logic;
    ch_4_sta_amp_iflag_r : std_logic;
    ch_4_sta_amp_tflag_r : std_logic;
    ch_4_sta_reserved : std_logic_vector(27 downto 0);
    ch_5_sta_amp_iflag_l : std_logic;
    ch_5_sta_amp_tflag_l : std_logic;
    ch_5_sta_amp_iflag_r : std_logic;
    ch_5_sta_amp_tflag_r : std_logic;
    ch_5_sta_reserved : std_logic_vector(27 downto 0);
    ch_6_sta_amp_iflag_l : std_logic;
    ch_6_sta_amp_tflag_l : std_logic;
    ch_6_sta_amp_iflag_r : std_logic;
    ch_6_sta_amp_tflag_r : std_logic;
    ch_6_sta_reserved : std_logic_vector(27 downto 0);
    ch_7_sta_amp_iflag_l : std_logic;
    ch_7_sta_amp_tflag_l : std_logic;
    ch_7_sta_amp_iflag_r : std_logic;
    ch_7_sta_amp_tflag_r : std_logic;
    ch_7_sta_reserved : std_logic_vector(27 downto 0);
    ch_8_sta_amp_iflag_l : std_logic;
    ch_8_sta_amp_tflag_l : std_logic;
    ch_8_sta_amp_iflag_r : std_logic;
    ch_8_sta_amp_tflag_r : std_logic;
    ch_8_sta_reserved : std_logic_vector(27 downto 0);
    ch_9_sta_amp_iflag_l : std_logic;
    ch_9_sta_amp_tflag_l : std_logic;
    ch_9_sta_amp_iflag_r : std_logic;
    ch_9_sta_amp_tflag_r : std_logic;
    ch_9_sta_reserved : std_logic_vector(27 downto 0);
    ch_10_sta_amp_iflag_l : std_logic;
    ch_10_sta_amp_tflag_l : std_logic;
    ch_10_sta_amp_iflag_r : std_logic;
    ch_10_sta_amp_tflag_r : std_logic;
    ch_10_sta_reserved : std_logic_vector(27 downto 0);
    ch_11_sta_amp_iflag_l : std_logic;
    ch_11_sta_amp_tflag_l : std_logic;
    ch_11_sta_amp_iflag_r : std_logic;
    ch_11_sta_amp_tflag_r : std_logic;
    ch_11_sta_reserved : std_logic_vector(27 downto 0);
  end record t_rtmlamp_ohwr_regs_slave_out;
  subtype t_rtmlamp_ohwr_regs_master_in is t_rtmlamp_ohwr_regs_slave_out;
end wb_rtmlamp_ohwr_regs_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wishbone_pkg.all;
use work.wb_rtmlamp_ohwr_regs_pkg.all;

entity wb_rtmlamp_ohwr_regs is
  port (
    rst_n_i              : in    std_logic;
    clk_i                : in    std_logic;
    wb_i                 : in    t_wishbone_slave_in;
    wb_o                 : out   t_wishbone_slave_out;
    -- Wires and registers
    rtmlamp_ohwr_regs_i  : in    t_rtmlamp_ohwr_regs_master_in;
    rtmlamp_ohwr_regs_o  : out   t_rtmlamp_ohwr_regs_master_out
  );
end wb_rtmlamp_ohwr_regs;

architecture syn of wb_rtmlamp_ohwr_regs is
  signal adr_int                        : std_logic_vector(6 downto 2);
  signal rd_req_int                     : std_logic;
  signal wr_req_int                     : std_logic;
  signal rd_ack_int                     : std_logic;
  signal wr_ack_int                     : std_logic;
  signal wb_en                          : std_logic;
  signal ack_int                        : std_logic;
  signal wb_rip                         : std_logic;
  signal wb_wip                         : std_logic;
  signal ch_0_ctl_amp_en_reg            : std_logic;
  signal ch_0_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_0_ctl_wreq                  : std_logic;
  signal ch_0_ctl_wack                  : std_logic;
  signal ch_1_ctl_amp_en_reg            : std_logic;
  signal ch_1_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_1_ctl_wreq                  : std_logic;
  signal ch_1_ctl_wack                  : std_logic;
  signal ch_2_ctl_amp_en_reg            : std_logic;
  signal ch_2_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_2_ctl_wreq                  : std_logic;
  signal ch_2_ctl_wack                  : std_logic;
  signal ch_3_ctl_amp_en_reg            : std_logic;
  signal ch_3_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_3_ctl_wreq                  : std_logic;
  signal ch_3_ctl_wack                  : std_logic;
  signal ch_4_ctl_amp_en_reg            : std_logic;
  signal ch_4_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_4_ctl_wreq                  : std_logic;
  signal ch_4_ctl_wack                  : std_logic;
  signal ch_5_ctl_amp_en_reg            : std_logic;
  signal ch_5_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_5_ctl_wreq                  : std_logic;
  signal ch_5_ctl_wack                  : std_logic;
  signal ch_6_ctl_amp_en_reg            : std_logic;
  signal ch_6_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_6_ctl_wreq                  : std_logic;
  signal ch_6_ctl_wack                  : std_logic;
  signal ch_7_ctl_amp_en_reg            : std_logic;
  signal ch_7_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_7_ctl_wreq                  : std_logic;
  signal ch_7_ctl_wack                  : std_logic;
  signal ch_8_ctl_amp_en_reg            : std_logic;
  signal ch_8_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_8_ctl_wreq                  : std_logic;
  signal ch_8_ctl_wack                  : std_logic;
  signal ch_9_ctl_amp_en_reg            : std_logic;
  signal ch_9_ctl_reserved_reg          : std_logic_vector(30 downto 0);
  signal ch_9_ctl_wreq                  : std_logic;
  signal ch_9_ctl_wack                  : std_logic;
  signal ch_10_ctl_amp_en_reg           : std_logic;
  signal ch_10_ctl_reserved_reg         : std_logic_vector(30 downto 0);
  signal ch_10_ctl_wreq                 : std_logic;
  signal ch_10_ctl_wack                 : std_logic;
  signal ch_11_ctl_amp_en_reg           : std_logic;
  signal ch_11_ctl_reserved_reg         : std_logic_vector(30 downto 0);
  signal ch_11_ctl_wreq                 : std_logic;
  signal ch_11_ctl_wack                 : std_logic;
  signal rd_ack_d0                      : std_logic;
  signal rd_dat_d0                      : std_logic_vector(31 downto 0);
  signal wr_req_d0                      : std_logic;
  signal wr_adr_d0                      : std_logic_vector(6 downto 2);
  signal wr_dat_d0                      : std_logic_vector(31 downto 0);
  signal wr_sel_d0                      : std_logic_vector(3 downto 0);
begin

  -- WB decode signals
  adr_int <= wb_i.adr(6 downto 2);
  wb_en <= wb_i.cyc and wb_i.stb;

  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        wb_rip <= '0';
      else
        wb_rip <= (wb_rip or (wb_en and not wb_i.we)) and not rd_ack_int;
      end if;
    end if;
  end process;
  rd_req_int <= (wb_en and not wb_i.we) and not wb_rip;

  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        wb_wip <= '0';
      else
        wb_wip <= (wb_wip or (wb_en and wb_i.we)) and not wr_ack_int;
      end if;
    end if;
  end process;
  wr_req_int <= (wb_en and wb_i.we) and not wb_wip;

  ack_int <= rd_ack_int or wr_ack_int;
  wb_o.ack <= ack_int;
  wb_o.stall <= not ack_int and wb_en;
  wb_o.rty <= '0';
  wb_o.err <= '0';

  -- pipelining for wr-in+rd-out
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        rd_ack_int <= '0';
        wr_req_d0 <= '0';
      else
        rd_ack_int <= rd_ack_d0;
        wb_o.dat <= rd_dat_d0;
        wr_req_d0 <= wr_req_int;
        wr_adr_d0 <= adr_int;
        wr_dat_d0 <= wb_i.dat;
        wr_sel_d0 <= wb_i.sel;
      end if;
    end if;
  end process;

  -- Register ch_0_sta

  -- Register ch_0_ctl
  rtmlamp_ohwr_regs_o.ch_0_ctl_amp_en <= ch_0_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_0_ctl_reserved <= ch_0_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_0_ctl_amp_en_reg <= '0';
        ch_0_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_0_ctl_wack <= '0';
      else
        if ch_0_ctl_wreq = '1' then
          ch_0_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_0_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_0_ctl_wack <= ch_0_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_1_sta

  -- Register ch_1_ctl
  rtmlamp_ohwr_regs_o.ch_1_ctl_amp_en <= ch_1_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_1_ctl_reserved <= ch_1_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_1_ctl_amp_en_reg <= '0';
        ch_1_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_1_ctl_wack <= '0';
      else
        if ch_1_ctl_wreq = '1' then
          ch_1_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_1_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_1_ctl_wack <= ch_1_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_2_sta

  -- Register ch_2_ctl
  rtmlamp_ohwr_regs_o.ch_2_ctl_amp_en <= ch_2_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_2_ctl_reserved <= ch_2_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_2_ctl_amp_en_reg <= '0';
        ch_2_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_2_ctl_wack <= '0';
      else
        if ch_2_ctl_wreq = '1' then
          ch_2_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_2_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_2_ctl_wack <= ch_2_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_3_sta

  -- Register ch_3_ctl
  rtmlamp_ohwr_regs_o.ch_3_ctl_amp_en <= ch_3_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_3_ctl_reserved <= ch_3_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_3_ctl_amp_en_reg <= '0';
        ch_3_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_3_ctl_wack <= '0';
      else
        if ch_3_ctl_wreq = '1' then
          ch_3_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_3_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_3_ctl_wack <= ch_3_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_4_sta

  -- Register ch_4_ctl
  rtmlamp_ohwr_regs_o.ch_4_ctl_amp_en <= ch_4_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_4_ctl_reserved <= ch_4_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_4_ctl_amp_en_reg <= '0';
        ch_4_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_4_ctl_wack <= '0';
      else
        if ch_4_ctl_wreq = '1' then
          ch_4_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_4_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_4_ctl_wack <= ch_4_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_5_sta

  -- Register ch_5_ctl
  rtmlamp_ohwr_regs_o.ch_5_ctl_amp_en <= ch_5_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_5_ctl_reserved <= ch_5_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_5_ctl_amp_en_reg <= '0';
        ch_5_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_5_ctl_wack <= '0';
      else
        if ch_5_ctl_wreq = '1' then
          ch_5_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_5_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_5_ctl_wack <= ch_5_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_6_sta

  -- Register ch_6_ctl
  rtmlamp_ohwr_regs_o.ch_6_ctl_amp_en <= ch_6_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_6_ctl_reserved <= ch_6_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_6_ctl_amp_en_reg <= '0';
        ch_6_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_6_ctl_wack <= '0';
      else
        if ch_6_ctl_wreq = '1' then
          ch_6_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_6_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_6_ctl_wack <= ch_6_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_7_sta

  -- Register ch_7_ctl
  rtmlamp_ohwr_regs_o.ch_7_ctl_amp_en <= ch_7_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_7_ctl_reserved <= ch_7_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_7_ctl_amp_en_reg <= '0';
        ch_7_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_7_ctl_wack <= '0';
      else
        if ch_7_ctl_wreq = '1' then
          ch_7_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_7_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_7_ctl_wack <= ch_7_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_8_sta

  -- Register ch_8_ctl
  rtmlamp_ohwr_regs_o.ch_8_ctl_amp_en <= ch_8_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_8_ctl_reserved <= ch_8_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_8_ctl_amp_en_reg <= '0';
        ch_8_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_8_ctl_wack <= '0';
      else
        if ch_8_ctl_wreq = '1' then
          ch_8_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_8_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_8_ctl_wack <= ch_8_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_9_sta

  -- Register ch_9_ctl
  rtmlamp_ohwr_regs_o.ch_9_ctl_amp_en <= ch_9_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_9_ctl_reserved <= ch_9_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_9_ctl_amp_en_reg <= '0';
        ch_9_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_9_ctl_wack <= '0';
      else
        if ch_9_ctl_wreq = '1' then
          ch_9_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_9_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_9_ctl_wack <= ch_9_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_10_sta

  -- Register ch_10_ctl
  rtmlamp_ohwr_regs_o.ch_10_ctl_amp_en <= ch_10_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_10_ctl_reserved <= ch_10_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_10_ctl_amp_en_reg <= '0';
        ch_10_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_10_ctl_wack <= '0';
      else
        if ch_10_ctl_wreq = '1' then
          ch_10_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_10_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_10_ctl_wack <= ch_10_ctl_wreq;
      end if;
    end if;
  end process;

  -- Register ch_11_sta

  -- Register ch_11_ctl
  rtmlamp_ohwr_regs_o.ch_11_ctl_amp_en <= ch_11_ctl_amp_en_reg;
  rtmlamp_ohwr_regs_o.ch_11_ctl_reserved <= ch_11_ctl_reserved_reg;
  process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_n_i = '0' then
        ch_11_ctl_amp_en_reg <= '0';
        ch_11_ctl_reserved_reg <= "0000000000000000000000000000000";
        ch_11_ctl_wack <= '0';
      else
        if ch_11_ctl_wreq = '1' then
          ch_11_ctl_amp_en_reg <= wr_dat_d0(0);
          ch_11_ctl_reserved_reg <= wr_dat_d0(31 downto 1);
        end if;
        ch_11_ctl_wack <= ch_11_ctl_wreq;
      end if;
    end if;
  end process;

  -- Process for write requests.
  process (wr_adr_d0, wr_req_d0, ch_0_ctl_wack, ch_1_ctl_wack, ch_2_ctl_wack, ch_3_ctl_wack, ch_4_ctl_wack, ch_5_ctl_wack, ch_6_ctl_wack, ch_7_ctl_wack, ch_8_ctl_wack, ch_9_ctl_wack, ch_10_ctl_wack, ch_11_ctl_wack) begin
    ch_0_ctl_wreq <= '0';
    ch_1_ctl_wreq <= '0';
    ch_2_ctl_wreq <= '0';
    ch_3_ctl_wreq <= '0';
    ch_4_ctl_wreq <= '0';
    ch_5_ctl_wreq <= '0';
    ch_6_ctl_wreq <= '0';
    ch_7_ctl_wreq <= '0';
    ch_8_ctl_wreq <= '0';
    ch_9_ctl_wreq <= '0';
    ch_10_ctl_wreq <= '0';
    ch_11_ctl_wreq <= '0';
    case wr_adr_d0(6 downto 2) is
    when "00000" =>
      -- Reg ch_0_sta
      wr_ack_int <= wr_req_d0;
    when "00001" =>
      -- Reg ch_0_ctl
      ch_0_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_0_ctl_wack;
    when "00010" =>
      -- Reg ch_1_sta
      wr_ack_int <= wr_req_d0;
    when "00011" =>
      -- Reg ch_1_ctl
      ch_1_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_1_ctl_wack;
    when "00100" =>
      -- Reg ch_2_sta
      wr_ack_int <= wr_req_d0;
    when "00101" =>
      -- Reg ch_2_ctl
      ch_2_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_2_ctl_wack;
    when "00110" =>
      -- Reg ch_3_sta
      wr_ack_int <= wr_req_d0;
    when "00111" =>
      -- Reg ch_3_ctl
      ch_3_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_3_ctl_wack;
    when "01000" =>
      -- Reg ch_4_sta
      wr_ack_int <= wr_req_d0;
    when "01001" =>
      -- Reg ch_4_ctl
      ch_4_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_4_ctl_wack;
    when "01010" =>
      -- Reg ch_5_sta
      wr_ack_int <= wr_req_d0;
    when "01011" =>
      -- Reg ch_5_ctl
      ch_5_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_5_ctl_wack;
    when "01100" =>
      -- Reg ch_6_sta
      wr_ack_int <= wr_req_d0;
    when "01101" =>
      -- Reg ch_6_ctl
      ch_6_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_6_ctl_wack;
    when "01110" =>
      -- Reg ch_7_sta
      wr_ack_int <= wr_req_d0;
    when "01111" =>
      -- Reg ch_7_ctl
      ch_7_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_7_ctl_wack;
    when "10000" =>
      -- Reg ch_8_sta
      wr_ack_int <= wr_req_d0;
    when "10001" =>
      -- Reg ch_8_ctl
      ch_8_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_8_ctl_wack;
    when "10010" =>
      -- Reg ch_9_sta
      wr_ack_int <= wr_req_d0;
    when "10011" =>
      -- Reg ch_9_ctl
      ch_9_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_9_ctl_wack;
    when "10100" =>
      -- Reg ch_10_sta
      wr_ack_int <= wr_req_d0;
    when "10101" =>
      -- Reg ch_10_ctl
      ch_10_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_10_ctl_wack;
    when "10110" =>
      -- Reg ch_11_sta
      wr_ack_int <= wr_req_d0;
    when "10111" =>
      -- Reg ch_11_ctl
      ch_11_ctl_wreq <= wr_req_d0;
      wr_ack_int <= ch_11_ctl_wack;
    when others =>
      wr_ack_int <= wr_req_d0;
    end case;
  end process;

  -- Process for read requests.
  process (adr_int, rd_req_int, rtmlamp_ohwr_regs_i.ch_0_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_0_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_0_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_0_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_0_sta_reserved, ch_0_ctl_amp_en_reg, ch_0_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_1_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_1_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_1_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_1_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_1_sta_reserved, ch_1_ctl_amp_en_reg, ch_1_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_2_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_2_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_2_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_2_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_2_sta_reserved, ch_2_ctl_amp_en_reg, ch_2_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_3_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_3_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_3_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_3_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_3_sta_reserved, ch_3_ctl_amp_en_reg, ch_3_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_4_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_4_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_4_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_4_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_4_sta_reserved, ch_4_ctl_amp_en_reg, ch_4_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_5_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_5_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_5_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_5_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_5_sta_reserved, ch_5_ctl_amp_en_reg, ch_5_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_6_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_6_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_6_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_6_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_6_sta_reserved, ch_6_ctl_amp_en_reg, ch_6_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_7_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_7_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_7_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_7_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_7_sta_reserved, ch_7_ctl_amp_en_reg, ch_7_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_8_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_8_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_8_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_8_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_8_sta_reserved, ch_8_ctl_amp_en_reg, ch_8_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_9_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_9_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_9_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_9_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_9_sta_reserved, ch_9_ctl_amp_en_reg, ch_9_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_10_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_10_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_10_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_10_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_10_sta_reserved, ch_10_ctl_amp_en_reg, ch_10_ctl_reserved_reg, rtmlamp_ohwr_regs_i.ch_11_sta_amp_iflag_l, rtmlamp_ohwr_regs_i.ch_11_sta_amp_tflag_l, rtmlamp_ohwr_regs_i.ch_11_sta_amp_iflag_r, rtmlamp_ohwr_regs_i.ch_11_sta_amp_tflag_r, rtmlamp_ohwr_regs_i.ch_11_sta_reserved, ch_11_ctl_amp_en_reg, ch_11_ctl_reserved_reg) begin
    -- By default ack read requests
    rd_dat_d0 <= (others => 'X');
    case adr_int(6 downto 2) is
    when "00000" =>
      -- Reg ch_0_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_0_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_0_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_0_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_0_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_0_sta_reserved;
    when "00001" =>
      -- Reg ch_0_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_0_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_0_ctl_reserved_reg;
    when "00010" =>
      -- Reg ch_1_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_1_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_1_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_1_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_1_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_1_sta_reserved;
    when "00011" =>
      -- Reg ch_1_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_1_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_1_ctl_reserved_reg;
    when "00100" =>
      -- Reg ch_2_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_2_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_2_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_2_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_2_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_2_sta_reserved;
    when "00101" =>
      -- Reg ch_2_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_2_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_2_ctl_reserved_reg;
    when "00110" =>
      -- Reg ch_3_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_3_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_3_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_3_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_3_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_3_sta_reserved;
    when "00111" =>
      -- Reg ch_3_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_3_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_3_ctl_reserved_reg;
    when "01000" =>
      -- Reg ch_4_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_4_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_4_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_4_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_4_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_4_sta_reserved;
    when "01001" =>
      -- Reg ch_4_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_4_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_4_ctl_reserved_reg;
    when "01010" =>
      -- Reg ch_5_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_5_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_5_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_5_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_5_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_5_sta_reserved;
    when "01011" =>
      -- Reg ch_5_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_5_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_5_ctl_reserved_reg;
    when "01100" =>
      -- Reg ch_6_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_6_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_6_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_6_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_6_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_6_sta_reserved;
    when "01101" =>
      -- Reg ch_6_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_6_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_6_ctl_reserved_reg;
    when "01110" =>
      -- Reg ch_7_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_7_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_7_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_7_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_7_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_7_sta_reserved;
    when "01111" =>
      -- Reg ch_7_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_7_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_7_ctl_reserved_reg;
    when "10000" =>
      -- Reg ch_8_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_8_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_8_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_8_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_8_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_8_sta_reserved;
    when "10001" =>
      -- Reg ch_8_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_8_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_8_ctl_reserved_reg;
    when "10010" =>
      -- Reg ch_9_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_9_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_9_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_9_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_9_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_9_sta_reserved;
    when "10011" =>
      -- Reg ch_9_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_9_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_9_ctl_reserved_reg;
    when "10100" =>
      -- Reg ch_10_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_10_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_10_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_10_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_10_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_10_sta_reserved;
    when "10101" =>
      -- Reg ch_10_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_10_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_10_ctl_reserved_reg;
    when "10110" =>
      -- Reg ch_11_sta
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= rtmlamp_ohwr_regs_i.ch_11_sta_amp_iflag_l;
      rd_dat_d0(1) <= rtmlamp_ohwr_regs_i.ch_11_sta_amp_tflag_l;
      rd_dat_d0(2) <= rtmlamp_ohwr_regs_i.ch_11_sta_amp_iflag_r;
      rd_dat_d0(3) <= rtmlamp_ohwr_regs_i.ch_11_sta_amp_tflag_r;
      rd_dat_d0(31 downto 4) <= rtmlamp_ohwr_regs_i.ch_11_sta_reserved;
    when "10111" =>
      -- Reg ch_11_ctl
      rd_ack_d0 <= rd_req_int;
      rd_dat_d0(0) <= ch_11_ctl_amp_en_reg;
      rd_dat_d0(31 downto 1) <= ch_11_ctl_reserved_reg;
    when others =>
      rd_ack_d0 <= rd_req_int;
    end case;
  end process;
end syn;
