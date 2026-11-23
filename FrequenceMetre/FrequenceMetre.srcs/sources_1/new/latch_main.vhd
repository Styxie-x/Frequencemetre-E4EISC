library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_main is
  port(
    latch : in std_logic;

    bcd_unit, bcd_ten, bcd_hundred, bcd_thousand : in std_logic_vector(3 downto 0);
    bcd_ten_thousand, bcd_hundred_thousand : in std_logic_vector(3 downto 0);
    bcd_million, bcd_ten_million : in std_logic_vector(3 downto 0);

    lat_unit, lat_ten, lat_hundred, lat_thousand : out std_logic_vector(3 downto 0);
    lat_ten_thousand, lat_hundred_thousand : out std_logic_vector(3 downto 0);
    lat_million, lat_ten_million : out std_logic_vector(3 downto 0)
  );
end latch_main;

architecture Behavioral of latch_main is

  component data_latch
    port(
      data_in  : in std_logic_vector(3 downto 0);
      data_out : out std_logic_vector(3 downto 0);
      latch    : in std_logic
    );
  end component;

begin

  latch_unit : data_latch port map(data_in => bcd_unit, data_out => lat_unit, latch => latch);
  latch_ten : data_latch port map(data_in => bcd_ten, data_out => lat_ten, latch => latch);
  latch_hundred : data_latch port map(data_in => bcd_hundred, data_out => lat_hundred, latch => latch);
  latch_thousand : data_latch port map(data_in => bcd_thousand, data_out => lat_thousand, latch => latch);
  latch_ten_thousand : data_latch port map(data_in => bcd_ten_thousand, data_out => lat_ten_thousand, latch => latch);
  latch_hundred_thousand : data_latch port map(data_in => bcd_hundred_thousand, data_out => lat_hundred_thousand, latch => latch);
  latch_million : data_latch port map(data_in => bcd_million, data_out => lat_million, latch => latch);
  latch_ten_million : data_latch port map(data_in => bcd_ten_million, data_out => lat_ten_million, latch => latch);

end Behavioral;
