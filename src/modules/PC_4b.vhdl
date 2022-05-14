library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PC_4b is
port (
	RSTN, CLK: in std_logic;
	Q: out std_logic_vector(3 downto 0)
);
end entity PC_4b;

architecture rtl of PC_4b is
signal reg: std_logic_vector(3 downto 0);
begin

	process ( CLK ) begin
		if ( RSTN = '0' ) 		  then reg <= "0000";  end if;
		if ( rising_edge( CLK ) ) then reg <= reg + 1; end if;
	end process;

	Q <= reg;

end architecture rtl;