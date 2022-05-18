library ieee;
use ieee.std_logic_1164.all;

entity DATAPATH is port ( CLK: in std_logic ); end entity;
architecture behavior of DATAPATH is
----------------------------------------
--				COMPONENTS
----------------------------------------

	----------------------------------------
	--				FETCH
	component PC_4b is port (
		CLK: in std_logic;
		Q: out std_logic_vector(3 downto 0)
	); end component;

	component MEM_INS is port (
		ADDR: in std_logic_vector(3 downto 0);
		DOUT: out std_logic_vector(15 downto 0)
	); end component;

	signal PC_TO_MEM: std_logic_vector(3 downto 0);
	signal MEM_TO_BFF: std_logic_vector(15 downto 0);

	----------------------------------------
	--				DATA
	component BFF1 is port (
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

	signal TOTAL_INS: std_logic_vector(15 downto 0);
	signal SRC_ALU_1, SRC_ACC_1, LOAD_ACC_1, SRC_WB_1, WB_GPR_1: std_logic;
	signal ALU_OP_1: std_logic_vector(3 downto 0);
	signal RR1, RR2, SIGN_EXT_1: std_logic_vector(15 downto 0);

	----------------------------------------
	--				EXECUTION
	component BFF2 is port (
		CLK: in std_logic;
		IA, IB, ID: in std_logic_vector(15 downto 0);
		IC: in std_logic_vector(2 downto 0);
		OA, OB, OD: out std_logic_vector(15 downto 0);
		OC: out std_logic_vector(2 downto 0)
	); end component;

	component BFFEX is port (
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
		A, B: 	in std_logic_vector(15 downto 0);
		SEL:  	in std_logic_vector(3 downto 0);
		R:		out std_logic_vector(15 downto 0)
	); end component;

	signal OA, OB, OD: std_logic_vector(15 downto 0);
	signal OC: std_logic_vector(2 downto 0);
	signal SRC_ALU_2, SRC_ACC_2, LOAD_ACC_2, SRC_WB_2, WB_GPR_2: std_logic;
	signal ALU_OP_2: std_logic_vector(3 downto 0);
	signal ALU_SRC_SIG, ALU_RES: std_logic_vector(15 downto 0);

	----------------------------------------
	--				LOAD AND WRITE BACK
	component BFF3 is port (
		CLK: in std_logic;
		ID, IRES: in std_logic_vector(15 downto 0);
		IC: in std_logic_vector(2 downto 0);
		OD, ORES: out std_logic_vector(15 downto 0);
		OC: out std_logic_vector(2 downto 0)
	); end component;

	component BFFWB is port (
		CLK: in std_logic;
		ISRC_ACC, ILOAD_ACC, ISRC_WB, IWB_GPR: in std_logic;
		OSRC_ACC, OLOAD_ACC, OSRC_WB, OWB_GPR: out std_logic
	); end component;

	component ACCUMULATOR is port (
		DIN: in std_logic_vector(15 downto 0);
		LOAD: in std_logic;
		DOUT: out std_logic_vector(15 downto 0)
	); end component;

	signal OD_2: std_logic_vector(15 downto 0);
	signal OC_2: std_logic_vector(2 downto 0);
	signal ORES: std_logic_vector(15 downto 0);
	signal SRC_ALU_3, SRC_ACC_3, LOAD_ACC_3, SRC_WB_3, WB_GPR_3: std_logic;
	signal MUX_ACC, OUT_ACC, OUT_WB_D: std_logic_vector(15 downto 0);

begin
	
	----------------------------------------
	--			FETCH
	u_pc: PC_4b port map (
		CLK =>CLK,
		Q 	=>PC_TO_MEM
	);

	u_mem_ins: MEM_INS port map (
		ADDR =>PC_TO_MEM,
		DOUT =>MEM_TO_BFF
	);

	----------------------------------------
	--				DATA
	u_bff1: BFF1 port map (
		CLK =>CLK,
		IA 	=>MEM_TO_BFF,
		OA 	=>TOTAL_INS
	);

	u_c_u: CONTROL_U port map (
		OP 			=>TOTAL_INS(15 downto 11),
		SRC_ALU 	=>SRC_ALU_1,
		SRC_ACC 	=>SRC_ACC_1,
		LOAD_ACC 	=>LOAD_ACC_1,
		SRC_WB 		=>SRC_WB_1,
		WB_GPR 		=>WB_GPR_1,
		ALU_OP 		=>ALU_OP_1
	);

	u_mem_reg: MEM_REG port map (
		AR1		=>TOTAL_INS(10 downto 8),
		AR2		=>TOTAL_INS(7 downto 5),
		ADDR_W	=>OC_2,
		WE		=>WB_GPR_3,
		DIN		=>OUT_WB_D,
		DR1		=>RR1,
		DR2		=>RR2
	);

	u_sign_ext: SIGN_EXT port map (
		DIN		=>TOTAL_INS(7 downto 0),
		DOUT	=>SIGN_EXT_1
	);

	----------------------------------------
	--				EXECUTION
	u_bff2: BFF2 port map (
		CLK	=>CLK,
		IA 	=>RR1,
		IB 	=>RR2,
		IC 	=>TOTAL_INS(10 downto 8),
		ID 	=>SIGN_EXT_1,
		OA 	=>OA,
		OB 	=>OB,
		OC 	=>OC,
		OD 	=>OD
	);

	u_bffex: BFFEX port map (
		CLK			=>CLK,
		ISRC_ALU	=>SRC_ALU_1,
		ISRC_ACC	=>SRC_ACC_1,
		ILOAD_ACC	=>LOAD_ACC_1,
		ISRC_WB		=>SRC_WB_1,
		IWB_GPR		=>WB_GPR_1,
		IALU_OP		=>ALU_OP_1,
		OSRC_ALU	=>SRC_ALU_2,
		OSRC_ACC	=>SRC_ACC_2,
		OLOAD_ACC	=>LOAD_ACC_2,
		OSRC_WB		=>SRC_WB_2,
		OWB_GPR		=>WB_GPR_2,
		OALU_OP		=>ALU_OP_2
	);

	u_mux_1: MUX2_1 port map (
		A 	=>OB,
		B 	=>OD,
		SEL =>SRC_ALU_2,
		R 	=>ALU_SRC_SIG
	);

	u_alu: ALU port map (
		A 	=>OA,
		B 	=>ALU_SRC_SIG,
		SEL =>ALU_OP_2,
		R 	=>ALU_RES
	);

	----------------------------------------
	--				LOAD AND WRITE BACK
	u_bff3: BFF3 port map (
		CLK		=>CLK,
		ID 		=>OD,
		IRES 	=>ALU_RES,
		IC 		=>OC,
		OD 		=>OD_2,
		ORES 	=>ORES,
		OC 		=>OC_2
	);

	u_bffwb: BFFWB port map (
		CLK			=>CLK,
		ISRC_ACC	=>SRC_ACC_2,
		ILOAD_ACC	=>LOAD_ACC_2,
		ISRC_WB		=>SRC_WB_2,
		IWB_GPR		=>WB_GPR_2,
		OSRC_ACC	=>SRC_ACC_3,
		OLOAD_ACC	=>LOAD_ACC_3,
		OSRC_WB		=>SRC_WB_3,
		OWB_GPR		=>WB_GPR_3
	);

	u_mux_2: MUX2_1 port map (
		A 	=>ORES,
		B 	=>OD_2,
		SEL =>SRC_ACC_3,
		R 	=>MUX_ACC
	);

	u_acc: ACCUMULATOR port map (
		DIN 	=>MUX_ACC,
		LOAD 	=>LOAD_ACC_3,
		DOUT 	=>OUT_ACC
	);

	u_mux_3: MUX2_1 port map (
		A 	=>OD_2,
		B 	=>OUT_ACC,
		SEL =>SRC_WB_3,
		R 	=>OUT_WB_D
	);

end architecture;