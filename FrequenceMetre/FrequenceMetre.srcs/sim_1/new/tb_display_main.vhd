library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_main_tb is
end display_main_tb;

architecture bench of display_main_tb is

  component display_main
    generic(scan_cycles : integer := 9999);
    port(
      clock : in std_logic;
      reset : in std_logic;
      lat_unit, lat_ten, lat_hundred, lat_thousand : in std_logic_vector(3 downto 0);
      lat_ten_thousand, lat_hundred_thousand : in std_logic_vector(3 downto 0);
      lat_million, lat_ten_million : in std_logic_vector(3 downto 0);
      SEG : out std_logic_vector(7 downto 0);
      AN : out std_logic_vector(7 downto 0)
    );
  end component;

  signal clock : std_logic := '0';
  signal reset : std_logic := '1';
  signal lat_unit, lat_ten, lat_hundred, lat_thousand : std_logic_vector(3 downto 0) := "0000";
  signal lat_ten_thousand, lat_hundred_thousand : std_logic_vector(3 downto 0) := "0000";
  signal lat_million, lat_ten_million : std_logic_vector(3 downto 0) := "0000";
  signal SEG : std_logic_vector(7 downto 0);
  signal AN : std_logic_vector(7 downto 0);

begin

  uut : display_main
    generic map(scan_cycles => 2)
    port map(
      clock => clock, reset => reset,
      lat_unit => lat_unit, lat_ten => lat_ten,
      lat_hundred => lat_hundred, lat_thousand => lat_thousand,
      lat_ten_thousand => lat_ten_thousand,
      lat_hundred_thousand => lat_hundred_thousand,
      lat_million => lat_million, lat_ten_million => lat_ten_million,
      SEG => SEG, AN => AN
    );

  clock <= not clock after 5 ns;

  stimulus : process
  begin
    lat_unit <= "0001";
    lat_ten <= "0010";
    lat_hundred <= "0011";
    lat_thousand <= "0100";
    lat_ten_thousand <= "0101";
    lat_hundred_thousand <= "0110";
    lat_million <= "0111";
    lat_ten_million <= "1000";

    wait for 12 ns;
    reset <= '0';
    wait for 80 ns;

    assert AN /= "11111111"
      report "Display_main did not activate a digit" severity error;

    wait;
  end process;

end bench;
