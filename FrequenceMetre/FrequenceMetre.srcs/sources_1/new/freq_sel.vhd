
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_sel is
  Port (
    my_freq : in integer;
    N : out integer
  );
end freq_sel;

architecture Behavioral of freq_sel is
begin
    process(my_freq)
    begin
        if my_freq > 0 then
            N <= 100000000 / my_freq;
        else
            N <= 1;
        end if;
    end process;
end Behavioral;
