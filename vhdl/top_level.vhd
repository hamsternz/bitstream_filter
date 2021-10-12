library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity top_level is
    Port ( clk      : in STD_LOGIC;
           baseband : out STD_LOGIC_VECTOR (15 downto 0));
end top_level;

architecture Behavioral of top_level is
    component bit_generator is
    Port ( clk : in STD_LOGIC;
           tx : out STD_LOGIC);
    end component;
    signal data_bit : std_logic;
    
    component bpsk_modulator is
    Port ( clk      : in STD_LOGIC;
           tx       : in STD_LOGIC;
           baseband : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
           
begin

i_bit_gen : bit_generator PORT MAP (
    clk => clk,
    tx  => data_bit
    );

i_bpsk_modulator : bpsk_modulator PORT MAP (
        clk => clk,
        tx  => data_bit,
        baseband => baseband
    );
end Behavioral;
