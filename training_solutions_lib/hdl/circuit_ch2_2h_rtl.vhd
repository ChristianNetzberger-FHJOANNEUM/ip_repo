--
-- VHDL Architecture training_lib.circuit_ch2_2h.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 22:06:08 20.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity circuit_ch2_2h is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch2_2h;

--
architecture rtl of circuit_ch2_2h is
  signal buttons_q0,buttons_q1,buttons_q2: std_logic_vector(buttons'range);
  signal sliders_q0,sliders_q1,sliders_q2: std_logic_vector(sliders'range);
  signal cnt: std_logic_vector(3 downto 0):= (others => '0'); -- init to zero for simulation
  signal timer: std_logic_vector(27 downto 0):= (others => '0'); -- init to zero for simulation
  signal tc: std_logic; --terminal count for timer
begin
  
--logic conditions for rising edges 
-- to generate 1-cycle active high strobe signals   
-- three stage shift registers for all button and slider signals 
  process(clk)
  begin
    if rising_edge(clk) then
      buttons_q0 <= buttons;
      buttons_q1 <= buttons_q0;
      buttons_q2 <= buttons_q1;
      sliders_q0 <= sliders;
      sliders_q1 <= sliders_q0;
      sliders_q2 <= sliders_q1;
    end if;
  end process;
  
--synchronous counter with active high reset--
  process(clk)
  begin
    if rising_edge(clk) then
        if tc = '1' then
           timer <= (others => '0');
         else
           timer <= timer+1;
        end if;
      end if;
  end process;

-- compute the terminal count signal for the counter         
   tc <= '1' when timer = 124999999 else '0';

--synchronous counter with active high reset--
  process(clk)
  begin
    if rising_edge(clk) then
      if buttons_q2(0) = '1' then  ---synchronized signal BT0
        cnt <= (others => '0');
      elsif sliders_q2(1) = '1' then
        if tc = '1' then
           if sliders_q2(2) = '0' then
             cnt <= cnt+1;
           else
             cnt <= cnt-1;
           end if;
        end if;
      end if;
    end if;
  end process;
  
--assign the counter value to the LEDs
   leds <= cnt;
      
end architecture rtl;

