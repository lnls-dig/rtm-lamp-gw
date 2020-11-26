library ieee;
use ieee.std_logic_1164.all;

package rtm_lamp_pkg is
  type array_16b_word is array(natural range <>) of std_logic_vector(15 downto 0);
  -- Multiple SPI DAC interface
  component multi_dac_spi is
    generic(
      g_clk_freq:      natural := 100_000_000;
      g_sclk_freq:     natural := 50_000_000;
      g_num_dacs:      natural := 8;
      g_cpol:          boolean := false
      );
    port(
      clk_i:       in  std_logic;
      rst_n_i:     in  std_logic;
      start_i:     in  std_logic;
      ready_o:     out std_logic := '0';
      data_i:      in  array_16b_word(g_num_dacs-1 downto 0);
      dac_cs_o:    out std_logic;
      dac_sck_o:   out std_logic;
      dac_sdi_o:   out std_logic_vector(g_num_dacs-1 downto 0)
      );
  end component;
end rtm_lamp_pkg;
