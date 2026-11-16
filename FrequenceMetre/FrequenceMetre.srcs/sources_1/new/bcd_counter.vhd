library ieee;
use ieee.std_logic_1164.all;

entity bcd_counter is
    port(
        freqin : in std_logic;
        bcd_unit, bcd_ten, bcd_hundred, bcd_thousand, bcd_ten_thousand, bcd_hundred_thousand, bcd_million, bcd_ten_million : out std_logic_vector(3 downto 0);
        meas_window : in std_logic; --1 second
        reset : in std_logic
        );
end bcd_counter;

architecture Behavioral of bcd_counter is
    signal carry_unit, carry_ten, carry_hundred, carry_thousand, carry_ten_thousand, carry_hundred_thousand, carry_million, carry_ten_million : std_logic;    
    component bcd0to9_counter
        port(
            clk    : in  std_logic;
            reset  : in  std_logic;
            enable : in  std_logic;
            carry  : out std_logic;
            bcd4   : out std_logic_vector(3 downto 0)
        );
    end component;
    begin    
        bcd_count_unit             : bcd0to9_counter port map (freqin, reset, meas_window, carry_unit, bcd_unit);
        bcd_count_ten              : bcd0to9_counter port map (freqin, reset, carry_unit, carry_ten, bcd_ten);
        bcd_count_hundred          : bcd0to9_counter port map (freqin, reset, carry_ten, carry_hundred, bcd_hundred);
        bcd_count_thousand         : bcd0to9_counter port map (freqin, reset, carry_hundred, carry_thousand, bcd_thousand);
        bcd_count_ten_thousand     : bcd0to9_counter port map (freqin, reset, carry_thousand, carry_ten_thousand, bcd_ten_thousand);
        bcd_count_hundred_thousand : bcd0to9_counter port map (freqin, reset, carry_ten_thousand, carry_hundred_thousand, bcd_hundred_thousand);
        bcd_count_million          : bcd0to9_counter port map (freqin, reset, carry_hundred_thousand, carry_million, bcd_million);
        bcd_count_ten_million      : bcd0to9_counter port map (freqin, reset, carry_million, carry_ten_million, bcd_ten_million);
end Behavioral;   

