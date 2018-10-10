--
-- VHDL Architecture training_lib.circuit_ch2_3b.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 11:01:58 21.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity circuit_ch2_3b is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch2_3b;

--
architecture rtl of circuit_ch2_3b is
  signal buttons_q0,buttons_q1,buttons_q2,buttons_q3: std_logic_vector(buttons'range);
  signal sliders_q0,sliders_q1,sliders_q2: std_logic_vector(sliders'range);
  signal buttons_rising_stb: std_logic_vector(buttons'range);
  signal timer: std_logic_vector(27 downto 0):= (others => '0'); -- init to zero for simulation
  signal timer_tc: std_logic; --terminal count for timer
  signal shreg: std_logic_vector(3 downto 0):= (others => '0'); -- shift register; init to zero for simulation
begin
  --timer to generate a 1ms strobe for debouncing--
  process(clk)
  begin
    if rising_edge(clk) then
        if timer_tc = '1' then
           timer <= (others => '0');
         else
           timer <= timer+1;
        end if;
      end if;
  end process;

-- compute the terminal count signal for the timer         
   timer_tc <= '1' when timer = 125000-1 else '0'; -- no fulladder inferred
                                                   -- 125000-1 is computed at compile time

-- shift registers for all button and slider signals 
  process(clk)
  begin
    if rising_edge(clk) then
      -- synchronize and debounce button signals
      buttons_q0 <= buttons;
      buttons_q1 <= buttons_q0;
      if timer_tc = '1' then
         buttons_q2 <= buttons_q1;  --sampling to debounce
      end if;
      buttons_q3 <= buttons_q2;
      -- synchronize slider signals
      sliders_q0 <= sliders;
      sliders_q1 <= sliders_q0;
      sliders_q2 <= sliders_q1;
    end if;
  end process;

-- logic conditions for rising edges 
-- to generate 1-cycle active high strobe signals   
  buttons_rising_stb  <= buttons_q2 and not buttons_q3;
 
--synchronous counter with active high reset--
--buttons_q2 is the synchronized and deounced signal
--buttons_q3 is just needed for edge detection after the debounce flipflop

  process(clk)
  begin
    if rising_edge(clk) then
      if buttons_q2(0) = '1' then  ---synchronized signal button BT0
        shreg <= (others => '0');
      elsif buttons_rising_stb(1) = '1' then
        shreg <= sliders_q2;
      elsif buttons_rising_stb(2) = '1' then  --BTN2 --> shift right
        shreg <= shreg(0) & shreg(shreg'left downto 1); -- shift in '0'
      elsif buttons_rising_stb(3) = '1' then  --BTN3 --> shift left
        shreg <= shreg(shreg'left-1 downto 0) & shreg(shreg'left);
      end if;
    end if;
  end process;
 
  leds <= shreg;
  
end architecture rtl;

