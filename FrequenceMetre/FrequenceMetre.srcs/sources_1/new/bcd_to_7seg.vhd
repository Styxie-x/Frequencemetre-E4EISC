library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_to_7seg is
--  Port ( );
    port(
    B : in std_logic_vector(3 downto 0);
    O : out std_logic_vector(6 downto 0)
    );
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is
begin
with B select
           O <= "0000001" when "0000" ,--0
                "1001111" when "0001" ,--1
                "0010010" when "0010" ,--2
                "0000110" when "0011" ,--3
                "1001100" when "0100" ,--4
                "0100100" when "0101" ,--5
                "0100000" when "0110" ,--6
                "0001111" when "0111" ,--7
                "0000000" when "1000" ,--8
                "0000100" when "1001" ,--9
                "0001000" when "1010" ,--A
                "0000000" when "1011" ,--B "1100000" for lower case b 
                "0110001" when "1100" ,--C
                "0000001" when "1101" ,--D "1000010" for lower case d
                "0110000" when "1110" ,--E
                "0111000" when "1111" ,--F
                "1111111" when others; -- All OFF
end Behavioral;
