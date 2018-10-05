--
-- VHDL Architecture tutorial_lib.bhv_clock_gen.bhv
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 13:14:16 19.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity bhv_clock_gen is
   generic( 
      clk_period_g      : time    := 20 ns;
      reset_cycles_g    : integer := 10;
      enable_a_cycles_g : integer := 1;
      enable_b_cycles_g : integer := 1
   );
   port( 
      clk      : out    std_logic;
      enable_a : out    std_logic;
      enable_b : out    std_logic;
      reset    : out    std_logic
   );

-- Declarations

end entity bhv_clock_gen ;

--
architecture bhv of bhv_clock_gen is
  signal clk_int: std_logic := '0';
  signal reset_int: std_logic := '0';
  signal enable_a_cnt: integer := 0;
  signal enable_b_cnt: integer := 0;
  
begin
  
  --clock generation ------------------------------
  clk_int <= not clk_int after clk_period_g/2;
  
  -- generate the power on reset ------------------
  process
    begin
      reset_int <= '1';
      wait for reset_cycles_g * clk_period_g;
      reset_int <= '0';
      wait;
    end process;

  -- generate enable_a signal  ---------------
  process(clk_int)
    begin
      if clk_int ='1' and clk_int'event then
        if reset_int ='1' then
          enable_a_cnt <= 0;
        elsif enable_a_cnt = enable_a_cycles_g then
          enable_a_cnt <= 0;
        else
          enable_a_cnt <= enable_a_cnt + 1;
        end if;
      end if;
    end process;

   enable_a <= '1' when enable_a_cnt = enable_a_cycles_g else '0';

 -- generate enable_b signal  ---------------
 process(clk_int)
   begin
     if clk_int ='1' and clk_int'event then
       if reset_int ='1' then
         enable_b_cnt <= 0;
       elsif enable_b_cnt = enable_b_cycles_g then
         enable_b_cnt <= 0;
       else
         enable_b_cnt <= enable_b_cnt + 1;
       end if;
     end if;
   end process;
   enable_b <= '1' when enable_b_cnt = enable_b_cycles_g else '0';
         
          
   -- assignment to external signals ---------------    
    clk <= clk_int;
    reset <= reset_int;
    
end architecture bhv;

