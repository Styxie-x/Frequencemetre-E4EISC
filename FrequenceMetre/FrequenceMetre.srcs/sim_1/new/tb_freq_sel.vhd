library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_sel_tb is
end freq_sel_tb;

architecture bench of freq_sel_tb is

  component freq_sel
    port(
      my_freq : in integer;
      N : out integer
    );
  end component;

  signal my_freq : integer := 0;
  signal N : integer;

begin

  uut : freq_sel port map(my_freq => my_freq, N => N);

  stimulus : process
  begin
    my_freq <= 1000000;
    wait for 10 ns;
    assert N = 100
      report "Incorrect divider for 1 MHz" severity error;

    my_freq <= 5000;
    wait for 10 ns;
    assert N = 20000
      report "Incorrect divider for 5 kHz" severity error;

    my_freq <= 0;
    wait for 10 ns;
    assert N = 1
      report "Divider must not divide by zero" severity error;

    wait;
  end process;

end bench;
