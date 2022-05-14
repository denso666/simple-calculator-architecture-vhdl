library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM_REG is
port (
	AR1, AR2, ADDR_W: in std_logic_vector(2 downto 0);
	WE: in std_logic;
	DIN: in std_logic_vector(15 downto 0);
	DR1, DR2: out std_logic_vector(15 downto 0)
);
end entity MEM_REG;

architecture behavior of MEM_REG is
	type mem is array(0 to 7) of std_logic_vector(15 downto 0);
	signal reg_block: mem;
begin
	
	process( AR1, AR2, WE ) begin
		if ( WE = '1' ) then
			reg_block( to_integer( unsigned( ADDR_W ) ) ) <= DIN;
		end if;

		DR1 <= reg_block( to_integer( unsigned( AR1 ) ) );
		DR2 <= reg_block( to_integer( unsigned( AR2 ) ) );
	end process;

end architecture behavior;