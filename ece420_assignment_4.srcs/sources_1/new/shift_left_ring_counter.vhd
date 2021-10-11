library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shift_left_ring_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
end shift_left_ring_counter;

architecture Behavioral of shift_left_ring_counter is
  signal sl_counter : std_logic_vector(3 downto 0);

begin

process(clk, rst)
begin
 
 if rst = '1' then
    sl_counter <= "0001";
 elsif rising_edge(clk) then
    if sl_counter = "1000" then
      sl_counter <= "0001";
    else
      sl_counter <= sl_counter(2 downto 0) & '0';
    end if;
 end if;
 
end process;

  counter <= sl_counter;
  
end Behavioral;
