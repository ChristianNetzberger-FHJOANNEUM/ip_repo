--
-- VHDL Architecture training_lib.circuit_ch2_2e.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 20:42:40 20.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity circuit_ch2_2e is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch2_2e;

--
architecture rtl of circuit_ch2_2e is
  signal cnt: std_logic_vector(31 downto 0):= (others => '0'); -- init to zero for simulation
  signal sliders_q0,sliders_q1,sliders_q2: std_logic_vector(sliders'range);
  signal tc: std_logic;
  signal led_tmp: std_logic := '0';  --init for simulation
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

  process(clk)
  begin
    if rising_edge(clk) then
      if tc = '1' then  ---synchronized signal slider SW0
        led_tmp <= not led_tmp;
      end if;
    end if;
  end process;
  
  leds(3 downto 1) <= (others => '0');
  leds(0) <= led_tmp;
  
  end architecture rtl;

