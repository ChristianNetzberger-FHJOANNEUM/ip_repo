--
-- VHDL Architecture jpec_isens.cnt_modulus_c.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 10:32:28 15.07.2015
--
-- using Mentor Graphics HDL Designer(TM) 2012.2b (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cnt_modulus_c is
   generic( 
      width_g : integer := 8
   );
   port( 
      clk     : in     std_logic;
      reset   : in     std_logic;
      enable  : in     std_logic;
      modulus : in     std_logic_vector (width_g-1 downto 0);
      cnt_tc  : out    std_logic;
      cnt     : out    std_logic_vector (width_g-1 downto 0)
   );

-- Declarations

end cnt_modulus_c ;

--
architecture rtl of cnt_modulus_c is
  signal tc_int: std_logic;
  signal cnt_int: std_logic_vector(cnt'range);
begin
  
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        cnt_int <= (0=> '1', others => '0');
      elsif enable = '1' then
        if tc_int = '1' then
           cnt_int <= (0=> '1', others => '0');
         else
           cnt_int <= cnt_int+1;
         end if;
      end if; 
    end if;
  end process;
  tc_int <= '1' when cnt_int = modulus else '0';
  
  cnt_tc <= tc_int;
  cnt <= cnt_int;  
          
  
end architecture rtl;

