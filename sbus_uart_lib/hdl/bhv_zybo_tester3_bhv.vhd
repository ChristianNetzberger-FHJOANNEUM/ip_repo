--
-- VHDL Architecture training_lib.bhv_zybo_tester1.bhv
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 14:06:49 19.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
Library std;
use std.textio.all;

entity bhv_zybo_tester3 is
   generic( 
      commands_g           : string  := "commands.txt";
      clk_period_g         : time    := 8 ns;
      strobe0_clk_cycles_g : integer := 10;
      strobe1_clk_cycles_g : integer := 10;
      reset_clk_cycles_g   : integer := 10
   );
   port( 
      buttons  : out    std_logic_vector (3 downto 0);
      clk      : out    std_logic;
      reset    : out    std_logic;
      strobe0  : out    std_logic;
      strobe1  : out    std_logic;
      encoder0 : out    std_logic_vector (1 downto 0);
      encoder1 : out    std_logic_vector (1 downto 0);
      sliders  : out    std_logic_vector (3 downto 0)
   );

-- Declarations

end bhv_zybo_tester3 ;

--
architecture bhv of bhv_zybo_tester3 is
  signal halt, stop: std_logic := '0';
  signal clk_tmp: std_logic := '0';
  signal buttons_tmp: std_logic_vector(buttons'range) := (others => '0');
  signal sliders_tmp: std_logic_vector(sliders'range) := (others => '0');
  signal encoder0_tmp: std_logic_vector(encoder0'range) := (others => '1'); -- inactive '1'
  signal encoder1_tmp: std_logic_vector(encoder1'range) := (others => '1'); -- inactive '1'
  
  signal encoder0_cmd, encoder1_cmd: std_logic := '0';
  signal encoder0_dir, encoder0_val: integer;
  signal encoder1_dir, encoder1_val: integer;
  constant encoder_steptime: time := 5 us;
  
  signal pushbutton0_cmd, pushbutton1_cmd, pushbutton2_cmd, pushbutton3_cmd: std_logic := '0';
  signal pushbutton_tmp: std_logic_vector(3 downto 0) := (others => '0');
  signal pushbutton_time : time := 10us;
    
  -- convert ascii string into std_logic_vector-----------------------
  function ascii_vec4(binval: string(1 to 4)) return std_logic_vector is
     variable tmp: std_logic_vector(3 downto 0);
  begin
      tmp := (others => '0');
      if binval(1)='1' then
        tmp(3) := '1';
      end if;
      if binval(2)='1' then
        tmp(2) := '1';
      end if;
      if binval(3)='1' then
        tmp(1) := '1';
      end if;
      if binval(4)='1' then
        tmp(0) := '1';
      end if;
      return tmp;  
  end function ascii_vec4;

  signal strobe0_cnt: integer := 0;
  signal strobe1_cnt: integer := 0;  
  signal strobe0_cnt_tc: std_logic := '0';
  signal strobe1_cnt_tc: std_logic := '0';
  
begin

  ---------------------------------------------------------------
  --  reset generation
  ---------------------------------------------------------------
      process
      begin
         reset <= '1';
         wait for clk_period_g*reset_clk_cycles_g;
         reset <= '0';
         wait;
       end process;
       
  ---------------------------------------------------------------
  --  clock generation
  ---------------------------------------------------------------
       clk_tmp <= not clk_tmp after clk_period_g/2;
       clk <= clk_tmp;
       
  ---------------------------------------------------------------
  --  strobe0 generation
  ---------------------------------------------------------------
--      process
--      begin
--         strobe0 <= '0';
--         wait for clk_period_g*(strobe0_clk_cycles_g-1);
--         strobe0 <= '1';
--         wait for clk_period_g;
--      end process;

      process(clk_tmp)
      begin
         if rising_edge(clk_tmp) then
            if strobe0_cnt_tc = '1' then
                strobe0_cnt <= 0;
            else
                strobe0_cnt <= strobe0_cnt+1;
            end if;
         end if;
      end process; 
      strobe0_cnt_tc <= '1' when strobe0_cnt =  strobe0_clk_cycles_g-1 else '0';   
      strobe0 <= strobe0_cnt_tc;
      
  ---------------------------------------------------------------
  --  strobe1 generation
  ---------------------------------------------------------------
      process(clk_tmp)
      begin
         if rising_edge(clk_tmp) then
            if strobe1_cnt_tc = '1' then
                strobe1_cnt <= 0;
            else
                strobe1_cnt <= strobe1_cnt+1;
            end if;
         end if;
      end process; 
      strobe1_cnt_tc <= '1' when strobe1_cnt =  strobe1_clk_cycles_g-1 else '0';   
      strobe1 <= strobe1_cnt_tc;

         
       
       buttons  <= buttons_tmp or pushbutton_tmp;
       sliders  <= sliders_tmp;
       encoder0 <= encoder0_tmp;
       encoder1 <= encoder1_tmp;
       
  ------------------------------------------------------------------------------
   ---Read Command File
   ------------------------------------------------------------------------------
   
       readcmd:process
       file textfile:  text open read_mode is commands_g;
       variable l: line;
       variable cmd:  string(1 to 4);
       variable binval:  string(1 to 4);
       variable num: integer;
       variable separator: character;
       variable timestamp_v, waittime_v: time;
       variable dir: integer;
       begin
          while not endfile(textfile) loop
            wait until clk_tmp'event;  
            readline(textfile, l);
            read(l, cmd);
            case cmd is
               when "enc0" =>    read(l,separator);
                                 read(l,dir);
                                 encoder0_dir <= dir;
                                 read(l,separator);
                                 read(l,num);
                                 encoder0_val <= num;
                                 encoder0_cmd <= not encoder0_cmd;
               when "enc1" =>    read(l,separator);
                                 read(l,dir);
                                 encoder1_dir <= dir;
                                 read(l,separator);
                                 read(l,num);
                                 encoder1_val <= num;
                                 encoder1_cmd <= not encoder1_cmd;
                when "butn" =>   read(l,separator);
                                 read(l,binval);
                                 buttons_tmp <= ASCII_VEC4(binval);
                                 
               when "psh0" =>    pushbutton0_cmd <= not pushbutton0_cmd;
                                 wait for pushbutton_time;
               when "psh1" =>    pushbutton1_cmd <= not pushbutton1_cmd;
                                 wait for pushbutton_time;
               when "psh2" =>    pushbutton2_cmd <= not pushbutton2_cmd;
                                 wait for pushbutton_time;
               when "psh3" =>    pushbutton3_cmd <= not pushbutton3_cmd;
                                 wait for pushbutton_time;
                 
               when "but0" =>    read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   buttons_tmp(0) <= '0';
                                 else
                                   buttons_tmp(0) <= '1';
                                 end if;
               when "but1" =>    read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   buttons_tmp(1) <= '0';
                                 else
                                   buttons_tmp(1) <= '1';
                                 end if;
               when "but2" =>    read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   buttons_tmp(2) <= '0';
                                 else
                                   buttons_tmp(2) <= '1';
                                 end if;
               when "but3" =>   read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   buttons_tmp(3) <= '0';
                                 else
                                   buttons_tmp(3) <= '1';
                                 end if;
               when "sldn" =>    read(l,separator);
                                 read(l,binval);
                                 sliders_tmp <= ASCII_VEC4(binval);
               when "sld0" =>    read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   sliders_tmp(0) <= '0';
                                 else
                                   sliders_tmp(0) <= '1';
                                 end if;
               when "sld1" =>    read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   sliders_tmp(1) <= '0';
                                 else
                                   sliders_tmp(1) <= '1';
                                 end if;
               when "sld2" =>    read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   sliders_tmp(2) <= '0';
                                 else
                                   sliders_tmp(2) <= '1';
                                 end if;
               when "sld3" =>    read(l,separator);
                                 read(l,num);
                                 if num = 0 then
                                   sliders_tmp(3) <= '0';
                                 else
                                   sliders_tmp(3) <= '1';
                                 end if;
               when "time" =>   read(l,separator);
                                read(l,timestamp_v);
                                waittime_v := timestamp_v - now;
                                halt <= '1';
                                wait for waittime_v;  
                                halt <= '0';
               when "wait" =>   read(l,separator);
                                read(l,waittime_v);
                                halt <= '1';
                                wait for waittime_v;  
                                halt <= '0';
               when "----" =>   -- used for comments
    
   
                when others =>   assert false report "Unrecognised Instruction"
                                 severity failure;
            end case;                    
         
         end loop;
         stop <= '1';
         assert false report "Simulation complete" severity note;
   
         wait;
   
       end process readcmd;
  
        process
        begin
          wait until (encoder0_cmd'event);
          for i in 1 to encoder0_val loop
              if encoder0_dir = 0 then
                  encoder0_tmp <= "11";
                  wait for encoder_steptime;
                  encoder0_tmp <= "10";
                  wait for encoder_steptime;
                  encoder0_tmp <= "00";
                  wait for encoder_steptime;
                  encoder0_tmp <= "01";
                  wait for encoder_steptime;
                  encoder0_tmp <= "11";
              else
                  encoder0_tmp <= "11";
                  wait for encoder_steptime;
                  encoder0_tmp <= "01";
                  wait for encoder_steptime;
                  encoder0_tmp <= "00";
                  wait for encoder_steptime;
                  encoder0_tmp <= "10";
                  wait for encoder_steptime;
                  encoder0_tmp <= "11";
              end if; 
          end loop;
        end process;
        
        process 
        begin
          wait until (encoder1_cmd'event);
          for i in 1 to encoder1_val loop
              if encoder1_dir = 0 then
                  encoder1_tmp <= "11";
                  wait for encoder_steptime;
                  encoder1_tmp <= "10";
                  wait for encoder_steptime;
                  encoder1_tmp <= "00";
                  wait for encoder_steptime;
                  encoder1_tmp <= "01";
                  wait for encoder_steptime;
                  encoder1_tmp <= "11";
              else
                  encoder1_tmp <= "11";
                  wait for encoder_steptime;
                  encoder1_tmp <= "01";
                  wait for encoder_steptime;
                  encoder1_tmp <= "00";
                  wait for encoder_steptime;
                  encoder1_tmp <= "10";
                  wait for encoder_steptime;
                  encoder1_tmp <= "11";
              end if; 
          end loop;
          
        end process;
 
 ----create  push-button signals
        process 
        begin
          wait until (pushbutton0_cmd'event);
          pushbutton_tmp(0) <= '1';
          wait for pushbutton_time/2;
          pushbutton_tmp(0) <= '0';            
         end process;

        process 
        begin
          wait until (pushbutton1_cmd'event);
          pushbutton_tmp(1) <= '1';
          wait for pushbutton_time/2;
          pushbutton_tmp(1) <= '0';            
         end process;
          
        process 
        begin
          wait until (pushbutton2_cmd'event);
          pushbutton_tmp(2) <= '1';
          wait for pushbutton_time/2;
          pushbutton_tmp(2) <= '0';            
         end process;
          
        process 
        begin
          wait until (pushbutton3_cmd'event);
          pushbutton_tmp(3) <= '1';
          wait for pushbutton_time/2;
          pushbutton_tmp(3) <= '0';            
         end process;
          
          
end architecture bhv;

