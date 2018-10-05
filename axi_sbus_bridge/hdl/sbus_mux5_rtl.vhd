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

entity sbus_mux5 is
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
      sbus_o_null : out    sbus_o_t
   );

-- Declarations

end sbus_mux5 ;

--

architecture rtl of sbus_mux5 is
  
begin
  process(clk)
  begin
    if rising_edge(clk) then
      sbus_o_mux.rdata <= sbus_o_0.rdata or sbus_o_1.rdata or sbus_o_2.rdata or sbus_o_3.rdata or sbus_o_4.rdata or sbus_o_5.rdata;
      sbus_o_mux.ack <= sbus_o_0.ack or sbus_o_1.ack or sbus_o_2.ack or sbus_o_3.ack or sbus_o_4.ack or sbus_o_5.ack;
      sbus_o_null <= sbus_o_null_c; 
      sbus_i_out <= sbus_i_in;
    end if;
  end process;
  
end architecture rtl;

