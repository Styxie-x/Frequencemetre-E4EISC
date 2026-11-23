library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_main_tb is
end latch_main_tb;

architecture bench of latch_main_tb is

  component latch_main
    port(
      latch : in std_logic;
      bcd_unit, bcd_ten, bcd_hundred, bcd_thousand : in std_logic_vector(3 downto 0);
      bcd_ten_thousand, bcd_hundred_thousand : in std_logic_vector(3 downto 0);
      bcd_million, bcd_ten_million : in std_logic_vector(3 downto 0);
      lat_unit, lat_ten, lat_hundred, lat_thousand : out std_logic_vector(3 downto 0);
      lat_ten_thousand, lat_hundred_thousand : out std_logic_vector(3 downto 0);
      lat_million, lat_ten_million : out std_logic_vector(3 downto 0)
    );
  end component;

  signal latch : std_logic := '0';
  signal bcd_unit, bcd_ten, bcd_hundred, bcd_thousand : std_logic_vector(3 downto 0) := "0000";
  signal bcd_ten_thousand, bcd_hundred_thousand : std_logic_vector(3 downto 0) := "0000";
  signal bcd_million, bcd_ten_million : std_logic_vector(3 downto 0) := "0000";
  signal lat_unit, lat_ten, lat_hundred, lat_thousand : std_logic_vector(3 downto 0);
  signal lat_ten_thousand, lat_hundred_thousand : std_logic_vector(3 downto 0);
  signal lat_million, lat_ten_million : std_logic_vector(3 downto 0);

begin

  uut : latch_main port map(
    latch => latch,
    bcd_unit => bcd_unit, bcd_ten => bcd_ten,
    bcd_hundred => bcd_hundred, bcd_thousand => bcd_thousand,
    bcd_ten_thousand => bcd_ten_thousand,
    bcd_hundred_thousand => bcd_hundred_thousand,
    bcd_million => bcd_million, bcd_ten_million => bcd_ten_million,
    lat_unit => lat_unit, lat_ten => lat_ten,
    lat_hundred => lat_hundred, lat_thousand => lat_thousand,
    lat_ten_thousand => lat_ten_thousand,
    lat_hundred_thousand => lat_hundred_thousand,
    lat_million => lat_million, lat_ten_million => lat_ten_million
  );

  latch <= '0', '1' after 5 ns, '0' after 15 ns;

  stimulus : process
  begin
    bcd_unit <= "0001"; bcd_ten <= "0010";
    bcd_hundred <= "0011"; bcd_thousand <= "0100";
    bcd_ten_thousand <= "0101"; bcd_hundred_thousand <= "0110";
    bcd_million <= "0111"; bcd_ten_million <= "1000";

    wait for 20 ns;
    assert lat_unit = "0001" and lat_ten_million = "1000"
      report "Latch_main did not capture all BCD values" severity error;

    bcd_unit <= "1001";
    wait for 20 ns;
    assert lat_unit = "0001"
      report "Latch_main did not hold captured data" severity error;

    wait;
  end process;

end bench;
