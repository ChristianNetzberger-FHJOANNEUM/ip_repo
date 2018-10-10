--
-- VHDL Architecture training_lib.comp_timer.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 19:13:20 22.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_timer is
  generic(core_clk_freq_g: integer := 125000000;
          timer_freq_g: integer := 1000
          );
  port (clk: in std_logic;
        reset: in std_logic;
        timer_stb: out std_logic
      );        
end entity comp_timer;

--
architecture rtl of comp_timer is
  signal timer: std_logic_vector(31 downto 0) := (others => '0');
  signal timer_tc: std_logic;
  --compute counter module from generics:  core clk_frequency_g and timer_frequency_g
  constant module_c: integer := core_clk_freq_g/timer_freq_g;
begin

--synchronous counter with active high reset--
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        timer <= (others => '0');
      else
        if timer_tc = '1' then
             timer <= (others => '0');
         else
             timer <= timer +1;
        end if;
      end if;
    end if;
  end process;

-- compute the terminal count signal for the counter         
   timer_tc <= '1' when  timer = module_c-1 else '0';

timer_stb <= timer_tc;


end architecture rtl;

