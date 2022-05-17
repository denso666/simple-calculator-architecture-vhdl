library ieee;
use ieee.std_logic_1164.all;

entity BFF3 is
port(
	CLK: in std_logic;
	ID, IRES: in std_logic_vector(15 downto 0);
	IC: in std_logic_vector(2 downto 0);
	OD, ORES: out std_logic_vector(15 downto 0);
	OC: out std_logic_vector(2 downto 0)
);
end entity;

architecture behavior of BFF3 is begin

	process begin
		wait until CLK'event and CLK='1';
		OC <= IC;
		OD <= ID;
		ORES <= IRES;
	end process;

end architecture;