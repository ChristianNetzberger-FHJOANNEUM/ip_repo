set_property IOSTANDARD LVCMOS33 [get_ports {buttons[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sliders[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sliders[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sliders[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sliders[0]}]
set_property PACKAGE_PIN Y16 [get_ports {buttons[3]}]
set_property PACKAGE_PIN V16 [get_ports {buttons[2]}]
set_property PACKAGE_PIN P16 [get_ports {buttons[1]}]
set_property PACKAGE_PIN R18 [get_ports {buttons[0]}]
set_property PACKAGE_PIN D18 [get_ports {leds[3]}]
set_property PACKAGE_PIN G14 [get_ports {leds[2]}]
set_property PACKAGE_PIN M15 [get_ports {leds[1]}]
set_property PACKAGE_PIN M14 [get_ports {leds[0]}]
set_property PACKAGE_PIN T16 [get_ports {sliders[3]}]
set_property PACKAGE_PIN W13 [get_ports {sliders[2]}]
set_property PACKAGE_PIN P15 [get_ports {sliders[1]}]
set_property PACKAGE_PIN G15 [get_ports {sliders[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN L16 [get_ports clk]
#create_clock -period 8.000 -name clk -waveform {0.000 4.000} -add
set_property IOSTANDARD LVCMOS33 [get_ports {encoder0[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {encoder0[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {encoder1[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {encoder1[1]}]
set_property PACKAGE_PIN J15 [get_ports {encoder1[1]}]
set_property PACKAGE_PIN H15 [get_ports {encoder1[0]}]
set_property PACKAGE_PIN T17 [get_ports {encoder0[1]}]
set_property PACKAGE_PIN Y17 [get_ports {encoder0[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buzzer[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buzzer[1]}]



set_property PACKAGE_PIN T20 [get_ports {buzzer[1]}]
set_property PACKAGE_PIN W20 [get_ports {buzzer[0]}]

set_property PULLUP true [get_ports {encoder0[1]}]
set_property PULLUP true [get_ports {encoder0[0]}]
set_property PULLUP true [get_ports {encoder1[1]}]
set_property PULLUP true [get_ports {encoder1[0]}]








create_clock -period 8.000 -name clk_1 -waveform {0.000 4.000} [get_ports clk]
