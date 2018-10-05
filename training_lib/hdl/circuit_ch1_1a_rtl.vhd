--
-- VHDL Architecture training_lib.circuit_ch1_1b.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 12:18:40 19.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity circuit_ch1_1a is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch1_1a;

--
architecture rtl of circuit_ch1_1a is
begin
  leds <= buttons;
end architecture rtl;

