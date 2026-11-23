library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_div_tb is
end clk_div_tb;

architecture bench of clk_div_tb is

  component clk_div
    port(
      clock : in std_logic;
      N : in integer;
      O : out std_logic
    );
  end component;

  signal clock : std_logic := '0';
  signal N : integer := 4;
  signal O : std_logic;

begin

  uut : clk_div port map(clock => clock, N => N, O => O);
  clock <= not clock after 5 ns;

  stimulus : process
  begin
    wait for 75 ns;

    assert O = '1'
      report "Clock divider did not generate a pulse" severity error;

    wait;
  end process;

end bench;
