cd D:/HDL/compiso_tb
D:/MentorGraphics/modeltech64_10.2c/win64/vdir -prop cmpltime -r >& hds_compiso_tb_vdir_tmp
cd $HDS_PROJECT_DIR/compiso_tb/work
D:/MentorGraphics/modeltech64_10.2c/win64/vcom -work "compiso_tb" -nologo -2008 -f D:/HDL/compiso_tb/hds/.hdlsidedata/busdef_pkg.vhd.info/Files0
