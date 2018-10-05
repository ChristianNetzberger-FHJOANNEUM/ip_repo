--
-- VHDL Architecture training_lib.circuit_ch2_1b.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 20:37:31 19.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity circuit_ch2_1b is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch2_1b;

--
architecture rtl of circuit_ch2_1b is
  signal buttons_q0,buttons_q1,buttons_q2: std_logic_vector(buttons'range);
  signal sliders_q0,sliders_q1,sliders_q2: std_logic_vector(sliders'range);
  signal buttons_rising_stb, buttons_falling_stb,buttons_any_stb: std_logic_vector(buttons'range);
  signal leds_tmp: std_logic_vector(leds'range) := (others => '0');   --init for simulation
begin
  
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

--logic conditions for rising, falling and any edges 
-- to generate 1-cycle active high strobe signals   
  buttons_rising_stb  <= buttons_q1 and not buttons_q2;
  buttons_falling_stb <= not buttons_q1 and buttons_q2;
  buttons_any_stb     <= buttons_q1 xor buttons_q2;
  
-- toggle LEDs when button strobes are asserted
  process(clk)
  begin
    if rising_edge(clk) then
      for i in leds_tmp'range loop   --loop variable i iterates from 3 downto 0
         if buttons_rising_stb(i) = '1' then
           leds_tmp(i) <= not leds_tmp(i);
         end if;
      end loop;
    end if;
  end process;
  
  --why do we need an internal signal for leds??
  leds <= leds_tmp;
       
end architecture rtl;

