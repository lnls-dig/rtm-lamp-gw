onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider multi_dac_spi_ldac_tb
add wave -noupdate /multi_dac_spi_ldac_tb/dac_data
add wave -noupdate /multi_dac_spi_ldac_tb/clk_200mhz
add wave -noupdate /multi_dac_spi_ldac_tb/rst_n
add wave -noupdate /multi_dac_spi_ldac_tb/ready
add wave -noupdate /multi_dac_spi_ldac_tb/dac_cs_n
add wave -noupdate /multi_dac_spi_ldac_tb/dac_ldac_n
add wave -noupdate /multi_dac_spi_ldac_tb/dac_sck
add wave -noupdate /multi_dac_spi_ldac_tb/dac_sdi
add wave -noupdate /multi_dac_spi_ldac_tb/dac_start
add wave -noupdate -divider multi_dac_ldac
add wave -noupdate -radix unsigned /multi_dac_spi_ldac_tb/cmp_multi_dac/c_LDAC_WAIT_CYCLES
add wave -noupdate -radix unsigned /multi_dac_spi_ldac_tb/cmp_multi_dac/c_LDAC_WIDTH_CYCLES
add wave -noupdate -radix unsigned /multi_dac_spi_ldac_tb/cmp_multi_dac/g_CLK_FREQ
add wave -noupdate -radix unsigned /multi_dac_spi_ldac_tb/cmp_multi_dac/g_SCLK_FREQ
add wave -noupdate -radix unsigned /multi_dac_spi_ldac_tb/cmp_multi_dac/g_NUM_DACS
add wave -noupdate -radix unsigned /multi_dac_spi_ldac_tb/cmp_multi_dac/g_CPOL
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/g_LDAC_WIDTH
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/g_LDAC_WAIT_AFTER_CS
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/clk_i
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/rst_n_i
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/start_i
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/ready_o
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/done_pp_o
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/data_i
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/dac_cs_n_o
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/dac_ldac_n_o
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/dac_sck_o
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/dac_sdi_o
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/state
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/done_pp
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/ldac_n
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/ldac_wait_counter
add wave -noupdate /multi_dac_spi_ldac_tb/cmp_multi_dac/ldac_width_counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1258 ns} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {1103 ns} {2153 ns}
