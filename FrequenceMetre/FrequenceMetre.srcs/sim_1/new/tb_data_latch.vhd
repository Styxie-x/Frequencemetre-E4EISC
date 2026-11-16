-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity data_latch_tb is
end;

architecture bench of data_latch_tb is

  component data_latch
      port(
        data_in  : in std_logic_vector(3 downto 0);
        data_out : out std_logic_vector(3 downto 0);
        latch    : in std_logic
      );
  end component;

  signal data_in  : std_logic_vector(3 downto 0) := "0000";
  signal data_out : std_logic_vector(3 downto 0);
  signal latch    : std_logic := '0';

  constant clock_period : time := 10 ns;
  signal stop_the_clock : boolean := false;

begin

  uut: data_latch port map ( data_in  => data_in,
                             data_out => data_out,
                             latch    => latch );

  stimulus: process
  begin
    -- 1. Initial value captured at first rising edge (5 ns)
    data_in <= "0011"; -- 3
    wait for 12 ns;

    -- 2. Changes at 12 ns -> held until next rising edge at 15 ns
    data_in <= "1001"; -- 9
    wait for 20 ns;

    -- 3. Changes at 32 ns -> held until next rising edge at 35 ns
    data_in <= "0101"; -- 5
    wait for 10 ns;

    -- 4. Brief glitch between edges (42 ns to 45 ns) -> must be ignored
    data_in <= "1111"; -- F
    wait for 3 ns;
    data_in <= "0101"; -- 5
    wait for 15 ns;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      latch <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;