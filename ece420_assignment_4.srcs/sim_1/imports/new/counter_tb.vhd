library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_tb is
--  Port ( );
end counter_tb;

architecture Behavioral of counter_tb is

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
  
  constant cp: time := 10 ns;
  signal clk_tb: std_logic := '0';
  signal rst_tb: std_logic := '0';
  signal sr_ring_counter_tb: std_logic_vector(3 downto 0) := "1000";
  signal sl_ring_counter_tb: std_logic_vector(3 downto 0) := "0001";
  signal binary_counter_tb: std_logic_vector(3 downto 0) := (others => '0');
  signal johnson_counter_tb: std_logic_vector(3 downto 0) := (others => '0');
  
begin

  UUT_SR_RING_COUNTER: shift_right_ring_counter port map(clk => clk_tb, rst => rst_tb, counter => sr_ring_counter_tb);
  UUT_SL_RING_COUNTER: shift_left_ring_counter port map(clk => clk_tb, rst => rst_tb, counter => sl_ring_counter_tb);
  UUT_BINARY_COUNTER: binary_counter port map(clk => clk_tb, rst => rst_tb, counter => binary_counter_tb);
  UUT_JOHNSON_COUNTER: johnson_counter port map(clk => clk_tb, rst => rst_tb, counter => johnson_counter_tb);
  
  process
  begin
    clk_tb <= '1';
    wait for cp/2;
    clk_tb <= '0';
    wait for cp/2;
  end process;
  
  process
  begin
    rst_tb <= '1';
    wait for 10 ns;
    rst_tb <= '0';
    wait;
  end process;

end Behavioral;
