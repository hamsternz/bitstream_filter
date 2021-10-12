library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_level is
end tb_top_level;

architecture Behavioral of tb_top_level is
    component top_level is
    Port ( clk : in STD_LOGIC;
           baseband : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
    signal clk      : STD_LOGIC := '0';
    signal baseband : STD_LOGIC_VECTOR (15 downto 0);

begin
process 
    begin
        wait for 5.95 ns;
        clk <= '1';
        wait for 5.95 ns;
        clk <= '0';
    end process;
uut: top_level port map (
       clk      => clk,
       baseband => baseband
    );

end Behavioral;
