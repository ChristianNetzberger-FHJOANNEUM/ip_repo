--
-- VHDL Architecture training_lib.circuit_ch2_1a.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 19:52:16 19.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity circuit_ch2_1a is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch2_1a;

--
architecture rtl of circuit_ch2_1a is
  signal buttons_q0,buttons_q1,buttons_q2: std_logic_vector(buttons'range);
  signal sliders_q0,sliders_q1,sliders_q2: std_logic_vector(sliders'range);
  
begin
  
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
  
  leds <= buttons_q2 and sliders_q2;
  
end architecture rtl;

