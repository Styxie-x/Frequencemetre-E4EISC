-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity display_mux_tb is
end;

architecture bench of display_mux_tb is

  component display_mux
      Port ( 
          Unit,Ten,Hundred,Thousand : in std_logic_vector(7 downto 0);
          O : out std_logic_vector(7 downto 0);
          Sel : out std_logic_vector(3 downto 0);
          clk : in std_logic
      );
  end component;

  signal Unit,Ten,Hundred,Thousand: std_logic_vector(7 downto 0);
  signal O: std_logic_vector(7 downto 0);
  signal Sel: std_logic_vector(3 downto 0);
  signal clk: std_logic;

  constant clock_period: time := 1 ns;
  signal stop_the_clock: boolean := false;

begin

  uut: display_mux port map ( Unit     => Unit,
                              Ten      => Ten,
                              Hundred  => Hundred,
                              Thousand => Thousand,
                              O        => O,
                              Sel      => Sel,
                              clk      => clk );

  stimulus: process
  begin
    -- 1. Set distinct test patterns on each digit
    Unit     <= "00000000"; -- 0x00
    Ten      <= "00001111"; -- 0x0F
    Hundred  <= "11110000"; -- 0xF0
    Thousand <= "11111111"; -- 0xFF

    -- 2. Wait 500 us so all 4 digits switch (each digit takes 100 us = 10,000 x 10 ns)
    wait for 50 us;

    -- 3. Stop clock and end simulation
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;