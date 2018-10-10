--
-- VHDL Architecture training_lib.comp_counter_modulo_var.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 20:40:50 22.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_counter_modulo_var is
   generic( 
      nbits_g : integer := 8
   );
   port( 
      clk    : in     std_logic;
      reset  : in     std_logic;
      en     : in     std_logic;
      module : in     std_logic_vector (nbits_g-1 downto 0);
      tc     : out    std_logic;
      cnt    : out    std_logic_vector (nbits_g-1 downto 0)
   );

-- Declarations

end comp_counter_modulo_var ;

--
architecture rtl of comp_counter_modulo_var is
  signal cnt_tmp: std_logic_vector(nbits_g-1 downto 0) := (others =>'0');
  signal cnt_tmp_tc: std_logic;
begin
  
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        cnt_tmp <= (0 => '1',others => '0'); --reset to '1'
      elsif en = '1' then
        if cnt_tmp_tc = '1' then
          cnt_tmp <= (0 => '1',others => '0');--wrap back to '1'
        else
            cnt_tmp <= cnt_tmp+1;
        end if;
      end if;
    end if;
  end process;
    
    --compute the terminal count
    -- count from 1 to module
    cnt_tmp_tc <= '1' when cnt_tmp = module else '0';
    
    --assign internal signals to output
    cnt <= cnt_tmp;
    tc <= cnt_tmp_tc and en;
    end architecture rtl;

