--
-- VHDL Architecture training_lib.comp_delay.rtl
--
-- Created:
--          by - Net.UNKNOWN (KPERSM7467)
--          at - 23:31:00 29.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity comp_delay is
   generic( 
      delay_g : integer := 1
   );
   port( 
      din   : in     std_logic;
      reset : in     std_logic;
      clk   : in     std_logic;
      din_q : out    std_logic
   );

-- Declarations

end comp_delay ;

--
architecture rtl of comp_delay is
begin
end architecture rtl;

