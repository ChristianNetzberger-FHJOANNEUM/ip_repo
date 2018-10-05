--
-- VHDL Architecture training_lib.circuit_ch1_2b.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 17:17:43 19.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity circuit_ch1_2b is
  port (buttons: in std_logic_vector(3 downto 0);
        sliders: in std_logic_vector(3 downto 0);
        encoder0: in std_logic_vector(1 downto 0);
        encoder1: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        buzzer: out std_logic_vector(1 downto 0);
        leds: out std_logic_vector(3 downto 0)
        );  
end entity circuit_ch1_2b;

--
architecture rtl of circuit_ch1_2b is
begin
  leds(0) <= '1' when sliders < 6 else '0';
  leds(1) <= '1' when sliders = 6 else '0';
  leds(2) <= '1' when sliders > 6 else '0';
  leds(3) <= '0';  -- turned permanently off
end architecture rtl;

