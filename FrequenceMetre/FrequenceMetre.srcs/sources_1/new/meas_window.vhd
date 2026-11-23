library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity meas_window is
  generic(
    window_cycles : integer := 100000000
  );
  port(
    clock_100mhz : in std_logic;
    reset        : in std_logic;
    meas_window  : out std_logic;
    latch        : out std_logic;
    clear        : out std_logic;
    clock_1hz    : out std_logic
  );
end meas_window;

architecture Behavioral of meas_window is
  signal count : integer range 0 to 99999999 := 0;
begin

  process(clock_100mhz, reset)
  begin
    if reset = '1' then
      count       <= 0;
      meas_window <= '1';
      latch       <= '0';
      clear       <= '1';
      clock_1hz   <= '0';

    elsif rising_edge(clock_100mhz) then
      latch <= '0';
      clear <= '0';

      if count < window_cycles / 2 then
        clock_1hz <= '1';
      else
        clock_1hz <= '0';
      end if;

      if count < window_cycles - 1 then
        meas_window <= '1';
        count <= count + 1;
      else
        meas_window <= '0';
        latch <= '1';
        clear <= '1';
        count <= 0;
      end if;
    end if;
  end process;

end Behavioral;
