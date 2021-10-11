library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider is
    generic (
      CP_1HZ_LIMIT: integer := (125000000/2)-1;
      CP_8HZ_LIMIT: integer := (125000000/16)-1;
      CP_16HZ_LIMIT: integer := (125000000/32)-1
      );
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_1hz_out : out STD_LOGIC;
           clk_8hz_out : out STD_LOGIC;
           clk_16hz_out : out STD_LOGIC
           );
end clock_divider;

architecture Behavioral of clock_divider is
  signal counter_1hz: integer;
  signal counter_8hz: integer;
  signal counter_16hz: integer;
  signal clk_1hz: std_logic;
  signal clk_8hz: std_logic;
  signal clk_16hz: std_logic;
begin

process(clk_in, rst)
begin
  if rst = '1' then
    clk_1hz <= '1';
    clk_8hz <= '1';
    clk_16hz <= '1';
    counter_1hz <= 0;
    counter_8hz <= 0;
    counter_16hz <= 0;
 elsif rising_edge(clk_in) then
    if counter_1hz = (CP_1HZ_LIMIT) then
      counter_1hz <= 0;
      clk_1hz <= not clk_1hz;
    else
      counter_1hz <= counter_1hz + 1;
    end if;
    
    if counter_8hz = (CP_8HZ_LIMIT) then
      counter_8hz <= 0;
      clk_8hz <= not clk_8hz;
    else
      counter_8hz <= counter_8hz + 1;
    end if;

    if counter_16hz = (CP_16HZ_LIMIT) then
      counter_16hz <= 0;
      clk_16hz <= not clk_16hz;
    else
      counter_16hz <= counter_16hz + 1;
    end if;

 end if;
end process;

clk_1hz_out <= clk_1hz;
clk_8hz_out <= clk_8hz;
clk_16hz_out <= clk_16hz;

end Behavioral;
