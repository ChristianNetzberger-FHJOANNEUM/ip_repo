--
-- Dual-Port Block RAM with Two Write Ports
-- Correct Modelization with a Shared Variable
--
-- Download: http://www.xilinx.com/txpatches/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_16b.vhd
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
library work;
use work.busdef.ALL;
library std;
use std.textio.all;

entity dpram32_fileio is
   generic( 
      simulation_g    : boolean := false;
      save_filename_g : string  := "dpram32_dump.txt";
      load_filename_g : string  := "dpram32_dump.txt";
      addr_base_a_g   : std_logic_vector;
      addr_base_b_g   : std_logic_vector;
      addr_range_g    : std_logic_vector;
      addr_width_g    : integer := 8;                --width of address
      data_width_g    : integer := 32                --width of data
   );
   port( 
      clka      : in     std_logic;
      save2file : in     std_logic;
      load2mem  : in     std_logic;
      sbus_i_a  : in     sbus_i_t;
      sbus_i_b  : in     sbus_i_t;
      sbus_o_a  : out    sbus_o_t;
      sbus_o_b  : out    sbus_o_t
   );

-- Declarations

end dpram32_fileio ;

--
architecture rtl of dpram32_fileio is
  type ram_type is array (0 to 2**addr_width_g-1) of std_logic_vector(data_width_g-1 downto 0);
 -- type ram_type is array (0 to 2**10-1) of std_logic_vector(data_width_g-1 downto 0);
--  signal RAM : ram_type := (X"1122334400001111", X"2233445522223333",X"3344556644445555",X"4455667766667777",X"5566778888889999",X"66778899AAAABBBB",X"77889900CCCCDDDD",X"AABBCCDDEEEEFFFF",
--                                     others => X"ABCDEF0012345678");
  signal RAM : ram_type := ( 

 others => (others => '0'));
  signal RAM_file : ram_type := ( others => (others => '0'));
  
  signal ena   :    std_logic;
  signal enb   :    std_logic;
  signal wea   :    std_logic;
  signal addra :    std_logic_vector (addr_width_g-1 downto 0);
  signal addrb :    std_logic_vector (addr_width_g-1 downto 0);
  signal dia   :    std_logic_vector (data_width_g-1 downto 0);
  signal dib   :    std_logic_vector (data_width_g-1 downto 0);
  signal doa   :    std_logic_vector (data_width_g-1 downto 0);
  signal dob   :    std_logic_vector (data_width_g-1 downto 0);
  signal addrb_int: integer;
  signal ram_update: std_logic;
  signal q: std_logic;
  signal counter: integer;  
begin
  
  -- bus attachment --------------------------
  addra <= sbus_i_a.addr(addra'range);
  ena <= '1' when (sbus_i_a.addr >= addr_base_a_g) and sbus_i_a.addr < (addr_base_a_g + addr_range_g) else '0';
  wea <= sbus_i_a.we or ram_update;
  dia <= sbus_i_a.wdata;
  sbus_o_a.rdata <= doa when ena = '1' else (others => '0');
  sbus_o_a.ack <= ena;
 
  addrb <= sbus_i_b.addr(addrb'range);
  enb <= '1' when (sbus_i_b.addr >= addr_base_b_g) and sbus_i_b.addr < (addr_base_b_g + addr_range_g) else '0';
  dib <= sbus_i_b.wdata;
  sbus_o_b.rdata <= dob when enb = '1' else (others => '0');
  sbus_o_b.ack <= enb;
  
  process (CLKA)
  begin
    if CLKA'event and CLKA = '1' then
      if ENA = '1' then
        DOA <= RAM(conv_integer(ADDRA));
          if WEA = '1' then
            if ram_update = '1' then
              RAM <= RAM_file;
            else
              RAM(conv_integer(ADDRA)) <= DIA;
            end if;
          end if;
      end if;
    end if;
  end process;
  
  process (CLKA)
  begin
    if CLKA'event and CLKA = '1' then
      if ENB = '1' then
        DOB <= RAM(addrb_int);
      end if;
    end if;
  end process;
  
  addrb_int <= conv_integer(ADDRB);

g0: if simulation_g generate

  process (CLKA)
  variable q: std_logic := '0';
  begin
    if CLKA'event and CLKA = '1' then
      ram_update <=  load2mem and not q;
      q := load2mem;
    end if;
  end process;
   
    process
      variable RAM_v: std_logic_vector(data_width_g-1 downto 0);
      variable RAM_word: std_logic_vector(data_width_g/4-1 downto 0);
      file textfile: text is out save_filename_g;
      variable l: line;
      variable value: integer;
      variable space: character := ' ';
    begin
         if save2file = '1' and q  ='0' then
           for i in 0 to 2**conv_integer(addr_width_g)-1 loop            
               RAM_v := RAM(i);
               write(l,i);
               write(l,space);
              
               RAM_word := RAM_v(data_width_g-1 downto 3*data_width_g/4);
               write(l,conv_integer(RAM_word));
               write(l,space);
               
               RAM_word := RAM_v(3*data_width_g/4-1 downto 2*data_width_g/4);
               write(l,conv_integer(RAM_word));
               write(l,space);
               
               RAM_word := RAM_v(2*data_width_g/4-1 downto 1*data_width_g/4);
               write(l,conv_integer(RAM_word));
               write(l,space);
               
               RAM_word := RAM_v(1*data_width_g/4-1 downto 0*data_width_g/4);
               write(l,conv_integer(RAM_word));
                               
              writeline (textfile,l);              
            end loop;
         end if;
         q <= save2file;
         wait until clka ='1' and clka'event;
      end process;
      
    process
      variable RAM_v: std_logic_vector(data_width_g-1 downto 0);
      variable RAM_word: integer;
      file textfile: text is in load_filename_g;
      variable l: line;
      variable value: integer;
      variable i: integer;
      variable space: character := ' ';
      variable cnt: integer := 0;
    begin
         while not endfile(textfile) loop
               readline(textfile,l);
               read(l,i);
               read(l,space);
              
               read(l,RAM_word);
               read(l,space);
               RAM_v(data_width_g-1 downto 3*data_width_g/4) := conv_std_logic_vector(RAM_word,data_width_g/4);
               
               read(l,RAM_word);
               read(l,space);
               RAM_v(3*data_width_g/4-1 downto 2*data_width_g/4) := conv_std_logic_vector(RAM_word,data_width_g/4);
               
               read(l,RAM_word);
               read(l,space);
               RAM_v(2*data_width_g/4-1 downto 1*data_width_g/4) := conv_std_logic_vector(RAM_word,data_width_g/4);
               
               read(l,RAM_word);
               read(l,space);
               RAM_v(1*data_width_g/4-1 downto 0*data_width_g/4) := conv_std_logic_vector(RAM_word,data_width_g/4);
               RAM_file(i) <= RAM_v;
               cnt := cnt+1;
                              
            end loop;
         counter <= cnt;
         wait;
      end process;
      
 end generate g0;   
  
  
end architecture rtl;


