library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity clk_div_tb is
end;

architecture bench of clk_div_tb is

  component clk_div
      port(
          clock : in std_logic;
          N : in integer;
          O : out std_logic
      );
  end component;

  signal clock: std_logic;
  signal N: integer;
  signal O: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: clk_div port map ( clock => clock,
                          N     => N,
                          O     => O );

  stimulus: process
  begin

    -- Put initialisation code here


    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;