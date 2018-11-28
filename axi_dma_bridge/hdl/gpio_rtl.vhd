--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;
library work;
use work.busdef.ALL;

entity gpio_port is
   generic( 
      addr_width_g : integer := 8;      --width of address
      data_width_g : integer := 8;      --width of data
      port_width_g : integer := 8;      --width of data
      addr_base_g  : std_logic_vector;
      addr_range_g : std_logic_vector
   );
   port( 
      sbus_o : out    sbus_o_t;
      sbus_i : in     sbus_i_t;
      reg_i  : in     std_logic_vector (port_width_g-1 downto 0 );
      reg_o  : out    std_logic_vector (port_width_g-1 downto 0 );
      reg_t  : out    std_logic_vector (port_width_g-1 downto 0 );
      reset  : in     std_logic;
      clk    : in     std_logic
   );

-- Declarations

end gpio_port ;

architecture rtl of gpio_port is

signal bus_addr :     std_logic_vector (addr_width_g-1 downto 0); -- register address
signal bus_cs   :     std_logic;                                  -- chip select, active high
signal bus_din  :     std_logic_vector (data_width_g-1 downto 0); -- bus input data
signal bus_we   :     std_logic;                                  -- write enable, active high
signal bus_rd   :     std_logic;                                  -- read enable, active high
signal bus_dout :     std_logic_vector (data_width_g-1 downto 0); -- bus output data
signal bus_ack  :     std_logic;                                  -- bus acknowledge

signal reg_data, reg_dir: std_logic_vector(port_width_g - 1 downto 0); -- internal data register
 
begin
  
  -- connection to slave bus --
  bus_addr    <= sbus_i.addr(bus_addr'range);
  bus_din     <= sbus_i.wdata(bus_din'range);
  bus_we      <= sbus_i.we;
  bus_rd      <= sbus_i.rd;
  sbus_o.rdata <= bus_dout;
  sbus_o.ack  <= bus_ack;
  
  -- address decoder ---------------------------
  bus_cs <= '1' when bus_addr >= addr_base_g and bus_addr < (addr_base_g+addr_range_g) else '0';
  
  --- Write to Data Register -------------------
  process(clk)
  begin
     if clk ='1' and clk'event then
       if reset = '1' then
          reg_dir <= (others => '0');
          reg_data <= (others => '0');
       elsif bus_cs = '1' and bus_we = '1' then
         if bus_addr(0) = '0' then
            reg_data <= bus_din(reg_data'range);
         else
            reg_dir  <= bus_din(reg_data'range);
         end if;
       end if;
     end  if;
  end process; 
  
  --Read from Data Register --------------------
  process(reg_i, bus_addr, bus_cs,reg_dir)
  begin
     bus_dout <= (others => '0');
     if bus_cs = '1'  then
       if bus_addr(0) = '0' then
          bus_dout(reg_data'range) <= reg_i;
        else
          bus_dout(reg_data'range) <= reg_dir;
        end if;
     end if;
  end process;
  
  reg_o   <= reg_data;  
  reg_t   <= reg_dir;
  bus_ack <= bus_cs and (bus_we or bus_rd);  

end architecture rtl;


