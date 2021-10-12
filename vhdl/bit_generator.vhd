library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bit_generator is
    Port ( clk : in STD_LOGIC;
           tx : out STD_LOGIC);
end bit_generator;

architecture Behavioral of bit_generator is
  signal counter     : unsigned(27 downto 0) := (others => '0');
  signal rate        : unsigned(27 downto 0) := to_unsigned(9600,      28);
  signal clock_speed : unsigned(27 downto 0) := to_unsigned(84000000, 28);
  signal tx_bit      : std_logic := '0';
  signal lfsr        : std_logic_vector(6 downto 0) := (others => '1');
begin

  tx <= tx_bit;
  
process(clk) 
    begin
        if rising_edge(clk) then
            tx_bit <= lfsr(0);
            if counter >= clock_speed-rate then
                counter <= counter + rate - clock_speed;
                lfsr <= (lfsr(0) XOR lfsr(1)) & lfsr(lfsr'high downto 1);                
            else
                counter <= counter + rate;
            end if;
        end if;
    end process;
end Behavioral;
