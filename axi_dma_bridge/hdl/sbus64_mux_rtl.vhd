--
-- VHDL Architecture axi_kim_slv_v1_0.sbus_mux.rtl
--
-- Created:
--          by - net.UNKNOWN (KPROJM6387)
--          at - 20:20:18 14.02.2014
--
-- using Mentor Graphics HDL Designer(TM) 2012.2b (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
library work;
use work.busdef.ALL;

entity s64bus_mux is
   port( 
      sbus_i_in   : in     s64bus_i_t;
      sbus_i_out  : out    s64bus_i_t;
      sbus_o_mux  : out    s64bus_o_t;
      sbus_o_0    : in     s64bus_o_t;
      sbus_o_1    : in     s64bus_o_t;
      sbus_o_2    : in     s64bus_o_t;
      sbus_o_3    : in     s64bus_o_t;
      sbus_o_4    : in     s64bus_o_t;
      sbus_o_5    : in     s64bus_o_t;
      sbus_o_null : out    s64bus_o_t
   );

-- Declarations

end s64bus_mux ;

--
architecture rtl of s64bus_mux is
begin
  sbus_i_out <= sbus_i_in;
  sbus_o_mux.rdata <= sbus_o_0.rdata or sbus_o_1.rdata or sbus_o_2.rdata or sbus_o_3.rdata or sbus_o_4.rdata or sbus_o_5.rdata;
  sbus_o_mux.ack <= sbus_o_0.ack or sbus_o_1.ack or sbus_o_2.ack  or sbus_o_3.ack  or sbus_o_4.ack or sbus_o_5.ack;
  sbus_o_null <= s64bus_o_null_c; 
end architecture rtl;

