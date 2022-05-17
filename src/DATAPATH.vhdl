library ieee;
use ieee.std_logic_1164.all;

entity DATAPATH is
port ( CLK: in std_logic );
end entity;

architecture behavior of DATAPATH is
----------------------------------------
--				COMPONENTS
----------------------------------------

	----------------------------------------
	--				FETCH
	component PC_4b is port (
		RSTN, CLK: in std_logic;
		Q: out std_logic_vector(3 downto 0)
	); end component;

	component MEM_INS is port (
		ADDR: in std_logic_vector(3 downto 0);
		DOUT: out std_logic_vector(15 downto 0)
	); end component;

	----------------------------------------
	--				DATA
	component BFF1 is port(
		CLK: in std_logic;
		IA: in std_logic_vector(15 downto 0);
		OA: out std_logic_vector(15 downto 0)
	); end component;

	component CONTROL_U is port (
		OP: in std_logic_vector(4 downto 0);
		SRC_ALU, SRC_ACC, LOAD_ACC, SRC_WB, WB_GPR: out std_logic;
		ALU_OP: out std_logic_vector(3 downto 0)
	); end component;

	component MEM_REG is port (
		AR1, AR2, ADDR_W: in std_logic_vector(2 downto 0);
		WE: in std_logic;
		DIN: in std_logic_vector(15 downto 0);
		DR1, DR2: out std_logic_vector(15 downto 0)
	); end component;

	component SIGN_EXT is port (
		DIN: in std_logic_vector(7 downto 0);
		DOUT: out std_logic_vector(15 downto 0)
	); end component;

	----------------------------------------
	--				EXECUTION
	component BFF2 is port(
		CLK: in std_logic;
		IA, IB, ID: in std_logic_vector(15 downto 0);
		IC: in std_logic_vector(2 downto 0);
		OA, OB, OD: out std_logic_vector(15 downto 0);
		OC: out std_logic_vector(2 downto 0)
	); end component;

	component BFFEX is port(
		CLK: in std_logic;
		ISRC_ALU, ISRC_ACC, ILOAD_ACC, ISRC_WB, IWB_GPR: in std_logic;
		IALU_OP: in std_logic_vector(3 downto 0);
		OSRC_ALU, OSRC_ACC, OLOAD_ACC, OSRC_WB, OWB_GPR: out std_logic;
		OALU_OP: out std_logic_vector(3 downto 0)
	); end component;

	component MUX2_1 is port (
		A, B: in std_logic_vector(15 downto 0);
		SEL: in std_logic;
		R: out std_logic_vector(15 downto 0)
	); end component;

	component ALU is port (
		A, B: in std_logic_vector(7 downto 0);
		SEL: in std_logic_vector(3 downto 0);
		R: out std_logic_vector(7 downto 0)
	); end component;

	----------------------------------------
	--				LOAD AND WRITE BACK
	component BFF3 is port(
		CLK: in std_logic;
		ID, IRES: in std_logic_vector(15 downto 0);
		IC: in std_logic_vector(2 downto 0);
		OD, ORES: out std_logic_vector(15 downto 0);
		OC: out std_logic_vector(2 downto 0)
	); end component;

	component BFFWB is port(
		CLK: in std_logic;
		ISRC_ACC, ILOAD_ACC, ISRC_WB, IWB_GPR: in std_logic;
		OSRC_ACC, OLOAD_ACC, OSRC_WB, OWB_GPR: out std_logic
	); end component;

	component ACCUMULATOR is port (
		DIN: in std_logic_vector(15 downto 0);
		LOAD: in std_logic;
		DOUT: out std_logic_vector(15 downto 0)
	); end component;

	signal 

begin




end architecture ; -- behavior