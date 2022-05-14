library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;

entity ALU is
port (
	A, B: 	in std_logic_vector(7 downto 0);
	SEL:  	in std_logic_vector(3 downto 0);
	R:		out std_logic_vector(7 downto 0)
);
end entity ALU;

architecture behavior of ALU is begin
	
	with SEL select
		R <=A 		when x"0",
			A + B 	when x"1",
			A - B   when x"2",
		    A * B 	when x"3",
		    --A / B  	when x"4",
		    A * A 	when x"6",
		    A and B when x"7",
		    A or B 	when x"8",
		    not B 	when x"9",
		    (others => 'X')	when others;

end architecture behavior;