--
-- VHDL Architecture sbus_uart_lib.comp_int_dump.rtl
--
-- Created:
--          by - net.UNKNOWN (KPERSM7467)
--          at - 16:47:21 08.11.2018
--
-- using Mentor Graphics HDL Designer(TM) 2016.2 (Build 5)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comp_integrator is
  generic(dwidth_g: integer := 8);
  port( en: in std_logic;
        dump: in std_logic;
        reset: in std_logic;
        clk: in std_logic;
        int_val: out std_logic_vector(dwidth_g-1 downto 0)
      );
end entity comp_integrator;

--
architecture rtl of comp_integrator is
begin
        
end architecture rtl;

