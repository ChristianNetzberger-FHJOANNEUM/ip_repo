onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_chapter2/clk
add wave -noupdate /tb_chapter2/buttons
add wave -noupdate /tb_chapter2/encoder0
add wave -noupdate /tb_chapter2/encoder1
add wave -noupdate /tb_chapter2/sliders
add wave -noupdate /tb_chapter2/leds_2a
add wave -noupdate /tb_chapter2/U_1/sliders_q0
add wave -noupdate /tb_chapter2/U_1/sliders_q1
add wave -noupdate /tb_chapter2/U_1/sliders_q2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11026 ns} 0} {{Cursor 2} {11036 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 204
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
WaveRestoreZoom {10945 ns} {11105 ns}
