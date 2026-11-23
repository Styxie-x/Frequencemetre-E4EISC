library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd_to_7seg_tb is
end bcd_to_7seg_tb;

architecture bench of bcd_to_7seg_tb is

  component bcd_to_7seg
    port(B : in std_logic_vector(3 downto 0); O : out std_logic_vector(7 downto 0));
  end component;

  signal B : std_logic_vector(3 downto 0) := "0000";
  signal O : std_logic_vector(7 downto 0);

begin

  uut : bcd_to_7seg port map(B => B, O => O);

  stimulus : process
  begin
    for i in 0 to 15 loop
      B <= std_logic_vector(to_unsigned(i, 4));
      wait for 10 ns;
    end loop;
    wait;
  end process;

end bench;
