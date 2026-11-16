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

  signal freqin: std_logic := '0';
  signal bcd_unit, bcd_ten, bcd_hundred, bcd_thousand, bcd_ten_thousand, bcd_hundred_thousand, bcd_million, bcd_ten_million: std_logic_vector(3 downto 0);
  signal meas_window: std_logic := '0';
  signal reset: std_logic := '0';

  -- Demi-période courante de freqin
  signal half_period : time := 100 ms;

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

  -- Générateur d'horloge freqin réactif au changement de half_period
  freq_gen: process
  begin
    freqin <= '0';
    wait on half_period for half_period;
    freqin <= '1';
    wait on half_period for half_period;
  end process;

  -- Stimulus sur les 8 calibres de fréquence
  stimulus: process
  begin
    -- Initialisation
    reset <= '1';
    meas_window <= '0';
    wait for 10 ns;
    reset <= '0';

    -- 1re sec : 5 Hz -> 00000005
    half_period <= 100 ms;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;
    reset <= '1'; wait for 10 ns; reset <= '0';

    -- 2e sec : 50 Hz -> 00000050
    half_period <= 10 ms;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;
    reset <= '1'; wait for 10 ns; reset <= '0';

    -- 3e sec : 500 Hz -> 00000500
    half_period <= 1 ms;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;
    reset <= '1'; wait for 10 ns; reset <= '0';

    -- 4e sec : 5 000 Hz -> 00005000
    half_period <= 100 us;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;
    reset <= '1'; wait for 10 ns; reset <= '0';

    -- 5e sec : 50 kHz -> 00050000
    half_period <= 10 us;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;
    reset <= '1'; wait for 10 ns; reset <= '0';

    -- 6e sec : 500 kHz -> 00500000
    half_period <= 1 us;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;
    reset <= '1'; wait for 10 ns; reset <= '0';

    -- 7e sec : 5 MHz -> 05000000
    half_period <= 100 ns;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;
    reset <= '1'; wait for 10 ns; reset <= '0';

    -- 8e sec : 50 MHz -> 50000000
    half_period <= 10 ns;
    meas_window <= '1';
    wait for 1 sec;
    meas_window <= '0';
    wait for 10 ns;

    wait;
  end process;

end;