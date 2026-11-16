library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity clk_div is
    port(
        clock : in std_logic;
        N : in integer;
        O : out std_logic
    );
end clk_div;

architecture Behavioral of clk_div is
    signal n : integer :=0;
begin
process(clock)
begin
    if rising_edge(clock) then
        n <= n + 1;
        if n = N then
            O <= '1';
        else
            O <= '0';
        end if;
    end if;
end process;
end Behavioral;
