library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM_INS is
port (
	ADDR: in std_logic_vector(3 downto 0);
	DOUT: out std_logic_vector(15 downto 0)
);
end entity MEM_INS;

architecture behavior of MEM_INS is
	type mem is array(0 to 15) of std_logic_vector(15 downto 0);
	signal mem_block: mem;
begin
	
	process( ADDR ) begin
		DOUT <= mem_block( to_integer( unsigned( ADDR ) ) );
	end process;

end architecture behavior;