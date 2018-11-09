--
-- VHDL Architecture training_lib.comp_counter_modulo.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 16:17:22 22.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_counter_modulo is
   generic( 
      nbits_g  : integer := 8;
      module_g : integer := 256
   );
   port( 
      clk   : in     std_logic;
      reset : in     std_logic;
      en    : in     std_logic;
      tc    : out    std_logic;
      cnt   : out    std_logic_vector (nbits_g-1 downto 0)
   );

-- Declarations

end comp_counter_modulo ;

--
architecture rtl of comp_counter_modulo is
begin
    
end architecture rtl;

