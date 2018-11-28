--
-- VHDL Package Body dev_lib.busdef
--
-- Created:
--          by - net.UNKNOWN (KPERSM4268)
--          at - 14:44:12 10.03.2011
--
-- using Mentor Graphics HDL Designer(TM) 2010.2 (Build 21)
--
PACKAGE BODY busdef IS
  
    
-------------------------------------------------------------------------------
-- Function log2 -- returns number of bits needed to encode x choices
--   x = 0  returns 0
--   x = 1  returns 0
--   x = 2  returns 1
--   x = 4  returns 2, etc.
-------------------------------------------------------------------------------
--
function log2(x : natural) return integer is
  variable i  : integer := 0; 
  variable val: integer := 1;
begin 
  if x = 0 then return 0;
  else
    for j in 0 to 29 loop -- for loop for XST 
      if val >= x then null; 
      else
        i := i+1;
        val := val*2;
      end if;
    end loop;
    assert val >= x
      report "Function log2 received argument larger" &
             " than its capability of 2^30. "
      severity failure;
    return i;
  end if;  
end function log2; 

function twosc  (arg: std_logic_vector) return std_logic_vector is
variable tmp: std_logic_vector(arg'length-1 downto 0);
begin
   tmp := arg;  
   tmp(tmp'left) := not tmp(tmp'left);
   return tmp;
end function twosc;

function exps(arg: std_logic_vector; length:integer) return std_logic_vector is
variable tmp: std_logic_vector(length-1 downto 0);
begin
    tmp := (others => arg(arg'left));
    tmp(arg'length-1 downto 0) := arg;
   return(tmp);
end function exps;

function conv_real(arg: std_logic_vector) return real is
variable tmp: real;
begin
  tmp := 0.0;
  for i in arg'range loop
    tmp := tmp*2.0;
    if arg(i) = '1' then
      tmp := tmp + 1.0;
    end if;
  end loop;
  return tmp; 
end function conv_real;

 -- function to convert real to std_logic_vector ------------------------------------ 
  function conv_std_logic_vector(arg: real; size: integer) return std_logic_vector is
  	variable result: std_logic_vector(size-1 downto 0);
  	variable temp: real;
  	-- synopsys built_in syn_integer_to_signed
  	-- synopsys subpgm_id 381
  begin
  	-- synopsys synthesis_off
  	temp := arg + 1.0;
  	if temp < 0.0 then
  	   temp := 0.0;
  	elsif temp >= 2.0 then
  	   temp := 1.99999999;
  	end if;      
  	for i in size-1 downto 0 loop
              if (temp >= 1.0) then
  		result(i) := '1';
  	    else 
  		result(i) := '0';
  	    end if;
  	    if temp >= 1.0 then
  		temp := temp - 1.0;
  	    end if;
  	    temp := temp * 2.0;
  	end loop;
  	result(result'left) := not result(result'left);
  	-- synopsys synthesis_on
  	return result;
  end;


END busdef;
