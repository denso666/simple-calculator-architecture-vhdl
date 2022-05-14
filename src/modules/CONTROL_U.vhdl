library ieee;
use ieee.std_logic_1164.all;

entity CONTROL_U is
port (
	OP: in std_logic_vector(4 downto 0);
	SRC_ALU, SRC_ACC, LOAD_ACC, SRC_WB, WB_GPR: out std_logic;
	ALU_OP: out std_logic_vector(3 downto 0)
);
end entity;

architecture behavior of CONTROL_U is begin

	decode: process( OP ) begin
		case OP(0) is
		--	COMMON OPERATIONS
			when '0' =>
				SRC_ALU		<= '0';
				SRC_ACC		<= '0';
				LOAD_ACC	<= '1';
				SRC_WB		<= 'X';
				WB_GPR		<= '0';
				ALU_OP		<= OP(4 downto 1);

		--	IMMEDIATE OPERATIONS
			when '1' =>
				SRC_ALU		<= '1';
				SRC_ACC		<= '0';
				LOAD_ACC	<= '1';
				SRC_WB		<= 'X';
				WB_GPR		<= '0';
				ALU_OP		<= OP(4 downto 1);
			
		--	UNKNOW OPERATIONS
			when others =>
				SRC_ALU		<= 'X';
				SRC_ACC		<= 'X';
				LOAD_ACC	<= 'X';
				SRC_WB		<= 'X';
				WB_GPR		<= 'X';
				ALU_OP		<= (others => 'X');
		end case;
	end process;

end architecture;