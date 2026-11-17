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
  signal clk: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

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

    -- Put initialisation code here


    -- Put test bench stimulus code here

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