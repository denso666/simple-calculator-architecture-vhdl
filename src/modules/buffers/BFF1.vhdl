library ieee;
use ieee.std_logic_1164.all;

entity BFF1 is
port(
	CLK: in std_logic;
	IA: in std_logic_vector(15 downto 0);
	OA: out std_logic_vector(15 downto 0)
);
end entity;

architecture behavior of BFF1 is begin

	process begin
		wait until CLK'event and CLK='1';
		OA <= IA;
	end process;

end architecture;