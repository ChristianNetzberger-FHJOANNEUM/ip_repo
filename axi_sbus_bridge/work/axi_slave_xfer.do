onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_aclk
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arburst
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arcache
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_aresetn
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arlen
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arlock
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arprot
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arqos
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arregion
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arsize
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_aruser
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awburst
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awcache
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awlen
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awlock
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awprot
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awqos
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awregion
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awsize
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awuser
add wave -noupdate -divider {Read Xfer}
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/clk
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_araddr
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arvalid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_arready
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_rlast
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_rvalid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_rdata
add wave -noupdate -divider {SBUS read xfer}
add wave -noupdate -label addr -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_i.addr
add wave -noupdate -label rdata -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_o_mux.rdata
add wave -noupdate -label rd -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_i_in.rd
add wave -noupdate -label ack -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_o_mux.ack
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg00
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg01
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg02
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg03
add wave -noupdate -divider {AXI Write Xfer}
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/clk
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awaddr
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awvalid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_awready
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_wdata
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_wvalid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_wlast
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_wstrb(0)
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_wready
add wave -noupdate -divider {SBUS write xfer}
add wave -noupdate -label addr -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_i_in.addr
add wave -noupdate -label wdata -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_i_in.wdata
add wave -noupdate -label we -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_i_in.we
add wave -noupdate -label ack -radix hexadecimal -radixenum numeric /tb_top/U_0/sbus_o_mux.ack
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg00
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg01
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg02
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/U_0/reg03
add wave -noupdate -divider <NULL>
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_bid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_bready
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_bresp
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_buser
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_bvalid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_rid
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_rready
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_rresp
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_ruser
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_wstrb
add wave -noupdate -radix hexadecimal -radixenum numeric /tb_top/s00_axi_wuser
add wave -noupdate -radix hexadecimal -childformat {{/tb_top/U_0/sbus_i_in.addr -radix hexadecimal} {/tb_top/U_0/sbus_i_in.wdata -radix hexadecimal} {/tb_top/U_0/sbus_i_in.we -radix hexadecimal} {/tb_top/U_0/sbus_i_in.rd -radix hexadecimal}} -radixenum numeric -expand -subitemconfig {/tb_top/U_0/sbus_i_in.addr {-height 15 -radix hexadecimal -radixenum numeric} /tb_top/U_0/sbus_i_in.wdata {-height 15 -radix hexadecimal -radixenum numeric} /tb_top/U_0/sbus_i_in.we {-height 15 -radix hexadecimal -radixenum numeric} /tb_top/U_0/sbus_i_in.rd {-height 15 -radix hexadecimal -radixenum numeric}} /tb_top/U_0/sbus_i_in
add wave -noupdate -radix hexadecimal -childformat {{/tb_top/U_0/sbus_o_mux.rdata -radix hexadecimal} {/tb_top/U_0/sbus_o_mux.ack -radix hexadecimal}} -radixenum numeric -expand -subitemconfig {/tb_top/U_0/sbus_o_mux.rdata {-height 15 -radix hexadecimal -radixenum numeric} /tb_top/U_0/sbus_o_mux.ack {-height 15 -radix hexadecimal -radixenum numeric}} /tb_top/U_0/sbus_o_mux
add wave -noupdate /tb_top/save2file
add wave -noupdate /tb_top/U_2/RAM(0)
add wave -noupdate /tb_top/U_2/RAM(1)
add wave -noupdate /tb_top/U_2/RAM(2)
add wave -noupdate /tb_top/U_2/RAM(3)
add wave -noupdate /tb_top/U_2/RAM(4)
add wave -noupdate /tb_top/U_2/RAM(5)
add wave -noupdate /tb_top/U_2/RAM(6)
add wave -noupdate /tb_top/U_2/RAM(7)
add wave -noupdate /tb_top/U_2/RAM(8)
add wave -noupdate /tb_top/U_2/RAM(9)
add wave -noupdate /tb_top/U_2/RAM(10)
add wave -noupdate /tb_top/U_2/RAM
add wave -noupdate /tb_top/U_2/sbus_i_a
add wave -noupdate /tb_top/U_2/sbus_o_a
add wave -noupdate /tb_top/load2mem
add wave -noupdate /tb_top/U_2/ram_update
add wave -noupdate /tb_top/U_2/RAM_file(0)
add wave -noupdate /tb_top/U_2/RAM_file(1)
add wave -noupdate /tb_top/U_2/RAM_file(2)
add wave -noupdate /tb_top/U_2/RAM_file(3)
add wave -noupdate /tb_top/U_2/RAM_file(4)
add wave -noupdate /tb_top/U_2/RAM_file(5)
add wave -noupdate /tb_top/U_2/RAM_file(6)
add wave -noupdate /tb_top/U_2/RAM_file(7)
add wave -noupdate /tb_top/U_2/RAM_file
add wave -noupdate /tb_top/U_2/ena
add wave -noupdate /tb_top/U_2/wea
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1015 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {10013 ns} {10303 ns}
