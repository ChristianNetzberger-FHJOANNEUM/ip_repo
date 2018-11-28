--
-- VHDL Architecture axi_sbus_bridge.sbus_termination.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 14:39:34 04.12.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
library work;
use work.busdef.all;

entity sbus_termination is
   port( 
      sbus_o_null : out    sbus_o_t;
      sbus_i_null : out    sbus_i_t
   );

-- Declarations

end sbus_termination ;

--
architecture rtl of sbus_termination is
begin
  sbus_o_null.ack <= '0';
  sbus_o_null.rdata <= (others => '0');
  sbus_i_null.addr <= (others => '0');
  sbus_i_null.wdata <= (others => '0');
  sbus_i_null.we <= '0';
  sbus_i_null.rd <= '0';
end architecture rtl;

