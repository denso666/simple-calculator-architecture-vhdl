library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PC_4b is
port (
	CLK: in std_logic;
	Q: out std_logic_vector(3 downto 0)
);
end entity;

architecture behavior of PC_4b is
signal reg: std_logic_vector(3 downto 0) := "0000";
begin

	process ( CLK ) begin
		if ( rising_edge( CLK ) ) then reg <= reg + 1; end if;
	end process;

	Q <= reg;

end architecture behavior;