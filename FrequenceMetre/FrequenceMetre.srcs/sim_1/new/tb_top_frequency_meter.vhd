library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_frequency_meter_tb is
end top_frequency_meter_tb;

architecture bench of top_frequency_meter_tb is

  component top_frequency_meter
    generic(
      window_cycles : integer := 100000000;
      scan_cycles : integer := 9999
    );
    port(
      clk100mhz : in std_logic;
      reset : in std_logic;
      freqin : in std_logic;
      SEG : out std_logic_vector(7 downto 0);
      AN : out std_logic_vector(7 downto 0)
    );
  end component;

  signal clk100mhz : std_logic := '0';
  signal reset : std_logic := '1';
  signal freqin : std_logic := '0';
  signal SEG : std_logic_vector(7 downto 0);
  signal AN : std_logic_vector(7 downto 0);

begin

  uut : top_frequency_meter
    generic map(window_cycles => 20, scan_cycles => 2)
    port map(
      clk100mhz => clk100mhz,
      reset => reset,
      freqin => freqin,
      SEG => SEG,
      AN => AN
    );

  clk100mhz <= not clk100mhz after 5 ns;
  freqin <= not freqin after 10 ns;

  stimulus : process
  begin
    wait for 12 ns;
    reset <= '0';

    wait for 300 ns;

    assert AN /= "11111111"
      report "Top-level display did not activate an anode" severity error;

    wait;
  end process;

end bench;
