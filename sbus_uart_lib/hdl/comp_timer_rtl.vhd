--
-- VHDL Architecture training_lib.comp_timer.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 19:13:20 22.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_timer is
  generic(core_clk_freq_g: integer := 125000000;
          timer_freq_g: integer := 1000
          );
  port (clk: in std_logic;
        reset: in std_logic;
        timer_stb: out std_logic
      );        
end entity comp_timer;

--
architecture rtl of comp_timer is
begin


end architecture rtl;

