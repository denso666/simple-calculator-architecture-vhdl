library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU is
port (
	A, B: 	in std_logic_vector(15 downto 0);
	SEL:  	in std_logic_vector(3 downto 0);
	R:		out std_logic_vector(15 downto 0)
);
end entity ALU;

architecture behavior of ALU is begin

	process ( A, B, SEL ) begin
		case ( SEL ) is
			when x"0" => R <= A;
			when x"1" => R <= std_logic_vector(resize(signed(A) + signed(B), 16));
			when x"2" => R <= std_logic_vector(resize(signed(A) - signed(B), 16));
			when x"3" => R <= std_logic_vector(resize(signed(A) * signed(B), 16));
			when x"4" => R <= std_logic_vector(resize(signed(A) / signed(B), 16));
			when x"5" => R <= std_logic_vector(resize(signed(A) * signed(A), 16));
			when x"6" => R <= A and B;
			when x"7" => R <= A or B;
			when x"8" => R <= not A;
			when others => R <= (others=>'X');
		end case;
	end process;

	--with SEL select
	--	R <=A 		when "0000",
	--		A + B 	when "0001",
	--		A - B   when "0010",
	--	    A * B 	when "0011",
	--	    --A / B  	when x"4",
	--	    A * A 	when "0101",
	--	    A and B when "0110",
	--	    A or B 	when "0111",
	--	    not B 	when "1000",
	--	    (others => 'X')	when others;

end architecture behavior;