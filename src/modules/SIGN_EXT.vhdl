library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SIGN_EXT is
port (
	DIN: in std_logic_vector(7 downto 0);
	DOUT: out std_logic_vector(15 downto 0)
);
end entity;

architecture behavior of SIGN_EXT is begin

	DOUT <= std_logic_vector( resize( unsigned( DIN ), 16 ) );

end architecture;