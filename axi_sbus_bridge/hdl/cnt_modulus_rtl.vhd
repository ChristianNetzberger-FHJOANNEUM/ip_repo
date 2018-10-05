--
-- VHDL Architecture fh_lib.modulo_n_cnt.rtl
--
-- Created:
--          by - net.UNKNOWN (KPROJM3198)
--          at - 20:32:42 28.02.2006
--
-- using Mentor Graphics HDL Designer(TM) 2005.1 (Build 83)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cnt_modulus is
   generic( 
      n_dout_g : integer := 8;
      module_g : integer := 256
   );
   port( 
      clk    : in     std_logic;
      enable : in     std_logic;
      reset  : in     std_logic;
      dout   : out    std_logic_vector (n_dout_g-1 downto 0);
      cnt_tc : out    std_logic
   );

-- Declarations

end cnt_modulus ;

--
architecture rtl of cnt_modulus is
  signal cnt: std_logic_vector(dout'range);
  signal tc_int: std_logic;
begin
  
  -- modulo counter with enable and reset ---------------
  process(clk)
    begin
      if clk='1' and clk'event then
        if reset = '1' then
           cnt <= (others => '0');
        elsif enable = '1' then          
          if tc_int = '1' then
            cnt <= (others => '0');
          else
            cnt <= cnt + 1;
          end if;
        end if;
      end if;
    end process;
    
  -- terminal count decoder --------------------        
  tc_int <= '1' when cnt = module_g-1 else '0';
  cnt_tc <= tc_int and enable;
  
  -- output signal assignment -----------------
  dout <= cnt;
              
end architecture rtl;

