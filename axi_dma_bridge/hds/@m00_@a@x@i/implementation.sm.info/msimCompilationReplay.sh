cd D:/HDL/axi_udp
D:/MentorGraphics/modeltech64_10.2c/win64/vdir -prop cmpltime -r >& hds_axi_udp_vdir_tmp
cd D:/projekte/KIM/vivado/kim_core1/axi_kim_slv_1.0
D:/MentorGraphics/modeltech64_10.2c/win64/vdir -prop cmpltime -r >& hds_axi_kim_slv_v1_0_vdir_tmp
cd D:/projekte/KIM/vivado/kim_core1/axi_kim_slv_1.0/work
D:/MentorGraphics/modeltech64_10.2c/win64/vcom -work "axi_kim_slv_v1_0" -nologo -f D:/projekte/KIM/vivado/kim_core1/axi_kim_slv_1.0/hds/@m00_@a@x@i/implementation.sm.info/Files0
