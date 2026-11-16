library IEEE;
use IEEE.std_logic_1164.all;


entity data_latch is
    port(
    data_in : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0);
    latch : in std_logic
    );
end data_latch;

architecture Behavioral of data_latch is
    signal Q1, Q2 : std_logic;
begin
    process (latch)
        begin
        if(rising_edge(latch)) then
            data_out <= data_in;
        end if;
    end process;
end Behavioral;