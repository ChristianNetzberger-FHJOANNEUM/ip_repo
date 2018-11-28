--
-- VHDL Architecture training_lib.comp_tonefrequency_lut.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 18:59:45 27.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity comp_tonefrequency_lut is
   port( 
      index : in     std_logic_vector (3 downto 0);
      fcw_o : out    std_logic_vector (31 downto 0)
   );

-- Declarations

end comp_tonefrequency_lut ;

--
architecture rtl of comp_tonefrequency_lut is
  signal fcw_value: integer;
begin
  with index select
  fcw_value <=  60473 when "0000",
                64069 when "0001",
                67879 when "0010",
                71915 when "0011",
                76191 when "0100",
                80722 when "0101",
                85522 when "0110",
                90607 when "0111",
                95995 when "1000",
                101703 when "1001",
                107751 when "1010",
                114158 when "1011",
                120946 when others;

fcw_o <= conv_std_logic_vector(fcw_value,32);

end architecture rtl;

