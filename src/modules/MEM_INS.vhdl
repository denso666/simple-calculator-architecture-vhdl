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

	function init return mem is
		variable temp: mem;
	begin
    	temp(0) := x"0000";
		temp(1) := x"1020";
		temp(2) := x"2260";
		temp(3) := x"3340";
		temp(4) := x"5700";
		return temp;
	end function;

	signal mem_block: mem := init;
begin
	
	DOUT <= mem_block( to_integer( unsigned( ADDR ) ) );
	
end architecture behavior;