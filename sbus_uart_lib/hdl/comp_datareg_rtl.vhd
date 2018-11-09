--
-- VHDL Architecture sbus_uart_lib.comp_datareg.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 18:31:20 08.11.2018
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_datareg is
  generic(dwidth_g: integer := 8);
   port( 
      clk   : in     std_logic;
      en    : in     std_logic;
      din   : in     std_logic_vector (dwidth_g-1 downto 0);
      reset : in     std_logic;
      dout  : out    std_logic_vector (dwidth_g-1 downto 0)
   );

-- Declarations

end comp_datareg ;

--
architecture rtl of comp_datareg is
begin
end architecture rtl;

