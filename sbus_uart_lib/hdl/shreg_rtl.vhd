--
-- VHDL Architecture sbus_uart_lib.shreg.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 12:16:22 08.11.2018
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity shreg is
  generic(dwidth_g: integer := 8);
   port( 
      clk          : in     std_logic;
      load_en      : in     std_logic;
      parallel_in  : in     std_logic_vector (dwidth_g-1 downto 0);
      reset        : in     std_logic;
      serial_in    : in     std_logic;
      shift_en     : in     std_logic;
      parallel_out : out    std_logic_vector (dwidth_g-1 downto 0);
      serial_out   : out    std_logic
   );

-- Declarations

end shreg ;

--
architecture rtl of shreg is
begin
end architecture rtl;

