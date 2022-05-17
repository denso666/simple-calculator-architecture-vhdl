library ieee;
use ieee.std_logic_1164.all;

entity BFFWB is
port(
	CLK: in std_logic;
	ISRC_ACC, ILOAD_ACC, ISRC_WB, IWB_GPR: in std_logic;
	OSRC_ACC, OLOAD_ACC, OSRC_WB, OWB_GPR: out std_logic
);
end entity;

architecture behavior of BFFWB is begin

	process begin
		wait until CLK'event and CLK='1';
		OSRC_ACC	<=ISRC_ACC;
		OLOAD_ACC	<=ILOAD_ACC;
		OSRC_WB		<=ISRC_WB;
		OWB_GPR		<=IWB_GPR;
	end process;

end architecture;
