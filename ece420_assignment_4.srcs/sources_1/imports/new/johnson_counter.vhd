library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity johnson_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
end johnson_counter;

architecture Behavioral of johnson_counter is
  signal j_counter : std_logic_vector(3 downto 0);

begin

process(clk, rst)
begin
 
 if rst = '1' then
    j_counter <= "0000";
 elsif rising_edge(clk) then
      j_counter <= (NOT j_counter(0)) & j_counter(3 downto 1);
 end if;
 
end process;

  counter <= j_counter;
  
end Behavioral;
