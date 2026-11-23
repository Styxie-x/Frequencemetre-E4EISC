library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_main is
  generic(
    scan_cycles : integer := 9999
  );
  port(
    clock  : in std_logic;
    reset  : in std_logic;

    lat_unit, lat_ten, lat_hundred, lat_thousand : in std_logic_vector(3 downto 0);
    lat_ten_thousand, lat_hundred_thousand : in std_logic_vector(3 downto 0);
    lat_million, lat_ten_million : in std_logic_vector(3 downto 0);

    SEG : out std_logic_vector(7 downto 0);
    AN  : out std_logic_vector(7 downto 0)
  );
end display_main;

architecture Behavioral of display_main is

  component bcd_to_7seg
    port(
      B : in std_logic_vector(3 downto 0);
      O : out std_logic_vector(7 downto 0)
    );
  end component;

  signal seg_unit, seg_ten, seg_hundred, seg_thousand : std_logic_vector(7 downto 0);
  signal seg_ten_thousand, seg_hundred_thousand : std_logic_vector(7 downto 0);
  signal seg_million, seg_ten_million : std_logic_vector(7 downto 0);

  signal scan_count : integer range 0 to 9999 := 0;
  signal digit : integer range 0 to 7 := 0;

begin

  seg_unit_inst : bcd_to_7seg port map(B => lat_unit, O => seg_unit);
  seg_ten_inst : bcd_to_7seg port map(B => lat_ten, O => seg_ten);
  seg_hundred_inst : bcd_to_7seg port map(B => lat_hundred, O => seg_hundred);
  seg_thousand_inst : bcd_to_7seg port map(B => lat_thousand, O => seg_thousand);
  seg_ten_thousand_inst : bcd_to_7seg port map(B => lat_ten_thousand, O => seg_ten_thousand);
  seg_hundred_thousand_inst : bcd_to_7seg port map(B => lat_hundred_thousand, O => seg_hundred_thousand);
  seg_million_inst : bcd_to_7seg port map(B => lat_million, O => seg_million);
  seg_ten_million_inst : bcd_to_7seg port map(B => lat_ten_million, O => seg_ten_million);

  process(clock, reset)
  begin
    if reset = '1' then
      scan_count <= 0;
      digit <= 0;
      AN <= "11111111";
      SEG <= "11111111";

    elsif rising_edge(clock) then
      if scan_count = scan_cycles then
        scan_count <= 0;
        if digit = 7 then
          digit <= 0;
        else
          digit <= digit + 1;
        end if;
      else
        scan_count <= scan_count + 1;
      end if;

      case digit is
        when 0 => AN <= "11111110"; SEG <= seg_unit;
        when 1 => AN <= "11111101"; SEG <= seg_ten;
        when 2 => AN <= "11111011"; SEG <= seg_hundred;
        when 3 => AN <= "11110111"; SEG <= seg_thousand;
        when 4 => AN <= "11101111"; SEG <= seg_ten_thousand;
        when 5 => AN <= "11011111"; SEG <= seg_hundred_thousand;
        when 6 => AN <= "10111111"; SEG <= seg_million;
        when 7 => AN <= "01111111"; SEG <= seg_ten_million;
        when others => AN <= "11111111"; SEG <= "11111111";
      end case;
    end if;
  end process;

end Behavioral;
