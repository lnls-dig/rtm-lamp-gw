onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider magnet_tb
add wave -noupdate /magnet_tb/cur_out
add wave -noupdate /magnet_tb/volt_in
add wave -noupdate -divider magnet_tb_inst
add wave -noupdate /magnet_tb/magnet_inst/r
add wave -noupdate /magnet_tb/magnet_inst/l
add wave -noupdate /magnet_tb/magnet_inst/time_step
add wave -noupdate /magnet_tb/magnet_inst/volt_in
add wave -noupdate /magnet_tb/magnet_inst/cur_out
add wave -noupdate /magnet_tb/magnet_inst/current
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 fs} 0}
quietly wave cursor active 0
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 fs} {1050 ns}
