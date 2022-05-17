library ieee;
use ieee.std_logic_1164.all;

entity BFF2 is
port(
	CLK: in std_logic;
	IA, IB, ID: in std_logic_vector(15 downto 0);
	IC: in std_logic_vector(2 downto 0);
	OA, OB, OD: out std_logic_vector(15 downto 0);
	OC: out std_logic_vector(2 downto 0)
);
end entity;

architecture behavior of BFF2 is begin

	process begin
		wait until CLK'event and CLK='1';
		OA <= IA;
		OB <= IB;
		OC <= IC;
		OD <= ID;
	end process;

end architecture;