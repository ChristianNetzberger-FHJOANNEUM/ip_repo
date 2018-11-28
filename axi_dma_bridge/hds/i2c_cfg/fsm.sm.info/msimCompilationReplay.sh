cd D:/HDL/ece_lib
D:/MentorGraphics/modeltech64_10.2c/win64/vdir -prop cmpltime -r >& hds_ece_lib_vdir_tmp
cd $HDS_PROJECT_DIR/ece_lib/work
D:/MentorGraphics/modeltech64_10.2c/win64/vcom -work "ece_lib" -nologo -f D:/HDL/ece_lib/hds/i2c_cfg/fsm.sm.info/Files1
