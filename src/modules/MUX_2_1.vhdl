library ieee;
use ieee.std_logic_1164.all;

entity MUX2_1 is
port (
	A, B: in std_logic_vector(15 downto 0);
	SEL: in std_logic;
	R: out std_logic_vector(15 downto 0)
);
end entity MUX2_1;

architecture rtl of MUX2_1 is begin
	
	with SEL select
		R <= A when '0',
		  	 B when '1',
		  	 (others => 'X') when others;

end architecture rtl;