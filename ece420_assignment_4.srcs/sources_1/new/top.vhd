library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( sysclk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (3 downto 0);
           btn: in STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is

  component clock_divider is
    generic (
      CP_1HZ_LIMIT: integer;
      CP_8HZ_LIMIT: integer;
      CP_16HZ_LIMIT: integer
      );
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_1hz_out : out STD_LOGIC;
           clk_8hz_out : out STD_LOGIC;
           clk_16hz_out : out STD_LOGIC
           );
  end component;

  component shift_right_ring_counter
      Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
  end component;
  
  component shift_left_ring_counter
      Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
  end component;
  
  component binary_counter
      Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
  end component;
  
  component johnson_counter
      Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal sr_counter: std_logic_vector(3 downto 0);
  signal sl_counter: std_logic_vector(3 downto 0);
  signal b_counter: std_logic_vector(3 downto 0);
  signal j_counter: std_logic_vector(3 downto 0);
  
  signal clk_1hz: std_logic;
  signal clk_8hz: std_logic;
  signal clk_16hz: std_logic;
  signal top_rst: std_logic;
  signal comp_clk: std_logic;
  signal out_counter: std_logic_vector(3 downto 0);
  
  constant SYS_CLK_FREQ: integer := 125000000; -- cycle/second
begin

 
  INST_CLK_DIV: clock_divider 
  generic map(
        CP_1HZ_LIMIT => (SYS_CLK_FREQ/2)-1,
        CP_8HZ_LIMIT => (SYS_CLK_FREQ/16)-1,
        CP_16HZ_LIMIT => (SYS_CLK_FREQ/32)-1
    )
  port map( 
      clk_in => sysclk, 
      rst => top_rst, 
      clk_1hz_out => clk_1hz,
      clk_8hz_out => clk_8hz,
      clk_16hz_out => clk_16hz
  );  
  
  INST_SR_COUNTER: shift_right_ring_counter port map(clk => comp_clk, rst => top_rst, counter => sr_counter);
  INST_SL_COUNTER: shift_left_ring_counter port map(clk => comp_clk, rst => top_rst, counter => sl_counter);
  INST_BINARY_COUNTER: binary_counter port map(clk => comp_clk, rst => top_rst, counter => b_counter);
  INST_JOHNSON_COUNTER: johnson_counter port map(clk => comp_clk, rst => top_rst, counter => j_counter);

  top_rst <= btn(0);

  comp_clk <= '0' when btn(1) = '1' else
              clk_8hz when btn(2) = '1' else
              clk_16hz when btn(3) = '1' else
              clk_1hz; 

  with sw select 
  out_counter <=
    sr_counter when "0001",
    sl_counter when "0010",
    b_counter  when "0100",
    j_counter  when "1000",
    "0000" when others;
    
 led <= out_counter;   

end Behavioral;
