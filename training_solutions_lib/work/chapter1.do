onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand /tb_chapter1/buttons
add wave -noupdate /tb_chapter1/clk
add wave -noupdate /tb_chapter1/encoder0
add wave -noupdate /tb_chapter1/encoder1
add wave -noupdate -radix decimal /tb_chapter1/sliders
add wave -noupdate -radix decimal -childformat {{/tb_chapter1/leds_2f(3) -radix decimal} {/tb_chapter1/leds_2f(2) -radix decimal} {/tb_chapter1/leds_2f(1) -radix decimal} {/tb_chapter1/leds_2f(0) -radix decimal}} -subitemconfig {/tb_chapter1/leds_2f(3) {-height 15 -radix decimal} /tb_chapter1/leds_2f(2) {-height 15 -radix decimal} /tb_chapter1/leds_2f(1) {-height 15 -radix decimal} /tb_chapter1/leds_2f(0) {-height 15 -radix decimal}} /tb_chapter1/leds_2f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {32024 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 197
configure wave -valuecolwidth 117
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
WaveRestoreZoom {25089 ns} {42679 ns}
