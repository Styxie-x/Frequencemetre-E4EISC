
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
    my_freq : in interger;
    N : out integer);
end freq_sel;

architecture Behavioral of freq_sel is

begin
    N<=interger(100000000/my_freq);

end Behavioral;
