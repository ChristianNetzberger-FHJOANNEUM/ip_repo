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

entity dpram_fileio is
   generic( 
      simulation_g    : boolean := false;
      hex_format_g    : boolean := true;
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

end dpram_fileio ;

--
architecture rtl of dpram_fileio is
  type ram_type is array (0 to 2**addr_width_g-1) of std_logic_vector(data_width_g-1 downto 0);
  signal RAM      : ram_type := ( others => (others => '0'));
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
   
  function nibble_to_hex(arg: std_logic_vector(3 downto 0)) return character is
     variable tmp: character;
  begin
      case arg is
        when "0000" => tmp := '0';
        when "0001" => tmp := '1';
        when "0010" => tmp := '2';
        when "0011" => tmp := '3';
        when "0100" => tmp := '4';
        when "0101" => tmp := '5';
        when "0110" => tmp := '6';
        when "0111" => tmp := '7';
        when "1000" => tmp := '8';
        when "1001" => tmp := '9';
        when "1010" => tmp := 'A';
        when "1011" => tmp := 'B';
        when "1100" => tmp := 'C';
        when "1101" => tmp := 'D';
        when "1110" => tmp := 'E';
        when "1111" => tmp := 'F';
        when others => tmp := 'X';
        end case;
        return tmp;
  end function nibble_to_hex;

  function hex_to_nibble(arg: character) return std_logic_vector is
     variable tmp: std_logic_vector(3 downto 0);
  begin
      case arg is
        when '0' => tmp := "0000";
        when '1' => tmp := "0001";
        when '2' => tmp := "0010";
        when '3' => tmp := "0011";
        when '4' => tmp := "0100";
        when '5' => tmp := "0101";
        when '6' => tmp := "0110";
        when '7' => tmp := "0111";
        when '8' => tmp := "1000";
        when '9' => tmp := "1001";
        when 'A' => tmp := "1010";
        when 'B' => tmp := "1011";
        when 'C' => tmp := "1100";
        when 'D' => tmp := "1101";
        when 'E' => tmp := "1110";
        when 'F' => tmp := "1111";
        when others => tmp := "XXXX";
        end case;
        return tmp;
  end function hex_to_nibble;
       
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
      if ENA = '1' or ram_update = '1' then
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
      variable RAM_nibble: std_logic_vector(3 downto 0);
      file textfile: text is out save_filename_g;
      variable l: line;
      variable value: integer;
      variable space: character := ' ';
      variable hex: character;
    begin
         if save2file = '1' and q  ='0' then
           for i in 0 to 2**conv_integer(addr_width_g)-1 loop            
               RAM_v := RAM(i);
               write(l,i);
               write(l,space);
               
               for i in data_width_g/4 downto 1 loop
                  RAM_nibble := RAM_v(4*i-1 downto 4*(i-1));
                  hex := nibble_to_hex(RAM_nibble);
                  if (hex_format_g) then              
                    write(l,hex);
                  else
                    write(l,conv_integer(RAM_nibble));
                    write(l,space); 
                  end if;
               end loop;
                                
              writeline (textfile,l);              
            end loop;
         end if;
         q <= save2file;
         wait until clka ='1' and clka'event;
      end process;
      
    -- read text file---------  
    process
      variable RAM_v: std_logic_vector(data_width_g-1 downto 0);
      variable RAM_nibble: integer;
      file textfile: text is in load_filename_g;
      variable l: line;
      variable value: integer;
      variable addr: integer;
      variable space: character := ' ';
      variable hex: character;
      variable cnt: integer := 0;
    begin
         while not endfile(textfile) loop
               readline(textfile,l);
               read(l,addr);
               read(l,space);
               RAM_v := (others => 'X');
               for i in data_width_g/4 downto 1 loop
                 if hex_format_g then
                    read(l,hex);
                    RAM_v(4*i-1 downto 4*(i-1)) := hex_to_nibble(hex);
                 else
                    read(l,RAM_nibble);
                    read(l,space);
                    RAM_v(4*i-1 downto 4*(i-1)) := conv_std_logic_vector(RAM_nibble,4);
                 end if;
               end loop;
               RAM_file(addr) <= RAM_v;
               cnt := cnt+1;
                              
            end loop;
         counter <= cnt;
         wait;
      end process;
      
 end generate g0;   
  
  
end architecture rtl;


