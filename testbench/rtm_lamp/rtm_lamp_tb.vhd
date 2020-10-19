------------------------------------------------------------------------------
-- Title      : RTM-LAMP model testbench
------------------------------------------------------------------------------
-- Author     : Augusto Fraga Giachero
-- Company    : CNPEM LNLS-DIG
-- Created    : 2020-10-06
-- Platform   : Simulation only
-------------------------------------------------------------------------------
-- Description: Drive all 12 current channels and read back the currents.
--              Currents outside +- 1A will saturate the ADC, the maximum
--              driving voutage per channel is 4V.
-------------------------------------------------------------------------------
-- Copyright (c) 2020 CNPEM
-- Licensed under GNU Lesser General Public License (LGPL) v3.0
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author          Description
-- 2020-10-06  1.0      augusto.fraga   Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity rtm_lamp_tb is
end rtm_lamp_tb;

architecture rtm_lamp_tb_arch of rtm_lamp_tb is
  type sample_vector is array(11 downto 0) of std_logic_vector(15 downto 0);
  signal adc_dac_100mhz_clk: std_logic := '0';
  signal dac_50mhz_clk     : std_logic := '0';
  signal dac_samples       : sample_vector := (others => x"8000");
  signal dac_samples_buf   : sample_vector := (others => x"8000");
  signal adc_samples       : sample_vector := (others => x"0000");
  signal adc_data_c1c2     : std_logic_vector(31 downto 0);
  signal adc_data_c3c4     : std_logic_vector(31 downto 0);
  signal adc_data_c5c6     : std_logic_vector(31 downto 0);
  signal adc_data_c7c8     : std_logic_vector(31 downto 0);
  signal adc_data_c9c10    : std_logic_vector(31 downto 0);
  signal adc_data_c11c12   : std_logic_vector(31 downto 0);
  signal adc_msb_sample    : std_logic_vector(5 downto 0);
  signal adc_read_latch    : std_logic := '0';
  signal rtm_lamp_sync_clk : std_logic := '0';
  signal adc_cnv           : std_logic := '0';
  signal adc_octo_clk      : std_logic := '0';
  signal adc_octo_clk_out  : std_logic;
  signal adc_octo_sdoa     : std_logic;
  signal adc_octo_sdob     : std_logic;
  signal adc_octo_sdoc     : std_logic;
  signal adc_octo_sdod     : std_logic;
  signal adc_quad_clk      : std_logic := '0';
  signal adc_quad_clk_out  : std_logic;
  signal adc_quad_sdoa     : std_logic;
  signal adc_quad_sdoc     : std_logic;
  signal dac_ldac          : std_logic := '0';
  signal dac_cs            : std_logic := '1';
  signal dac_sck           : std_logic := '0';
  signal dac_sdi           : std_logic_vector(11 downto 0) := x"000";
begin
  rtm_lamp_inst: entity work.rtm_lamp
    port map(
      rtm_lamp_sync_clk_i => rtm_lamp_sync_clk, -- ADC and DAC synchronization clock
                                                -- for conversion start

      adc_cnv_i => adc_cnv,             -- ADC conversion start

      adc_octo_clk_i => adc_octo_clk,     -- ADC octo data clock input
      adc_octo_clk_o => adc_octo_clk_out, -- ADC octo data clock output
      adc_octo_sdoa_o => adc_octo_sdoa,
      adc_octo_sdob_o => adc_octo_sdob,
      adc_octo_sdoc_o => adc_octo_sdoc,
      adc_octo_sdod_o => adc_octo_sdod,

      adc_quad_clk_i => adc_quad_clk,     -- ADC quad data clock input
      adc_quad_clk_o => adc_quad_clk_out, -- ADC quad data clock output
      adc_quad_sdoa_o => adc_quad_sdoa,
      adc_quad_sdoc_o => adc_quad_sdoc,

      dac_ldac_i => dac_ldac,          -- DAC load
      dac_cs_i => dac_cs,              -- DAC chip select
      dac_sck_i => dac_sck,            -- DAC data clock
      dac_sdi_i => dac_sdi             -- DAC data input (12 channels)
      );

  ddr_des_c1c2: entity work.ddr_des
    generic map(
      bits => 32,
      polarity => true,
      msb_first => true
      )
    port map(
      clk_ddr_i => adc_octo_clk_out,
      data_ddr_i => adc_octo_sdoa,
      data_latch_i => adc_read_latch,
      parallel_o => adc_data_c1c2
      );

  ddr_des_c3c4: entity work.ddr_des
    generic map(
      bits => 32,
      polarity => true,
      msb_first => true
      )
    port map(
      clk_ddr_i => adc_octo_clk_out,
      data_ddr_i => adc_octo_sdob,
      data_latch_i => adc_read_latch,
      parallel_o => adc_data_c3c4
      );

  ddr_des_c5c6: entity work.ddr_des
    generic map(
      bits => 32,
      polarity => true,
      msb_first => true
      )
    port map(
      clk_ddr_i => adc_octo_clk_out,
      data_ddr_i => adc_octo_sdoc,
      data_latch_i => adc_read_latch,
      parallel_o => adc_data_c5c6
      );

  ddr_des_c7c8: entity work.ddr_des
    generic map(
      bits => 32,
      polarity => true,
      msb_first => true
      )
    port map(
      clk_ddr_i => adc_octo_clk_out,
      data_ddr_i => adc_octo_sdod,
      data_latch_i => adc_read_latch,
      parallel_o => adc_data_c7c8
      );

  ddr_des_c9c10: entity work.ddr_des
    generic map(
      bits => 32,
      polarity => true,
      msb_first => true
      )
    port map(
      clk_ddr_i => adc_quad_clk_out,
      data_ddr_i => adc_quad_sdoa,
      data_latch_i => adc_read_latch,
      parallel_o => adc_data_c9c10
      );

  ddr_des_c11c12: entity work.ddr_des
    generic map(
      bits => 32,
      polarity => true,
      msb_first => true
      )
    port map(
      clk_ddr_i => adc_quad_clk_out,
      data_ddr_i => adc_quad_sdoc,
      data_latch_i => adc_read_latch,
      parallel_o => adc_data_c11c12
      );

  process
  begin
    loop
      wait for 8 ns;
      rtm_lamp_sync_clk <= not rtm_lamp_sync_clk; -- 62.5 MHz (RF/8)
    end loop;
  end process;

  process
  begin
    loop
      wait for 5 ns;
      adc_dac_100mhz_clk <= not adc_dac_100mhz_clk; -- 100 MHz
    end loop;
  end process;

  process(adc_dac_100mhz_clk)
  begin
    if rising_edge(adc_dac_100mhz_clk) then
      dac_50mhz_clk <= not dac_50mhz_clk;
    end if;
  end process;

  process
  begin
    wait for 1 ms;
    dac_samples <= (x"0000", x"1000", x"3000", x"4000",
                    x"5000", x"6000", x"7000", x"8000",
                    x"9000", x"A000", x"B000", x"C000");
    wait for 3 ms;
    dac_samples <= (others => x"FFFF");
    wait for 3 ms;
    dac_samples <= (x"EEEE", x"DDDD", x"CCCC", x"BBBB",
                    x"AAAA", x"9999", x"8888", x"7777",
                    x"6666", x"5555", x"4444", x"3333");
    wait for 3 ms;
    std.env.finish;
  end process;

  process(dac_50mhz_clk)
    type state_t is (cs_idle, data_send, delay_ldac, ldac);
    variable state : state_t := cs_idle;
    variable cyc_cnt : integer range 0 to 31 := 0;
  begin

    if rising_edge(dac_50mhz_clk) then

      case state is

        when cs_idle =>
          if cyc_cnt = 6 then
            state := data_send;
            cyc_cnt := 0;
            dac_cs <= '0';
            dac_samples_buf <= dac_samples;
            for i in 0 to 11 loop
              dac_sdi(i) <= dac_samples(i)(15);
            end loop;
          else
            dac_sck <= '0';
            dac_cs <= '1';
            cyc_cnt := cyc_cnt + 1;
          end if;

        when data_send =>
          if cyc_cnt = 16 then
            state := delay_ldac;
            cyc_cnt := 0;
            dac_cs <= '1';
            dac_sck <= '0';
          else
            if dac_sck = '1' then
              if cyc_cnt < 15 then
                for i in 0 to 11 loop
                  dac_sdi(i) <= dac_samples_buf(i)(14 - cyc_cnt);
                end loop;
              end if;
              cyc_cnt := cyc_cnt + 1;
              dac_sck <= '0';
            else
              dac_sck <= '1';
            end if;
          end if;

        when delay_ldac =>
          if cyc_cnt = 4 then
            state := ldac;
            cyc_cnt := 0;
          else
            cyc_cnt := cyc_cnt + 1;
          end if;

        when ldac =>
          if cyc_cnt = 4 then
            state := cs_idle;
            cyc_cnt := 0;
            dac_ldac <= '0';
          else
            dac_ldac <= '1';
            cyc_cnt := cyc_cnt + 1;
          end if;
      end case;
    end if;
  end process;

  process(adc_dac_100mhz_clk, adc_octo_clk_out, adc_quad_clk_out)
    type state_t is (adc_idle, adc_cnv_hold, adc_cnv_wait,
                     adc_read, adc_copy_data);
    variable state : state_t := adc_idle;
    variable cyc_cnt : integer range 0 to 63 := 0;
  begin
    if rising_edge(adc_dac_100mhz_clk) then

      case state is

      when adc_idle =>
        if cyc_cnt = 10 then
          adc_cnv <= '0';
          state := adc_cnv_hold;
          cyc_cnt := 0;
        else
          cyc_cnt := cyc_cnt + 1;
        end if;

      when adc_cnv_hold =>
        if cyc_cnt = 3 then
          adc_cnv <= '1';
          state := adc_cnv_wait;
          cyc_cnt := 0;
        else
          cyc_cnt := cyc_cnt + 1;
        end if;

      when adc_cnv_wait =>
        if cyc_cnt = 50 then
          state := adc_read;
          cyc_cnt := 0;
          adc_msb_sample(0) <= adc_octo_sdoa;
          adc_msb_sample(1) <= adc_octo_sdob;
          adc_msb_sample(2) <= adc_octo_sdoc;
          adc_msb_sample(3) <= adc_octo_sdod;
          adc_msb_sample(4) <= adc_quad_sdoa;
          adc_msb_sample(5) <= adc_quad_sdoc;
        else
          cyc_cnt := cyc_cnt + 1;
        end if;

      when adc_read =>
        if cyc_cnt = 32 then
          state := adc_copy_data;
          cyc_cnt := 0;
          adc_read_latch <= '1';
        else
          cyc_cnt := cyc_cnt + 1;
          adc_octo_clk <= not adc_octo_clk;
          adc_quad_clk <= not adc_quad_clk;
        end if;

      when adc_copy_data =>
        adc_read_latch <= '0';
        state := adc_idle;

        adc_samples(0) <= adc_msb_sample(0) & adc_data_c1c2(31 downto 17);
        adc_samples(1) <= adc_data_c1c2(16 downto 1);
        adc_samples(2) <= adc_msb_sample(1) & adc_data_c3c4(31 downto 17);
        adc_samples(3) <= adc_data_c3c4(16 downto 1);
        adc_samples(4) <= adc_msb_sample(2) & adc_data_c5c6(31 downto 17);
        adc_samples(5) <= adc_data_c5c6(16 downto 1);
        adc_samples(6) <= adc_msb_sample(3) & adc_data_c7c8(31 downto 17);
        adc_samples(7) <= adc_data_c7c8(16 downto 1);
        adc_samples(8) <= adc_msb_sample(4) & adc_data_c9c10(31 downto 17);
        adc_samples(9) <= adc_data_c9c10(16 downto 1);
        adc_samples(10) <= adc_msb_sample(5) & adc_data_c11c12(31 downto 17);
        adc_samples(11) <= adc_data_c11c12(16 downto 1);


      end case;

    end if;

  end process;

end rtm_lamp_tb_arch;
