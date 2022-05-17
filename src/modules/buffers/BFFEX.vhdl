library ieee;
use ieee.std_logic_1164.all;

entity BFFEX is
port(
	CLK: in std_logic;
	ISRC_ALU, ISRC_ACC, ILOAD_ACC, ISRC_WB, IWB_GPR: in std_logic;
	IALU_OP: in std_logic_vector(3 downto 0);
	OSRC_ALU, OSRC_ACC, OLOAD_ACC, OSRC_WB, OWB_GPR: out std_logic;
	OALU_OP: out std_logic_vector(3 downto 0)
);
end entity;

architecture behavior of BFFEX is begin

	process begin
		wait until CLK'event and CLK='1';
		OSRC_ALU	<=ISRC_ALU;
		OSRC_ACC	<=ISRC_ACC;
		OLOAD_ACC	<=ILOAD_ACC;
		OSRC_WB		<=ISRC_WB;
		OWB_GPR		<=IWB_GPR;
		OALU_OP		<=IALU_OP;
	end process;

end architecture;
