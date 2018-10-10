--
-- VHDL Architecture training_lib.circuit_ch1_2f.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 18:27:06 19.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity circuit_ch1_2f is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch1_2f;

--
architecture rtl of circuit_ch1_2f is
  signal mag_sliders: std_logic_vector(sliders'range);
begin
  leds <= - sliders when buttons(0) = '1' else
           mag_sliders when buttons(1) = '1' else
           sliders;
   mag_sliders <= sliders when sliders >= 0 else -sliders;        
end architecture rtl;

