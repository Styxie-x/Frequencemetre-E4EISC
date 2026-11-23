library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd0to9_counter_tb is
end bcd0to9_counter_tb;

architecture bench of bcd0to9_counter_tb is

  component bcd0to9_counter
    port(
      clk : in std_logic;
      reset : in std_logic;
      enable : in std_logic;
      carry : out std_logic;
      bcd4 : out std_logic_vector(3 downto 0)
    );
  end component;

  signal clk : std_logic := '0';
  signal reset : std_logic := '1';
  signal enable : std_logic := '1';
  signal carry : std_logic;
  signal bcd4 : std_logic_vector(3 downto 0);

begin

  uut : bcd0to9_counter port map(clk, reset, enable, carry, bcd4);
  clk <= not clk after 5 ns;

  stimulus : process
  begin
    wait for 12 ns;
    reset <= '0';

    for i in 1 to 10 loop
      wait until rising_edge(clk);
    end loop;

    assert bcd4 = "0000"
      report "BCD counter did not wrap after 9" severity error;

    wait;
  end process;

end bench;
