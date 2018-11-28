--
-- VHDL Architecture dataflow_lib.fifo_bram.rtl
--
-- Created:
--          by - Net.UNKNOWN (KPERSM7467)
--          at - 18:56:05 28.12.2017
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.busdef.all;

entity fifo_distram is
   generic( 
      awidth_g : integer := 10;
      dwidth_g : integer := 32
   );
   port( 
      clk       : in     std_logic;
      reset     : in     std_logic;
      we_ack    : out    std_logic;
      wdata     : in     std_logic_vector (dwidth_g-1 downto 0);
      we        : in     std_logic;
      rd_ack    : out    std_logic;
      fifo_en   : in     std_logic;
      fifo_size : out    std_logic_vector (15 downto 0);
      rdata     : out    std_logic_vector (dwidth_g-1 downto 0);
      rd        : in     std_logic
   );

-- Declarations

end fifo_distram ;

--
architecture rtl of fifo_distram is
  type mem_t is array (0 to 2**awidth_g-1) of std_logic_vector(dwidth_g-1 downto 0);
  signal fifo: mem_t := (others => (others => '1'));
  signal wrcnt, rdcnt: std_logic_vector(awidth_g-1 downto 0);
  signal wrptr, rdptr: integer;
  signal en: std_logic;
  signal rd_state: std_logic;
begin

---fifo bram-------
  process(clk)
  begin
    if rising_edge(clk) then
        if we = '1' then
           fifo(conv_integer(wrcnt)) <= wdata;
        end if;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
        if reset = '1' or fifo_en = '0' then
           wrcnt <= (others => '0');
           rdcnt <= (others => '0');
        else
           if we = '1' then
             wrcnt <= wrcnt+1;
           end if;
           if rd = '1' and (rdcnt /= wrcnt )then
             rdcnt <= rdcnt+1;
             rd_ack <= '1';   --- 1 clk read latency
           end if;
         end if;
       fifo_size <= (others => '0');
       fifo_size(awidth_g-1 downto 0) <= (wrcnt -rdcnt);
     end if;
  end process;

  
  rdata <= fifo(conv_integer(rdcnt));

 we_ack <= we;
 
 wrptr <= conv_integer(wrcnt);
 rdptr <= conv_integer(rdcnt);

end architecture rtl;

