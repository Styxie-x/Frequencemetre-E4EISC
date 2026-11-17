library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity bcd_counter_tb is
end;

architecture bench of bcd_counter_tb is

  component bcd_counter
      port(
          freqin : in std_logic;
          bcd_unit, bcd_ten, bcd_hundred, bcd_thousand, bcd_ten_thousand, bcd_hundred_thousand, bcd_million, bcd_ten_million : out std_logic_vector(3 downto 0);
          meas_window : in std_logic;
          reset : in std_logic
          );
  end component;

  signal freqin: std_logic;
  signal bcd_unit, bcd_ten, bcd_hundred, bcd_thousand, bcd_ten_thousand, bcd_hundred_thousand, bcd_million, bcd_ten_million: std_logic_vector(3 downto 0);
  signal meas_window: std_logic;
  signal reset: std_logic ;

begin

  uut: bcd_counter port map ( freqin               => freqin,
                              bcd_unit             => bcd_unit,
                              bcd_ten              => bcd_ten,
                              bcd_hundred          => bcd_hundred,
                              bcd_thousand         => bcd_thousand,
                              bcd_ten_thousand     => bcd_ten_thousand,
                              bcd_hundred_thousand => bcd_hundred_thousand,
                              bcd_million          => bcd_million,
                              bcd_ten_million      => bcd_ten_million,
                              meas_window          => meas_window,
                              reset                => reset );

  stimulus: process
  begin

    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;