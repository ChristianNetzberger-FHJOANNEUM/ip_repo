--
-- VHDL Architecture training_lib.circuit_ch2_2g.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 21:41:31 20.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity circuit_ch2_2g is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch2_2g;

--
architecture rtl of circuit_ch2_2g is
  signal buttons_q0,buttons_q1,buttons_q2: std_logic_vector(buttons'range);
  signal buttons_rising_stb: std_logic_vector(buttons'range);
  signal cnt: std_logic_vector(3 downto 0):= (others => '0'); -- init to zero for simulation
begin

-- How many Flip Flops are inferred in this circuit? 
-- three stage shift registers for all slider signals 
  process(clk)
  begin
    if rising_edge(clk) then
      buttons_q0 <= buttons;
      buttons_q1 <= buttons_q0;
      buttons_q2 <= buttons_q1;
    end if;
  end process;
  
 --logic conditions for rising, falling and any edges 
-- to generate 1-cycle active high strobe signals   
  buttons_rising_stb  <= buttons_q1 and not buttons_q2;
 
--synchronous counter with active high reset--
  process(clk)
  begin
    if rising_edge(clk) then
      if buttons_q2(2) = '1' then  ---synchronized signal slider SW0
        cnt <= (others => '0');
      elsif buttons_rising_stb(0) = '1' then
           cnt <= cnt+1;
      elsif buttons_rising_stb(1) = '1' then
           cnt <= cnt-1;
      end if;
    end if;
  end process;
 
  leds <= cnt;
end architecture rtl;

