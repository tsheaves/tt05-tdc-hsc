set_units -time ns
create_clock -period 20 [get_ports -of_objects [ui_in[1]]]
create_clock -period 20 [get_ports -of_objects [ui_in[2]]]
