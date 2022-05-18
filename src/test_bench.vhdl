library ieee;
use ieee.std_logic_1164.all;

entity test_bench is end entity;

architecture behavior of test_bench is
	component DATAPATH is port ( CLK: in std_logic ); end component;
	signal clk: std_logic := '0';
begin
	
	uut: DATAPATH port map ( CLK => clk );
	clk <= not clk after 25 ns;

	process begin
		wait for 200 ns;
	end process;

end architecture;