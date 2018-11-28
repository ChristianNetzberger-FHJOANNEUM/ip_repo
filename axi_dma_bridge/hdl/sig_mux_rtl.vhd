--
-- VHDL Architecture signal_connector.sig_mux.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 12:44:46 31.10.2015
--
-- using Mentor Graphics HDL Designer(TM) 2012.2b (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.busdef.all;

entity sig_mux is
   generic( 
      n_signals_in_g  : integer := 30;
      n_signals_out_g : integer := 7
   );
   port( 
      -- Users to add ports here
      clk     : in     std_logic;
      sig_i   : in     std_logic_vector (16*n_signals_in_g-1 downto 0);
      sig_sel : in     std_logic_vector (8*n_signals_out_g-1 downto 0);
      sig_o   : out    std_logic_vector (16*n_signals_out_g-1 downto 0)
   );

-- Declarations

end sig_mux ;

--
architecture rtl of sig_mux is
begin
  
  g0: for k in 0 to n_signals_out_g-1 generate
    process(clk)
    begin
      if rising_edge(clk) then
--          sig_o <= (others => '0');
          for i in 0 to n_signals_in_g-1 loop
            if i = sig_sel(k*8+7 downto k*8) then
                sig_o(k*16+15 downto k*16) <= sig_i(i*16+15 downto i*16);
            end if;
          end loop;
      end if;
    end process;
   end generate g0;
   
end architecture rtl;

