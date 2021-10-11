library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;


entity binary_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
end binary_counter;

architecture Behavioral of binary_counter is
  signal b_counter : std_logic_vector(3 downto 0);

begin

process(clk, rst)
begin
 
 if rst = '1' then
    b_counter <= "0000";
 elsif rising_edge(clk) then
      b_counter <= b_counter + 1;
 end if;
 
end process;

  counter <= b_counter;
  
end Behavioral;
