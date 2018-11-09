--
-- VHDL Architecture training_lib.comp_edge_det.rtl
--
-- Created:
--          by - Net.UNKNOWN (KPERSM7467)
--          at - 15:00:58 29.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity comp_edge_det is
   port( 
      din   : in     std_logic;
      reset : in     std_logic;
      clk   : in     std_logic;
      rise  : out    std_logic;
      fall  : out    std_logic;
      any   : out    std_logic
   );

-- Declarations

end comp_edge_det ;

--
architecture rtl of comp_edge_det is
begin
end architecture rtl;

