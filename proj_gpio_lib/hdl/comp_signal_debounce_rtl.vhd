--
-- VHDL Architecture training_lib.comp_signal_synchr.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 19:48:41 21.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_signal_synchr is
   generic( 
      simulation_g : boolean := false
   );
   port( 
      buttons      : in     std_logic_vector (3 downto 0);
      sliders      : in     std_logic_vector (3 downto 0);
      encoder0     : in     std_logic_vector (1 downto 0);
      encoder1     : in     std_logic_vector (1 downto 0);
      buttons_s    : out    std_logic_vector (3 downto 0);
      sliders_s    : out    std_logic_vector (3 downto 0);
      encoder0_s   : out    std_logic_vector (1 downto 0);
      encoder1_s   : out    std_logic_vector (1 downto 0);
      buttons_stb  : out    std_logic_vector (3 downto 0);
      sliders_stb  : out    std_logic_vector (3 downto 0);
      encoder0_stb : out    std_logic_vector (1 downto 0);
      encoder1_stb : out    std_logic_vector (1 downto 0);
      clk          : in     std_logic
   );

-- Declarations

end comp_signal_synchr ;

--
architecture rtl of comp_signal_synchr is
  signal signal_vec: std_logic_vector(11 downto 0);
  signal signal_vec_q0,signal_vec_q1,signal_vec_q2,signal_vec_q3: std_logic_vector(signal_vec'range);
  signal signal_vec_stb,signal_vec_stbn: std_logic_vector(signal_vec'range);
  signal timer_debounce: std_logic_vector(27 downto 0):= (others => '0'); -- init to zero for simulation
  signal timer_debounce_tc: std_logic; --terminal count for timer
 
begin
  --timer to generate a 1ms strobe for debouncing--
  process(clk)
  begin
    if rising_edge(clk) then
        if timer_debounce_tc = '1' then
           timer_debounce <= (others => '0');
         else
           timer_debounce <= timer_debounce+1;
        end if;
      end if;
  end process;

-- compute the terminal count signal for the timer  
  g0: if not simulation_g generate       
  timer_debounce_tc <= '1' when timer_debounce = 125000-1 else '0'; -- no fulladder inferred
  end generate g0;

  g1: if simulation_g generate       
  timer_debounce_tc <= '1' when timer_debounce = 100-1 else '0'; -- no fulladder inferred
  end generate g1;
                                                     -- 125000-1 is computed at compile time
  --create a signal vector from all input signals
  signal_vec <= buttons & sliders & encoder0 & encoder1;
  
  process(clk)
  begin
    if rising_edge(clk) then
       signal_vec_q0 <= signal_vec;
       signal_vec_q1 <= signal_vec_q0;
       if timer_debounce_tc = '1' then
          signal_vec_q2 <= signal_vec_q1;
       end if;
       signal_vec_q3 <= signal_vec_q2;
    end if;
  end process;
  
  -- create strobes on rising edges       
  signal_vec_stb  <= signal_vec_q2 and not signal_vec_q3;
  signal_vec_stbn <= not signal_vec_q2 and signal_vec_q3;
  
  -- slice signal vectors-----
  buttons_s  <= signal_vec_q3(11 downto 8);
  sliders_s  <= signal_vec_q3( 7 downto 4);
  encoder0_s <= signal_vec_q3( 3 downto 2);
  encoder1_s <= signal_vec_q3( 1 downto 0);

  buttons_stb  <= signal_vec_stb(11 downto 8);
  sliders_stb  <= signal_vec_stb( 7 downto 4);
  encoder0_stb <= signal_vec_stbn( 3 downto 2);
  encoder1_stb <= signal_vec_stbn( 1 downto 0);
  
           
end architecture rtl;

