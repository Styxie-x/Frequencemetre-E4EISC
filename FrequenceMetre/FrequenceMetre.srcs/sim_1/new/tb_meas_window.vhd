library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity meas_window_tb is
end meas_window_tb;

architecture bench of meas_window_tb is

  component meas_window
    generic(window_cycles : integer := 20);
    port(
      clock_100mhz : in std_logic;
      reset : in std_logic;
      meas_window : out std_logic;
      latch : out std_logic;
      clear : out std_logic;
      clock_1hz : out std_logic
    );
  end component;

  signal clock_100mhz : std_logic := '0';
  signal reset : std_logic := '1';
  signal gate : std_logic;
  signal latch : std_logic;
  signal clear : std_logic;
  signal clock_1hz : std_logic;

begin

  uut : meas_window
    generic map(window_cycles => 20)
    port map(
      clock_100mhz => clock_100mhz,
      reset => reset,
      meas_window => gate,
      latch => latch,
      clear => clear,
      clock_1hz => clock_1hz
    );

  clock_100mhz <= not clock_100mhz after 5 ns;

  stimulus : process
  begin
    wait for 12 ns;
    reset <= '0';

    wait until latch = '1';
    assert gate = '0'
      report "Measurement gate did not close at window end" severity error;
    assert clear = '1'
      report "Clear signal was not generated at window end" severity error;

    wait for 30 ns;
    wait;
  end process;

end bench;
