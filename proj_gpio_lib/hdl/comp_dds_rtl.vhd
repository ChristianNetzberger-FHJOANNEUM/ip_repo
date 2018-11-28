--
-- VHDL Architecture training_lib.comp_dds.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 18:39:35 27.10.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_dds is
   generic( 
      nbits_g : integer := 32
   );
   port( 
      fcw        : in     std_logic_vector (nbits_g-1 downto 0);
      reset      : in     std_logic;
      enable     : in     std_logic;
      clk        : in     std_logic;
      dds_strobe : out    std_logic;
      dds_wave   : out    std_logic
   );

-- Declarations

end comp_dds ;

--
architecture rtl of comp_dds is
  signal accu: std_logic_vector(nbits_g-1 downto 0);
  signal accu_msb,accu_msb_q0: std_logic;
begin
  
  --accumulator------------------
  --integrates the frequency control word fcw
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
         accu <= (others => '0');
      elsif enable = '1' then
         accu <= accu + fcw;
      end if;
    end if;
  end process;

  --- most significant bit (msb) of accumulator
  accu_msb <= accu(accu'left);
  
  ---falling edge detection to generate strobe signal
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
         accu_msb_q0 <= '0';
      else
         accu_msb_q0 <= accu_msb;
      end if;
    end if;
  end process;
  
  dds_strobe <= '1' when accu_msb = '0' and accu_msb_q0 = '1' else '0';
  dds_wave   <= accu_msb;   --rectangular waveform 50% duty cycle
  
--alternate boolean equation for strobe:
--  strobe <= not accu_msb and accu_msb_q0;

-- 
end architecture rtl;

