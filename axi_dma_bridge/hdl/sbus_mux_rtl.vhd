--
-- VHDL Architecture axi_kim_slv_v1_0.sbus_mux.rtl
--
-- Created:
--          by - net.UNKNOWN (KPROJM6387)
--          at - 20:20:18 14.02.2014
--
-- using Mentor Graphics HDL Designer(TM) 2012.2b (Build 5)
--
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
library work;
use work.busdef.ALL;

entity sbus_mux is
   port( 
      clk         : in     std_logic;
      sbus_i_in   : in     sbus_i_t;
      sbus_i_out  : out    sbus_i_t;
      sbus_o_mux  : out    sbus_o_t;
      sbus_o_0    : in     sbus_o_t;
      sbus_o_1    : in     sbus_o_t;
      sbus_o_2    : in     sbus_o_t;
      sbus_o_3    : in     sbus_o_t;
      sbus_o_4    : in     sbus_o_t;
      sbus_o_5    : in     sbus_o_t;
      sbus_o_6    : in     sbus_o_t;
      sbus_o_7    : in     sbus_o_t;
      sbus_o_8    : in     sbus_o_t;
      sbus_o_9    : in     sbus_o_t;
      sbus_o_10   : in     sbus_o_t;
      sbus_o_null : out    sbus_o_t
   );

-- Declarations

end sbus_mux ;

--

architecture rtl of sbus_mux is
  
begin
  
  sbus_i_out <= sbus_i_in;

--  process(clk)
--  begin
--    if rising_edge(clk) then
      sbus_o_mux.rdata <= sbus_o_0.rdata or sbus_o_1.rdata or sbus_o_2.rdata or sbus_o_3.rdata or sbus_o_4.rdata or sbus_o_5.rdata or sbus_o_6.rdata  or sbus_o_7.rdata  or sbus_o_8.rdata or sbus_o_9.rdata or sbus_o_10.rdata;
      sbus_o_mux.ack <= sbus_o_0.ack or sbus_o_1.ack or sbus_o_2.ack  or sbus_o_3.ack  or sbus_o_4.ack or sbus_o_5.ack or sbus_o_6.ack  or sbus_o_7.ack or sbus_o_8.ack or sbus_o_9.ack or sbus_o_10.ack;
      sbus_o_null <= sbus_o_null_c; 
--    end if;
--  end process;
  
end architecture rtl;

