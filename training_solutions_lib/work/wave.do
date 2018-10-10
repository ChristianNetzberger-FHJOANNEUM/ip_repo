onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_chapter1/buttons
add wave -noupdate /tb_chapter1/clk
add wave -noupdate /tb_chapter1/encoder0
add wave -noupdate /tb_chapter1/encoder1
add wave -noupdate /tb_chapter1/sliders
add wave -noupdate /tb_chapter1/leds
add wave -noupdate /tb_chapter1/leds1
add wave -noupdate /tb_chapter1/leds2
add wave -noupdate /tb_chapter1/U_4/buttons
add wave -noupdate /tb_chapter1/U_4/clk
add wave -noupdate /tb_chapter1/U_4/encoder0
add wave -noupdate /tb_chapter1/U_4/encoder1
add wave -noupdate /tb_chapter1/U_4/sliders
add wave -noupdate /tb_chapter1/U_4/halt
add wave -noupdate /tb_chapter1/U_4/stop
add wave -noupdate /tb_chapter1/U_4/clk_tmp
add wave -noupdate /tb_chapter1/U_4/buttons_tmp
add wave -noupdate /tb_chapter1/U_4/sliders_tmp
add wave -noupdate /tb_chapter1/U_4/encoder0_tmp
add wave -noupdate /tb_chapter1/U_4/encoder1_tmp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15862 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {2540 ns} {52498 ns}
