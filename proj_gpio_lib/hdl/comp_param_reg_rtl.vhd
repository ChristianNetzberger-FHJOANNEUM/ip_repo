--
-- VHDL Architecture training_lib.comp_param_reg.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 12:40:25 22.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_param_reg is
   generic( 
      nbits_g       : integer := 4;
      limit_hi_g    : integer := 15;
      limit_lo_g    : integer := 0;
      reset_val_g   : integer := 7;
      use_din_g     : boolean := false;
      use_encoder_g : boolean := true
   );
   port( 
      clk         : in     std_logic;
      reset       : in     std_logic;
      encoder     : in     std_logic_vector (1 downto 0);
      encoder_stb : in     std_logic_vector (1 downto 0);
      inc         : in     std_logic;
      dec         : in     std_logic;
      din         : in     std_logic_vector (nbits_g-1 downto 0);
      we          : in     std_logic;
      en_o        : out    std_logic;
      max_val     : out    std_logic;
      min_val     : out    std_logic;
      param_val   : out    std_logic_vector (nbits_g-1 downto 0)
   );

-- Declarations

end comp_param_reg ;

--
architecture rtl of comp_param_reg is
  signal cnt: std_logic_vector(param_val'range);
  signal cnt_tc_lo: std_logic;
  signal cnt_tc_hi: std_logic;
  signal cnt_en, cnt_dir: std_logic;
  signal cnt_load_en: std_logic;
  
begin
 
 g0: if use_encoder_g generate
    cnt_en  <= encoder_stb(1);
    cnt_dir <= encoder(0);
 end generate g0;
 
 g1: if not use_encoder_g generate
    cnt_en  <= inc or dec;
    cnt_dir <= inc;
 end generate g1;
 
 g2: if use_din_g generate
     cnt_load_en <= we;
 end generate g2;

 g3: if not use_din_g generate
     cnt_load_en <= '0';
 end generate g3;
  
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        cnt <= conv_std_logic_vector(reset_val_g,cnt'length);
      elsif we = '1' then
        cnt <= din;
      elsif cnt_en = '1' then
        if cnt_dir = '1' then
          if cnt_tc_hi = '0' then
            cnt <= cnt+1;
          end if;
        else
          if cnt_tc_lo = '0' then
            cnt <= cnt-1;
          end if;
        end if;
       end if;     
    end if;
  end process;
  
  cnt_tc_lo <= '1' when cnt = limit_lo_g else '0';
  cnt_tc_hi <= '1' when cnt = limit_hi_g else '0';
  
  max_val <= cnt_tc_hi;
  min_val <= cnt_tc_lo;
  param_val <= cnt;
end architecture rtl;

