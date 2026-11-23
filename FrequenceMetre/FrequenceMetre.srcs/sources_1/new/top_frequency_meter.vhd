library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_frequency_meter is
  generic(
    window_cycles : integer := 100000000;
    scan_cycles   : integer := 9999
  );
  port(
    clk100mhz : in std_logic;
    reset     : in std_logic;
    freqin    : in std_logic;
    SEG       : out std_logic_vector(7 downto 0);
    AN        : out std_logic_vector(7 downto 0)
  );
end top_frequency_meter;

architecture Behavioral of top_frequency_meter is

  component meas_window
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
  end component;

  component bcd_counter
    port(
      freqin : in std_logic;
      bcd_unit, bcd_ten, bcd_hundred, bcd_thousand, bcd_ten_thousand, bcd_hundred_thousand, bcd_million, bcd_ten_million : out std_logic_vector(3 downto 0);
      meas_window : in std_logic;
      reset : in std_logic
    );
  end component;

  component latch_main
    port(
      latch : in std_logic;
      bcd_unit, bcd_ten, bcd_hundred, bcd_thousand : in std_logic_vector(3 downto 0);
      bcd_ten_thousand, bcd_hundred_thousand : in std_logic_vector(3 downto 0);
      bcd_million, bcd_ten_million : in std_logic_vector(3 downto 0);
      lat_unit, lat_ten, lat_hundred, lat_thousand : out std_logic_vector(3 downto 0);
      lat_ten_thousand, lat_hundred_thousand : out std_logic_vector(3 downto 0);
      lat_million, lat_ten_million : out std_logic_vector(3 downto 0)
    );
  end component;

  component display_main
    generic(
      scan_cycles : integer := 9999
    );
    port(
      clock : in std_logic;
      reset : in std_logic;
      lat_unit, lat_ten, lat_hundred, lat_thousand : in std_logic_vector(3 downto 0);
      lat_ten_thousand, lat_hundred_thousand : in std_logic_vector(3 downto 0);
      lat_million, lat_ten_million : in std_logic_vector(3 downto 0);
      SEG : out std_logic_vector(7 downto 0);
      AN : out std_logic_vector(7 downto 0)
    );
  end component;

  signal gate, latch, clear, clock_1hz : std_logic;
  signal counter_reset : std_logic;

  signal bcd_unit, bcd_ten, bcd_hundred, bcd_thousand : std_logic_vector(3 downto 0);
  signal bcd_ten_thousand, bcd_hundred_thousand : std_logic_vector(3 downto 0);
  signal bcd_million, bcd_ten_million : std_logic_vector(3 downto 0);

  signal lat_unit, lat_ten, lat_hundred, lat_thousand : std_logic_vector(3 downto 0);
  signal lat_ten_thousand, lat_hundred_thousand : std_logic_vector(3 downto 0);
  signal lat_million, lat_ten_million : std_logic_vector(3 downto 0);


begin

  window_inst : meas_window
    generic map(window_cycles => window_cycles)
    port map(
      clock_100mhz => clk100mhz,
      reset        => reset,
      meas_window  => gate,
      latch        => latch,
      clear        => clear,
      clock_1hz    => clock_1hz
    );

  counter_reset <= reset or clear;

  counter_inst : bcd_counter
    port map(
      freqin               => freqin,
      bcd_unit             => bcd_unit,
      bcd_ten              => bcd_ten,
      bcd_hundred          => bcd_hundred,
      bcd_thousand         => bcd_thousand,
      bcd_ten_thousand     => bcd_ten_thousand,
      bcd_hundred_thousand => bcd_hundred_thousand,
      bcd_million          => bcd_million,
      bcd_ten_million      => bcd_ten_million,
      meas_window          => gate,
      reset                => counter_reset
    );

  latch_inst : latch_main
    port map(
      latch                  => latch,
      bcd_unit               => bcd_unit,
      bcd_ten                => bcd_ten,
      bcd_hundred            => bcd_hundred,
      bcd_thousand           => bcd_thousand,
      bcd_ten_thousand       => bcd_ten_thousand,
      bcd_hundred_thousand   => bcd_hundred_thousand,
      bcd_million            => bcd_million,
      bcd_ten_million        => bcd_ten_million,
      lat_unit               => lat_unit,
      lat_ten                => lat_ten,
      lat_hundred            => lat_hundred,
      lat_thousand           => lat_thousand,
      lat_ten_thousand       => lat_ten_thousand,
      lat_hundred_thousand   => lat_hundred_thousand,
      lat_million            => lat_million,
      lat_ten_million        => lat_ten_million
    );

  display_inst : display_main
    generic map(scan_cycles => scan_cycles)
    port map(
      clock                  => clk100mhz,
      reset                  => reset,
      lat_unit               => lat_unit,
      lat_ten                => lat_ten,
      lat_hundred            => lat_hundred,
      lat_thousand           => lat_thousand,
      lat_ten_thousand       => lat_ten_thousand,
      lat_hundred_thousand   => lat_hundred_thousand,
      lat_million            => lat_million,
      lat_ten_million        => lat_ten_million,
      SEG                    => SEG,
      AN                     => AN
    );

end Behavioral;
