library ieee;
use ieee.std_logic_1164.all;

entity ACCUMULATOR is
port (
	DIN: in std_logic_vector(15 downto 0);
	LOAD: in std_logic;
	DOUT: out std_logic_vector(15 downto 0)
);
end entity ACCUMULATOR;

architecture behavior of ACCUMULATOR is
	signal reg: std_logic_vector(15 downto 0);
begin

	process ( DIN, LOAD ) begin
		if ( LOAD = '1' ) then reg <= DIN; end if;
		DOUT <= reg;
	end process;

end architecture behavior;