library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider_1hz_tb is
--  Port ( );
end clock_divider_1hz_tb;

architecture Behavioral of clock_divider_1hz_tb is
  component clock_divider_1hz is
      generic (
        CLOCK_LIMIT: integer := 62500000
        );
      Port ( clk_in : in STD_LOGIC;
             rst : in STD_LOGIC;
             clk_out : out STD_LOGIC);
  end component;
  
  signal clk_in_tb: std_logic;
  signal rst_tb: std_logic;
  signal clk_out_tb: std_logic;
  
  constant cp: time := 8 ns;

begin
  
  UUT_CLK_DIV: clock_divider_1hz port map (clk_in => clk_in_tb, rst => rst_tb, clk_out => clk_out_tb);
  
  process
  begin
    clk_in_tb <= '1';
    wait for cp/2;
    clk_in_tb <= '0';
    wait for cp/2;
  end process;
  
  process
  begin
    rst_tb <= '1';
    wait for cp;
    rst_tb <= '0';
    wait;
  end process;
    

end Behavioral;
