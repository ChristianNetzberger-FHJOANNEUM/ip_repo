--
-- VHDL Architecture training_lib.circuit_ch2_2f.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 20:54:46 20.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity circuit_ch2_2f is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch2_2f;

--
architecture rtl of circuit_ch2_2f is
  signal cnt: std_logic_vector(31 downto 0):= (others => '0'); -- init to zero for simulation
  signal sliders_q0,sliders_q1,sliders_q2: std_logic_vector(sliders'range);
  signal tc: std_logic;
begin

-- How many Flip Flops are inferred in this circuit? 
-- three stage shift registers for all slider signals 
  process(clk)
  begin
    if rising_edge(clk) then
      sliders_q0 <= sliders;
      sliders_q1 <= sliders_q0;
      sliders_q2 <= sliders_q1;
    end if;
  end process;
  
--synchronous counter with active high reset--
  process(clk)
  begin
    if rising_edge(clk) then
      if sliders_q2(0) = '1' then  ---synchronized signal slider SW0
        cnt <= (others => '0');
      elsif sliders_q2(1) = '1' then
        if tc = '1' then
           cnt <= (others => '0');
         else
           cnt <= cnt+1;
        end if;
      end if;
    end if;
  end process;

-- compute the terminal count signal for the counter         
  tc <= '1' when cnt = 124999999 else '0';

--registered LED output
-- drive LED0 high when counter is less than 10% of max. count  
  process(clk)
  begin
    if rising_edge(clk) then
      if cnt < 12500000 then
        leds(0) <= '1';
        leds(3) <= '0';
      else
        leds(0) <= '0';
        leds(3) <= '1';
      end if;
    end if;
  end process;
  
  leds(2 downto 1) <= (others => '0');

end architecture rtl;

