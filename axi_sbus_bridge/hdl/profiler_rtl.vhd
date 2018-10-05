--
-- VHDL Architecture signal_connector.profiler.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 11:07:04 08.02.2016
--
-- using Mentor Graphics HDL Designer(TM) 2012.2b (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.busdef.all;

entity profiler is
   generic( 
      addr_width_g : integer := 8;      --width of address
      data_width_g : integer := 8;      --width of data
      addr_base_g  : std_logic_vector;
      addr_range_g : std_logic_vector;
      nregs_g      : integer := 16      --number of registers
   );
   port( 
      -- Users to add ports here
      clk    : in     std_logic;
      reset  : in     std_logic;
      sbus_i : in     sbus_i_t;
      sbus_o : out    sbus_o_t
   );

-- Declarations

end profiler ;

--
architecture rtl of profiler is
signal bus_addr :     std_logic_vector (addr_width_g-1 downto 0);            -- register address
signal reg_addr :     std_logic_vector (log2(nregs_g)-1 downto 0);            -- register address
signal bus_cs   :     std_logic;                                             -- chip select, active high
signal bus_din  :     std_logic_vector (data_width_g-1 downto 0);            -- bus input data
signal bus_we   :     std_logic;                                             -- write enable, active high
signal bus_rd   :     std_logic;                                             -- write enable, active high
signal bus_dout :     std_logic_vector (data_width_g-1 downto 0);            -- bus output data
signal bus_ack  :     std_logic;

signal reg,reg_dout,reg_din,cnt: std_logic_vector(nregs_g*data_width_g - 1 downto 0);
signal we: std_logic_vector(nregs_g-1 downto 0);
signal bus_rd_q: std_logic;

begin
  
  -- connect to slave bus --
  bus_addr    <= sbus_i.addr(bus_addr'range);
  reg_addr    <= sbus_i.addr(reg_addr'range);
  bus_din     <= sbus_i.wdata(bus_din'range);
  bus_we      <= sbus_i.we;
  bus_rd      <= sbus_i.rd;
  sbus_o.rdata <= bus_dout;
  sbus_o.ack  <= bus_ack;
  
  -- addr decoder
  bus_cs <= '1' when bus_addr >= addr_base_g and bus_addr < (addr_base_g + addr_range_g) else '0';
  
  --- Write to Register Array ----------------------------------------------------------------
  process(clk)
  begin
     if clk ='1' and clk'event then
       we <= (others => '0'); 
       bus_rd_q <= bus_rd;
        for i in 0 to nregs_g-1 loop
           if reset = '1' then
              reg((i+1)*data_width_g-1 downto i*data_width_g) <= (others => '0');
              cnt((i+1)*data_width_g-1 downto i*data_width_g) <= (others => '0');
           elsif reg_addr = i and bus_cs = '1' and bus_rd = '1' and bus_rd_q = '0' then
              reg((i+1)*data_width_g-1 downto i*data_width_g) <= cnt((i+1)*data_width_g-1 downto i*data_width_g);
              cnt((i+1)*data_width_g-1 downto i*data_width_g) <= (others => '0');
           else
              cnt((i+1)*data_width_g-1 downto i*data_width_g) <= cnt((i+1)*data_width_g-1 downto i*data_width_g)+1;
           end if;
       end loop;
     end  if;
  end process; 
  
  --Read from Register Array--------------------
  process(reg, bus_addr, bus_cs,reg_din)
  begin
     bus_dout <= (others => '0');
     for i in 0 to nregs_g-1 loop
        if reg_addr = i and bus_cs = '1'  then
             bus_dout <=reg((i+1)*data_width_g-1 downto i*data_width_g);
        end if;
     end loop;
  end process;
  
  reg_dout <= reg; 
  
  bus_ack <= bus_cs and (bus_we or bus_rd_q);


end architecture rtl;

