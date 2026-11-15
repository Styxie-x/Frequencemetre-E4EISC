library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity display_mux is
    Port ( 
        Unit,Ten,Hundred,Thousand : in std_logic_vector(7 downto 0); -- io in, data to be muxed
        O : out std_logic_vector(7 downto 0); -- io out
        Sel : out std_logic_vector(3 downto 0); -- select display
        clk : in std_logic -- for counter for display refresh rate
    );
end display_mux;

architecture Behavioral of display_mux is
    signal display_clk : std_logic;
    signal number : integer range 0 to 4 := 0;
    signal counter : integer range 0 to 9999 := 9998;
begin
    process(clk) begin
        if(rising_edge(clk) and counter < 9999) then
            display_clk <= '0';
            counter <= counter + 1;   
        elsif (rising_edge(clk) and counter >= 9999) then
            display_clk <= '1';
            counter <= 0;
        end if;
    end process;
    
    process(display_clk) begin
        if(rising_edge(display_clk) and number = 0) then
            O <= Unit;
            Sel <= "0001";
            number <= 1;
         elsif (rising_edge(display_clk) and number = 1) then
            O <= Ten;
            Sel <= "0010";
            number <= 2;
         elsif (rising_edge(display_clk) and number = 2) then
            O <= Hundred;
            Sel <= "0100";
            number <= 3;
         elsif (rising_edge(display_clk) and number = 3) then
            O <= Thousand;
            Sel <= "1000";
            number <= 0;
         end if;
    end process;
end Behavioral;

