--
-- VHDL Architecture dic_axi_connector.dic_axi_connector_core.symbol
--
-- Created by Christian Netzberger
--   FH JOANNEUM
--   Inst. of Electronic Engineering
--          at - 12:03:01 11/21/15

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
library work;
use work.busdef.all;

entity top_axi_sbus_bridge is
   generic( 
      C_S00_AXI_ADDR_WIDTH   : integer := 18;
      C_S00_AXI_ARUSER_WIDTH : integer := 0;
      C_S00_AXI_AWUSER_WIDTH : integer := 0;
      C_S00_AXI_BUSER_WIDTH  : integer := 0;
      C_S00_AXI_DATA_WIDTH   : integer := 32;
      -- Users to add parameters here
      
      -- User parameters ends
      -- Do not modify the parameters beyond this line
      
      
      -- Parameters of Axi Slave Bus Interface S00_AXI
      C_S00_AXI_ID_WIDTH     : integer := 12;
      C_S00_AXI_RUSER_WIDTH  : integer := 0;
      C_S00_AXI_WUSER_WIDTH  : integer := 0;
      C_SLV_ADDR_WIDTH       : integer := 16;
      C_SLV_DATA_WIDTH       : integer := 32;
      C_CORE_CLOCK_FREQ      : integer := 100000000;
      hw_serial_number_g     : integer := 12;
      hw_version_g           : integer := 123
   );
   port( 
      bus0_sbus_ack    : in     std_logic;
      bus0_sbus_rdata  : in     std_logic_vector (31 downto 0);
      bus1_sbus_ack    : in     std_logic;
      bus1_sbus_rdata  : in     std_logic_vector (31 downto 0);
      bus2_sbus_ack    : in     std_logic;
      bus2_sbus_rdata  : in     std_logic_vector (31 downto 0);
      bus3_sbus_ack    : in     std_logic;
      bus3_sbus_rdata  : in     std_logic_vector (31 downto 0);
      -- Users to add ports here
      
      -- User ports ends
      -- Do not modify the ports beyond this line
      
      
      -- Ports of Axi Slave Bus Interface S00_AXI
      s00_axi_aclk     : in     std_logic;
      s00_axi_araddr   : in     std_logic_vector (C_S00_AXI_ADDR_WIDTH-1 downto 0);
      s00_axi_arburst  : in     std_logic_vector (1 downto 0);
      s00_axi_arcache  : in     std_logic_vector (3 downto 0);
      s00_axi_aresetn  : in     std_logic;
      s00_axi_arid     : in     std_logic_vector (C_S00_AXI_ID_WIDTH-1 downto 0);
      s00_axi_arlen    : in     std_logic_vector (7 downto 0);
      s00_axi_arlock   : in     std_logic;
      s00_axi_arprot   : in     std_logic_vector (2 downto 0);
      s00_axi_arqos    : in     std_logic_vector (3 downto 0);
      s00_axi_arregion : in     std_logic_vector (3 downto 0);
      s00_axi_arsize   : in     std_logic_vector (2 downto 0);
      s00_axi_aruser   : in     std_logic_vector (C_S00_AXI_ARUSER_WIDTH-1 downto 0);
      s00_axi_arvalid  : in     std_logic;
      s00_axi_awaddr   : in     std_logic_vector (C_S00_AXI_ADDR_WIDTH-1 downto 0);
      s00_axi_awburst  : in     std_logic_vector (1 downto 0);
      s00_axi_awcache  : in     std_logic_vector (3 downto 0);
      s00_axi_awid     : in     std_logic_vector (C_S00_AXI_ID_WIDTH-1 downto 0);
      s00_axi_awlen    : in     std_logic_vector (7 downto 0);
      s00_axi_awlock   : in     std_logic;
      s00_axi_awprot   : in     std_logic_vector (2 downto 0);
      s00_axi_awqos    : in     std_logic_vector (3 downto 0);
      s00_axi_awregion : in     std_logic_vector (3 downto 0);
      s00_axi_awsize   : in     std_logic_vector (2 downto 0);
      s00_axi_awuser   : in     std_logic_vector (C_S00_AXI_AWUSER_WIDTH-1 downto 0);
      s00_axi_awvalid  : in     std_logic;
      s00_axi_bready   : in     std_logic;
      s00_axi_rready   : in     std_logic;
      s00_axi_wdata    : in     std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
      s00_axi_wlast    : in     std_logic;
      s00_axi_wstrb    : in     std_logic_vector ((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
      s00_axi_wuser    : in     std_logic_vector (C_S00_AXI_WUSER_WIDTH-1 downto 0);
      s00_axi_wvalid   : in     std_logic;
      bus0_sbus_addr   : out    std_logic_vector (15 downto 0);
      bus0_sbus_rd     : out    std_logic;
      bus0_sbus_wdata  : out    std_logic_vector (31 downto 0);
      bus0_sbus_we     : out    std_logic;
      bus1_sbus_addr   : out    std_logic_vector (15 downto 0);
      bus1_sbus_rd     : out    std_logic;
      bus1_sbus_wdata  : out    std_logic_vector (31 downto 0);
      bus1_sbus_we     : out    std_logic;
      bus2_sbus_addr   : out    std_logic_vector (15 downto 0);
      bus2_sbus_rd     : out    std_logic;
      bus2_sbus_wdata  : out    std_logic_vector (31 downto 0);
      bus2_sbus_we     : out    std_logic;
      bus3_sbus_addr   : out    std_logic_vector (15 downto 0);
      bus3_sbus_rd     : out    std_logic;
      bus3_sbus_wdata  : out    std_logic_vector (31 downto 0);
      bus3_sbus_we     : out    std_logic;
      -- Users to add ports here
      clk_o            : out    std_logic;
      irq_o            : out    std_logic;
      reset_o          : out    std_logic;
      s00_axi_arready  : out    std_logic;
      s00_axi_awready  : out    std_logic;
      s00_axi_bid      : out    std_logic_vector (C_S00_AXI_ID_WIDTH-1 downto 0);
      s00_axi_bresp    : out    std_logic_vector (1 downto 0);
      s00_axi_buser    : out    std_logic_vector (C_S00_AXI_BUSER_WIDTH-1 downto 0);
      s00_axi_bvalid   : out    std_logic;
      s00_axi_rdata    : out    std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
      s00_axi_rid      : out    std_logic_vector (C_S00_AXI_ID_WIDTH-1 downto 0);
      s00_axi_rlast    : out    std_logic;
      s00_axi_rresp    : out    std_logic_vector (1 downto 0);
      s00_axi_ruser    : out    std_logic_vector (C_S00_AXI_RUSER_WIDTH-1 downto 0);
      s00_axi_rvalid   : out    std_logic;
      s00_axi_wready   : out    std_logic;
      sync_o           : out    std_logic_vector (7 downto 0)
   );

-- Declarations

end top_axi_sbus_bridge ;
--
-- VHDL Architecture dic_axi_connector.dic_axi_connector_core.struct
--
-- Created by Christian Netzberger
--   FH JOANNEUM
--   Inst. of Electronic Engineering
--          at - 12:03:07 11/21/15

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.busdef.all;

library dic_axi_connector;

architecture struct of top_axi_sbus_bridge is

   -- Architecture declarations

   -- Internal signal declarations
   -- Users to add ports here
   signal clk              : std_logic;
   signal cnt_tc           : std_logic;
   signal hi               : std_logic;
   signal irq_clear        : std_logic;
   signal irq_flag         : std_logic;
   signal lo               : std_logic;
   signal millisec_tc      : std_logic;
   signal reg00            : std_logic_vector(31 downto 0);
   signal reg00_in         : std_logic_vector(31 downto 0);
   signal reg01            : std_logic_vector(31 downto 0);
   signal reg01_in         : std_logic_vector(31 downto 0);
   signal reg02            : std_logic_vector(31 downto 0);
   signal reg02_in         : std_logic_vector(31 downto 0);
   signal reg03            : std_logic_vector(31 downto 0);
   signal reg03_in         : std_logic_vector(31 downto 0);
   signal reg04            : std_logic_vector(31 downto 0);
   signal reg05            : std_logic_vector(31 downto 0);
   signal reg06            : std_logic_vector(31 downto 0);
   signal reg07            : std_logic_vector(31 downto 0);
   signal reg07_in         : std_logic_vector(31 downto 0);
   signal reg08            : std_logic_vector(31 downto 0);
   signal reg08_in         : std_logic_vector(31 downto 0);
   signal reg09            : std_logic_vector(31 downto 0);
   signal reg09_in         : std_logic_vector(31 downto 0);
   signal reg0A            : std_logic_vector(31 downto 0);
   signal reg0A_in         : std_logic_vector(31 downto 0);
   signal reg0B            : std_logic_vector(31 downto 0);
   signal reg0B_in         : std_logic_vector(31 downto 0);
   signal reg0C            : std_logic_vector(31 downto 0);
   signal reg0C_in         : std_logic_vector(31 downto 0);
   signal reg0D            : std_logic_vector(31 downto 0);
   signal reg0D_in         : std_logic_vector(31 downto 0);
   signal reg0E            : std_logic_vector(31 downto 0);
   signal reg0E_in         : std_logic_vector(31 downto 0);
   signal reg0F            : std_logic_vector(31 downto 0);
   signal reg0F_in         : std_logic_vector(31 downto 0);
   signal reg_din          : std_logic_vector( 16*32-1 downto 0 );             -- parallel input for readback
   signal reg_dout         : std_logic_vector( 16*32-1 downto 0 );             -- parallel output of all registers
   signal reg_we           : std_logic_vector( 15 downto 0);                   -- active high write strobes
   signal reset            : std_logic;
   signal sbus_i           : sbus_i_t;
   signal sbus_i_addr      : std_logic_vector(C_SLV_ADDR_WIDTH-1 downto 0);
   signal sbus_i_in        : sbus_i_t;
   signal sbus_i_rd        : std_logic;
   signal sbus_i_wdata     : std_logic_vector(C_SLV_DATA_WIDTH-1 downto 0);
   --      sbus_i         : out    sbus_i_t;
--      sbus_o         : in     sbus_o_t;
--      dummy          : out    std_logic;
   signal sbus_i_we        : std_logic;
   signal sbus_o_0         : sbus_o_t;
   signal sbus_o_1         : sbus_o_t;
   signal sbus_o_2         : sbus_o_t;
   signal sbus_o_3         : sbus_o_t;
   signal sbus_o_4         : sbus_o_t;
   signal sbus_o_ack       : std_logic;
   signal sbus_o_mux       : sbus_o_t;
   signal sbus_o_rdata     : std_logic_vector(C_SLV_DATA_WIDTH-1 downto 0);
   signal timer_cnt_enable : std_logic;
   signal timer_modulus    : std_logic_vector(31 downto 0);
   signal timer_out        : std_logic_vector(6 downto 0);
   signal timestamp        : std_logic_vector(31 downto 0);


-- #pragma translate_off
attribute mark_debug : string;
attribute mark_debug of sbus_i_in: signal is "true";
attribute mark_debug of sbus_o_mux: signal is "true";
-- #pragma translate_on

   -- Component Declarations
   component S00_AXI
   generic (
      -- Users to add parameters here
      pipeline_g           : boolean := false;
      C_SLV_ADDR_WIDTH     : integer := 32;
      C_SLV_DATA_WIDTH     : integer := 32;
      -- User parameters ends
      -- Do not modify the parameters beyond this line
      
      -- Width of ID for for write address, write data, read address and read data
      C_S_AXI_ID_WIDTH     : integer := 1;
      -- Width of S_AXI data bus
      C_S_AXI_DATA_WIDTH   : integer := 32;
      -- Width of S_AXI address bus
      C_S_AXI_ADDR_WIDTH   : integer := 10;
      -- Width of optional user defined signal in write address channel
      C_S_AXI_AWUSER_WIDTH : integer := 1;
      -- Width of optional user defined signal in read address channel
      C_S_AXI_ARUSER_WIDTH : integer := 1;
      -- Width of optional user defined signal in write data channel
      C_S_AXI_WUSER_WIDTH  : integer := 1;
      -- Width of optional user defined signal in read data channel
      C_S_AXI_RUSER_WIDTH  : integer := 1;
      -- Width of optional user defined signal in write response channel
      C_S_AXI_BUSER_WIDTH  : integer := 1
   );
   port (
      -- Users to add ports here
      clk_o          : out    std_logic ;
      reset_o        : out    std_logic ;
      sbus_i_we      : out    std_logic ;
      sbus_i_rd      : out    std_logic ;
      sbus_o_ack     : in     std_logic ;
      sbus_i_addr    : out    std_logic_vector (C_SLV_ADDR_WIDTH-1 downto 0);
      sbus_i_wdata   : out    std_logic_vector (C_SLV_DATA_WIDTH-1 downto 0);
      sbus_o_rdata   : in     std_logic_vector (C_SLV_DATA_WIDTH-1 downto 0);
      -- User ports ends
      -- Do not modify the ports beyond this line
      
      -- Global Clock Signal
      S_AXI_ACLK     : in     std_logic ;
      -- Global Reset Signal. This Signal is Active LOW
      S_AXI_ARESETN  : in     std_logic ;
      -- Write Address ID
      S_AXI_AWID     : in     std_logic_vector (C_S_AXI_ID_WIDTH-1 downto 0);
      -- Write address
      S_AXI_AWADDR   : in     std_logic_vector (C_S_AXI_ADDR_WIDTH-1 downto 0);
      -- Burst length. The burst length gives the exact number of transfers in a burst
      S_AXI_AWLEN    : in     std_logic_vector (7 downto 0);
      -- Burst size. This signal indicates the size of each transfer in the burst
      S_AXI_AWSIZE   : in     std_logic_vector (2 downto 0);
      -- Burst type. The burst type and the size information,
        -- determine how the address for each transfer within the burst is calculated.
      S_AXI_AWBURST  : in     std_logic_vector (1 downto 0);
      -- Lock type. Provides additional information about the
        -- atomic characteristics of the transfer.
      S_AXI_AWLOCK   : in     std_logic ;
      -- Memory type. This signal indicates how transactions
        -- are required to progress through a system.
      S_AXI_AWCACHE  : in     std_logic_vector (3 downto 0);
      -- Protection type. This signal indicates the privilege
        -- and security level of the transaction, and whether
        -- the transaction is a data access or an instruction access.
      S_AXI_AWPROT   : in     std_logic_vector (2 downto 0);
      -- Quality of Service, QoS identifier sent for each
        -- write transaction.
      S_AXI_AWQOS    : in     std_logic_vector (3 downto 0);
      -- Region identifier. Permits a single physical interface
        -- on a slave to be used for multiple logical interfaces.
      S_AXI_AWREGION : in     std_logic_vector (3 downto 0);
      -- Optional User-defined signal in the write address channel.
      S_AXI_AWUSER   : in     std_logic_vector (C_S_AXI_AWUSER_WIDTH-1 downto 0);
      -- Write address valid. This signal indicates that
        -- the channel is signaling valid write address and
        -- control information.
      S_AXI_AWVALID  : in     std_logic ;
      -- Write address ready. This signal indicates that
        -- the slave is ready to accept an address and associated
        -- control signals.
      S_AXI_AWREADY  : out    std_logic ;
      -- Write Data
      S_AXI_WDATA    : in     std_logic_vector (C_S_AXI_DATA_WIDTH-1 downto 0);
      -- Write strobes. This signal indicates which byte
        -- lanes hold valid data. There is one write strobe
        -- bit for each eight bits of the write data bus.
      S_AXI_WSTRB    : in     std_logic_vector ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
      -- Write last. This signal indicates the last transfer
        -- in a write burst.
      S_AXI_WLAST    : in     std_logic ;
      -- Optional User-defined signal in the write data channel.
      S_AXI_WUSER    : in     std_logic_vector (C_S_AXI_WUSER_WIDTH-1 downto 0);
      -- Write valid. This signal indicates that valid write
        -- data and strobes are available.
      S_AXI_WVALID   : in     std_logic ;
      -- Write ready. This signal indicates that the slave
        -- can accept the write data.
      S_AXI_WREADY   : out    std_logic ;
      -- Response ID tag. This signal is the ID tag of the
        -- write response.
      S_AXI_BID      : out    std_logic_vector (C_S_AXI_ID_WIDTH-1 downto 0);
      -- Write response. This signal indicates the status
        -- of the write transaction.
      S_AXI_BRESP    : out    std_logic_vector (1 downto 0);
      -- Optional User-defined signal in the write response channel.
      S_AXI_BUSER    : out    std_logic_vector (C_S_AXI_BUSER_WIDTH-1 downto 0);
      -- Write response valid. This signal indicates that the
        -- channel is signaling a valid write response.
      S_AXI_BVALID   : out    std_logic ;
      -- Response ready. This signal indicates that the master
        -- can accept a write response.
      S_AXI_BREADY   : in     std_logic ;
      -- Read address ID. This signal is the identification
        -- tag for the read address group of signals.
      S_AXI_ARID     : in     std_logic_vector (C_S_AXI_ID_WIDTH-1 downto 0);
      -- Read address. This signal indicates the initial
        -- address of a read burst transaction.
      S_AXI_ARADDR   : in     std_logic_vector (C_S_AXI_ADDR_WIDTH-1 downto 0);
      -- Burst length. The burst length gives the exact number of transfers in a burst
      S_AXI_ARLEN    : in     std_logic_vector (7 downto 0);
      -- Burst size. This signal indicates the size of each transfer in the burst
      S_AXI_ARSIZE   : in     std_logic_vector (2 downto 0);
      -- Burst type. The burst type and the size information,
        -- determine how the address for each transfer within the burst is calculated.
      S_AXI_ARBURST  : in     std_logic_vector (1 downto 0);
      -- Lock type. Provides additional information about the
        -- atomic characteristics of the transfer.
      S_AXI_ARLOCK   : in     std_logic ;
      -- Memory type. This signal indicates how transactions
        -- are required to progress through a system.
      S_AXI_ARCACHE  : in     std_logic_vector (3 downto 0);
      -- Protection type. This signal indicates the privilege
        -- and security level of the transaction, and whether
        -- the transaction is a data access or an instruction access.
      S_AXI_ARPROT   : in     std_logic_vector (2 downto 0);
      -- Quality of Service, QoS identifier sent for each
        -- read transaction.
      S_AXI_ARQOS    : in     std_logic_vector (3 downto 0);
      -- Region identifier. Permits a single physical interface
        -- on a slave to be used for multiple logical interfaces.
      S_AXI_ARREGION : in     std_logic_vector (3 downto 0);
      -- Optional User-defined signal in the read address channel.
      S_AXI_ARUSER   : in     std_logic_vector (C_S_AXI_ARUSER_WIDTH-1 downto 0);
      -- Write address valid. This signal indicates that
        -- the channel is signaling valid read address and
        -- control information.
      S_AXI_ARVALID  : in     std_logic ;
      -- Read address ready. This signal indicates that
        -- the slave is ready to accept an address and associated
        -- control signals.
      S_AXI_ARREADY  : out    std_logic ;
      -- Read ID tag. This signal is the identification tag
        -- for the read data group of signals generated by the slave.
      S_AXI_RID      : out    std_logic_vector (C_S_AXI_ID_WIDTH-1 downto 0);
      -- Read Data
      S_AXI_RDATA    : out    std_logic_vector (C_S_AXI_DATA_WIDTH-1 downto 0);
      -- Read response. This signal indicates the status of
        -- the read transfer.
      S_AXI_RRESP    : out    std_logic_vector (1 downto 0);
      -- Read last. This signal indicates the last transfer
        -- in a read burst.
      S_AXI_RLAST    : out    std_logic ;
      -- Optional User-defined signal in the read address channel.
      S_AXI_RUSER    : out    std_logic_vector (C_S_AXI_RUSER_WIDTH-1 downto 0);
      -- Read valid. This signal indicates that the channel
        -- is signaling the required read data.
      S_AXI_RVALID   : out    std_logic ;
      -- Read ready. This signal indicates that the master can
        -- accept the read data and response information.
      S_AXI_RREADY   : in     std_logic 
   );
   end component;
   component cnt_modulus
   generic (
      n_dout_g : integer := 8;
      module_g : integer := 256
   );
   port (
      clk    : in     std_logic ;
      enable : in     std_logic ;
      reset  : in     std_logic ;
      dout   : out    std_logic_vector (n_dout_g-1 downto 0);
      cnt_tc : out    std_logic 
   );
   end component;
   component cnt_modulus_c
   generic (
      width_g : integer := 8
   );
   port (
      clk     : in     std_logic ;
      reset   : in     std_logic ;
      enable  : in     std_logic ;
      modulus : in     std_logic_vector (width_g-1 downto 0);
      cnt_tc  : out    std_logic ;
      cnt     : out    std_logic_vector (width_g-1 downto 0)
   );
   end component;
   component register_array
   generic (
      addr_width_g : integer := 8;      --width of address
      data_width_g : integer := 8;      --width of data
      addr_base_g  : std_logic_vector;
      addr_range_g : std_logic_vector;
      nregs_g      : integer := 16      --number of registers
   );
   port (
      sbus_o   : out    sbus_o_t ;
      sbus_i   : in     sbus_i_t ;
      reg_din  : in     std_logic_vector ( nregs_g*data_width_g-1 downto 0 ); -- parallel input for readback
      reg_dout : out    std_logic_vector ( nregs_g*data_width_g-1 downto 0 ); -- parallel output of all registers
      we       : out    std_logic_vector ( nregs_g-1 downto 0);               -- active high write strobes
      reset    : in     std_logic ;                                           -- synchronous, active high reset
      clk      : in     std_logic                                             -- register clock
   );
   end component;
   component sbus_mux3
   port (
      clk         : in     std_logic ;
      sbus_i_in   : in     sbus_i_t ;
      sbus_i_out  : out    sbus_i_t ;
      sbus_o_mux  : out    sbus_o_t ;
      sbus_o_0    : in     sbus_o_t ;
      sbus_o_1    : in     sbus_o_t ;
      sbus_o_2    : in     sbus_o_t ;
      sbus_o_3    : in     sbus_o_t ;
      sbus_o_4    : in     sbus_o_t ;
      sbus_o_null : out    sbus_o_t 
   );
   end component;

   -- Optional embedded configurations
   -- pragma synthesis_off
   for all : S00_AXI use entity dic_axi_connector.S00_AXI;
   for all : cnt_modulus use entity dic_axi_connector.cnt_modulus;
   for all : cnt_modulus_c use entity dic_axi_connector.cnt_modulus_c;
   for all : register_array use entity dic_axi_connector.register_array;
   for all : sbus_mux3 use entity dic_axi_connector.sbus_mux3;
   -- pragma synthesis_on


begin
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 eb1
   bus0_sbus_addr <= sbus_i.addr;
   bus0_sbus_wdata <= sbus_i.wdata;
   bus0_sbus_we <= sbus_i.we;
   bus0_sbus_rd <= sbus_i.rd;
   sbus_o_0.rdata <= bus0_sbus_rdata;
   sbus_o_0.ack <= bus0_sbus_ack;          
   
   bus1_sbus_addr <= sbus_i.addr;
   bus1_sbus_wdata <= sbus_i.wdata;
   bus1_sbus_we <= sbus_i.we;
   bus1_sbus_rd <= sbus_i.rd;
   sbus_o_1.rdata <= bus1_sbus_rdata;
   sbus_o_1.ack <= bus1_sbus_ack;     
    
   bus2_sbus_addr <= sbus_i.addr;
   bus2_sbus_wdata <= sbus_i.wdata;
   bus2_sbus_we <= sbus_i.we;
   bus2_sbus_rd <= sbus_i.rd;
   sbus_o_2.rdata <= bus2_sbus_rdata;
   sbus_o_2.ack <= bus2_sbus_ack;          
   
   bus3_sbus_addr <= sbus_i.addr;
   bus3_sbus_wdata <= sbus_i.wdata;
   bus3_sbus_we <= sbus_i.we;
   bus3_sbus_rd <= sbus_i.rd;
   sbus_o_3.rdata <= bus3_sbus_rdata;
   sbus_o_3.ack <= bus3_sbus_ack;        
   
   reset_o <= reset;
   clk_o <= clk;                           

   -- HDL Embedded Text Block 2 eb2
   ---slave bus attachment---
   sbus_i_in.addr   <= sbus_i_addr;
   sbus_i_in.wdata <= sbus_i_wdata;
   sbus_i_in.rd <= sbus_i_rd;
   sbus_i_in.we <= sbus_i_we;
   sbus_o_ack <= sbus_o_mux.ack;
   sbus_o_rdata <= sbus_o_mux.rdata;
                                      

   -- HDL Embedded Text Block 3 reg_slice1
   --slice registers from vector---------------
   reg00 <= reg_dout( 0*32+31 downto 0*32);
   reg01 <= reg_dout( 1*32+31 downto 1*32);
   reg02 <= reg_dout( 2*32+31 downto 2*32);
   reg03 <= reg_dout( 3*32+31 downto 3*32);
   reg04 <= reg_dout( 4*32+31 downto 4*32);
   reg05 <= reg_dout( 5*32+31 downto 5*32);
   reg06 <= reg_dout( 6*32+31 downto 6*32);
   reg07 <= reg_dout( 7*32+31 downto 7*32);
   reg08 <= reg_dout( 8*32+31 downto 8*32);
   reg09 <= reg_dout( 9*32+31 downto 9*32);
   reg0A <= reg_dout( 10*32+31 downto 10*32);
   reg0B <= reg_dout( 11*32+31 downto 11*32);
   reg0C <= reg_dout( 12*32+31 downto 12*32);
   reg0D <= reg_dout( 13*32+31 downto 13*32);
   reg0E <= reg_dout( 14*32+31 downto 14*32);
   reg0F <= reg_dout( 15*32+31 downto 15*32);
   
   ---readback register values----
   process(clk)
   begin
      if rising_edge(clk) then
            -- default assignment----------
            reg_din <= reg_dout; 
           --readback registers-----
            reg_din(0*32+31 downto 0*32) <= reg00_in;
            reg_din(1*32+31 downto 1*32) <= reg01_in;
   --         reg_din(2*32+31 downto 2*32) <= reg02_in;
    --        reg_din(8*32+31 downto 8*32) <= reg08_in;
    --        reg_din(9*32+31 downto 9*32) <= reg09_in;
   --         reg_din(10*32+31 downto 10*32) <= reg0A_in;
   --        reg_din(11*32+31 downto 11*32) <= reg0B_in;
   --         reg_din(12*32+31 downto 12*32) <= reg0C_in;
   --         reg_din(13*32+31 downto 13*32) <= reg0D_in;
   --         reg_din(14*32+31 downto 14*32) <= reg0E_in;
   --         reg_din(15*32+31 downto 15*32) <= reg0F_in;
      end if;
   end process;
                                    

   -- HDL Embedded Text Block 4 eb3
   process(clk)
   variable q: std_logic_vector(6 downto 0);
   begin
      if rising_edge(clk) then
         sync_o(7 downto 1) <= timer_out and not q;
         q := timer_out;
         sync_o(0) <= cnt_tc;
      end if;
   end process;                       

   -- HDL Embedded Text Block 5 eb5
   process(clk)
   begin
      if rising_edge(clk) then
          if reset = '1' or irq_clear='1'  then
             irq_flag<= '0';
          elsif cnt_tc = '1' then
             irq_flag <= '1';
          end if;
      end if;
   end process;   
   
   irq_o <= irq_flag;                  

   -- HDL Embedded Text Block 6 regs1
   -----register assignments-----
   --REGISTER 0
   reg00_in <= conv_std_logic_vector(hw_serial_number_g,16) & conv_std_logic_vector(hw_version_g,16);
   --REGISTER 1
   reg01_in <= timestamp;
   --REGISTER 2
   irq_clear<= reg_we(2) and reg02(0);   
   reg02_in <= reg02(31 downto 1) & irq_flag; 
   --REGISTER 3
   timer_cnt_enable <= '0' when reg03 = 0 else '1'; 
   timer_modulus <= reg03; --conv_std_logic_vector(125,32);    
   --REGISTER 4
   --REGISTER 5
   --REGISTER 6
   --REGISTER 7 
   --REGISTER 8

   -- HDL Embedded Text Block 7 eb4
   ----concat readable registers-----

   -- HDL Embedded Text Block 8 constant_values1
   -- constant logic values
   hi <= '1';
   lo <= '0';                                     


   -- Instance port mappings.
   i_S00_AXI : S00_AXI
      generic map (
         -- Users to add parameters here
         pipeline_g           => false,
         C_SLV_ADDR_WIDTH     => C_SLV_ADDR_WIDTH,
         C_SLV_DATA_WIDTH     => C_SLV_DATA_WIDTH,
         -- User parameters ends
         -- Do not modify the parameters beyond this line
         
         -- Width of ID for for write address, write data, read address and read data
         C_S_AXI_ID_WIDTH     => C_S00_AXI_ID_WIDTH,
         -- Width of S_AXI data bus
         C_S_AXI_DATA_WIDTH   => C_S00_AXI_DATA_WIDTH,
         -- Width of S_AXI address bus
         C_S_AXI_ADDR_WIDTH   => C_S00_AXI_ADDR_WIDTH,
         -- Width of optional user defined signal in write address channel
         C_S_AXI_AWUSER_WIDTH => C_S00_AXI_AWUSER_WIDTH,
         -- Width of optional user defined signal in read address channel
         C_S_AXI_ARUSER_WIDTH => C_S00_AXI_ARUSER_WIDTH,
         -- Width of optional user defined signal in write data channel
         C_S_AXI_WUSER_WIDTH  => C_S00_AXI_WUSER_WIDTH,
         -- Width of optional user defined signal in read data channel
         C_S_AXI_RUSER_WIDTH  => C_S00_AXI_RUSER_WIDTH,
         -- Width of optional user defined signal in write response channel
         C_S_AXI_BUSER_WIDTH  => C_S00_AXI_BUSER_WIDTH
      )
      port map (
         clk_o          => clk,
         reset_o        => reset,
         sbus_i_we      => sbus_i_we,
         sbus_i_rd      => sbus_i_rd,
         sbus_o_ack     => sbus_o_ack,
         sbus_i_addr    => sbus_i_addr,
         sbus_i_wdata   => sbus_i_wdata,
         sbus_o_rdata   => sbus_o_rdata,
         S_AXI_ACLK     => s00_axi_aclk,
         S_AXI_ARESETN  => s00_axi_aresetn,
         S_AXI_AWID     => s00_axi_awid,
         S_AXI_AWADDR   => s00_axi_awaddr,
         S_AXI_AWLEN    => s00_axi_awlen,
         S_AXI_AWSIZE   => s00_axi_awsize,
         S_AXI_AWBURST  => s00_axi_awburst,
         S_AXI_AWLOCK   => s00_axi_awlock,
         S_AXI_AWCACHE  => s00_axi_awcache,
         S_AXI_AWPROT   => s00_axi_awprot,
         S_AXI_AWQOS    => s00_axi_awqos,
         S_AXI_AWREGION => s00_axi_awregion,
         S_AXI_AWUSER   => s00_axi_awuser,
         S_AXI_AWVALID  => s00_axi_awvalid,
         S_AXI_AWREADY  => s00_axi_awready,
         S_AXI_WDATA    => s00_axi_wdata,
         S_AXI_WSTRB    => s00_axi_wstrb,
         S_AXI_WLAST    => s00_axi_wlast,
         S_AXI_WUSER    => s00_axi_wuser,
         S_AXI_WVALID   => s00_axi_wvalid,
         S_AXI_WREADY   => s00_axi_wready,
         S_AXI_BID      => s00_axi_bid,
         S_AXI_BRESP    => s00_axi_bresp,
         S_AXI_BUSER    => s00_axi_buser,
         S_AXI_BVALID   => s00_axi_bvalid,
         S_AXI_BREADY   => s00_axi_bready,
         S_AXI_ARID     => s00_axi_arid,
         S_AXI_ARADDR   => s00_axi_araddr,
         S_AXI_ARLEN    => s00_axi_arlen,
         S_AXI_ARSIZE   => s00_axi_arsize,
         S_AXI_ARBURST  => s00_axi_arburst,
         S_AXI_ARLOCK   => s00_axi_arlock,
         S_AXI_ARCACHE  => s00_axi_arcache,
         S_AXI_ARPROT   => s00_axi_arprot,
         S_AXI_ARQOS    => s00_axi_arqos,
         S_AXI_ARREGION => s00_axi_arregion,
         S_AXI_ARUSER   => s00_axi_aruser,
         S_AXI_ARVALID  => s00_axi_arvalid,
         S_AXI_ARREADY  => s00_axi_arready,
         S_AXI_RID      => s00_axi_rid,
         S_AXI_RDATA    => s00_axi_rdata,
         S_AXI_RRESP    => s00_axi_rresp,
         S_AXI_RLAST    => s00_axi_rlast,
         S_AXI_RUSER    => s00_axi_ruser,
         S_AXI_RVALID   => s00_axi_rvalid,
         S_AXI_RREADY   => s00_axi_rready
      );
   U_4 : cnt_modulus
      generic map (
         n_dout_g => log2(C_CORE_CLOCK_FREQ/1000),
         module_g => C_CORE_CLOCK_FREQ/1000
      )
      port map (
         clk    => clk,
         enable => hi,
         reset  => reset,
         dout   => open,
         cnt_tc => millisec_tc
      );
   U_5 : cnt_modulus
      generic map (
         n_dout_g => 32,
         module_g => 2**30
      )
      port map (
         clk    => clk,
         enable => millisec_tc,
         reset  => reset,
         dout   => timestamp,
         cnt_tc => open
      );
   U_6 : cnt_modulus
      generic map (
         n_dout_g => 7,
         module_g => 2**7
      )
      port map (
         clk    => clk,
         enable => cnt_tc,
         reset  => reset,
         dout   => timer_out,
         cnt_tc => open
      );
   U_2 : cnt_modulus_c
      generic map (
         width_g => 32
      )
      port map (
         clk     => clk,
         reset   => reset,
         enable  => timer_cnt_enable,
         modulus => timer_modulus,
         cnt_tc  => cnt_tc,
         cnt     => open
      );
   U_0 : register_array
      generic map (
         addr_width_g => 16,         --width of address
         data_width_g => 32,         --width of data
         addr_base_g  => X"0000",
         addr_range_g => X"0010",
         nregs_g      => 16          --number of registers
      )
      port map (
         sbus_o   => sbus_o_4,
         sbus_i   => sbus_i,
         reg_din  => reg_din,
         reg_dout => reg_dout,
         we       => reg_we,
         reset    => reset,
         clk      => clk
      );
   U_3 : sbus_mux3
      port map (
         clk         => clk,
         sbus_i_in   => sbus_i_in,
         sbus_i_out  => sbus_i,
         sbus_o_mux  => sbus_o_mux,
         sbus_o_0    => sbus_o_0,
         sbus_o_1    => sbus_o_1,
         sbus_o_2    => sbus_o_2,
         sbus_o_3    => sbus_o_3,
         sbus_o_4    => sbus_o_4,
         sbus_o_null => open
      );

end struct;
