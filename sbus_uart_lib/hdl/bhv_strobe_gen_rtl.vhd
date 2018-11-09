--
-- VHDL Architecture sbus_uart_lib.bhv_strobe_gen.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 11:08:16 08.11.2018
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity bhv_strobe_gen is
  generic(timestamp_g: time := 1 us;
          period_g: time := 200us;
          singleshot_g: boolean := true);
   port( 
      clk : in     std_logic;
      stb : out    std_logic
   );

-- Declarations

end bhv_strobe_gen ;

--
architecture rtl of bhv_strobe_gen is
begin

---create the pulse only once------
g0: if singleshot_g generate  
  process
  begin
    stb <= '0';
    wait for timestamp_g;
    wait until rising_edge(clk);
    stb <= '1';
    wait until rising_edge(clk);
    stb <= '0';
    wait;
  end process;   
end generate g0;

---create pulse periodically-------
g1: if not singleshot_g generate  
  process
  begin
    stb <= '0';
    wait for timestamp_g;
    wait until rising_edge(clk);
    stb <= '1';
    wait until rising_edge(clk);
    stb <= '0';
    wait for period_g;
  end process;    
end generate g1;
 
end architecture rtl;

