library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shift_right_ring_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
end shift_right_ring_counter;

architecture Behavioral of shift_right_ring_counter is
  signal sr_counter : std_logic_vector(3 downto 0);

begin

process(clk, rst)
begin
 
 if rst = '1' then
    sr_counter <= "1000";
 elsif rising_edge(clk) then
    if sr_counter = "0001" then
      sr_counter <= "1000";
    else
      sr_counter <= '0' & sr_counter(3 downto 1);
    end if;
 end if;
 
end process;

  counter <= sr_counter;
  
end Behavioral;
