onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider ltc232x_acq_tb
add wave -noupdate /ltc232x_acq_tb/g_BITS
add wave -noupdate /ltc232x_acq_tb/ch1_o
add wave -noupdate /ltc232x_acq_tb/ch2_o
add wave -noupdate /ltc232x_acq_tb/ch3_o
add wave -noupdate /ltc232x_acq_tb/ch4_o
add wave -noupdate /ltc232x_acq_tb/ch5_o
add wave -noupdate /ltc232x_acq_tb/ch6_o
add wave -noupdate /ltc232x_acq_tb/ch7_o
add wave -noupdate /ltc232x_acq_tb/ch8_o
add wave -noupdate /ltc232x_acq_tb/ch1_sync_o
add wave -noupdate /ltc232x_acq_tb/ch2_sync_o
add wave -noupdate /ltc232x_acq_tb/ch3_sync_o
add wave -noupdate /ltc232x_acq_tb/ch4_sync_o
add wave -noupdate /ltc232x_acq_tb/ch5_sync_o
add wave -noupdate /ltc232x_acq_tb/ch6_sync_o
add wave -noupdate /ltc232x_acq_tb/ch7_sync_o
add wave -noupdate /ltc232x_acq_tb/ch8_sync_o
add wave -noupdate /ltc232x_acq_tb/rst_n
add wave -noupdate /ltc232x_acq_tb/clk
add wave -noupdate /ltc232x_acq_tb/rst_sync_n
add wave -noupdate /ltc232x_acq_tb/clk_sync
add wave -noupdate /ltc232x_acq_tb/start
add wave -noupdate /ltc232x_acq_tb/sck
add wave -noupdate /ltc232x_acq_tb/sck_sync
add wave -noupdate /ltc232x_acq_tb/sck_ret
add wave -noupdate /ltc232x_acq_tb/sck_ret_sync
add wave -noupdate /ltc232x_acq_tb/cnv
add wave -noupdate /ltc232x_acq_tb/cnv_sync
add wave -noupdate /ltc232x_acq_tb/sdoa
add wave -noupdate /ltc232x_acq_tb/sdob
add wave -noupdate /ltc232x_acq_tb/sdoc
add wave -noupdate /ltc232x_acq_tb/sdod
add wave -noupdate /ltc232x_acq_tb/sdoa_sync
add wave -noupdate /ltc232x_acq_tb/sdob_sync
add wave -noupdate /ltc232x_acq_tb/sdoc_sync
add wave -noupdate /ltc232x_acq_tb/sdod_sync
add wave -noupdate /ltc232x_acq_tb/analog_i
add wave -noupdate -divider ltc232x_acq
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_acq/c_WAIT_CONV_CYCLES
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_acq/c_CONV_HIGH_CYCLES
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_acq/g_CLK_FREQ
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_acq/g_SCLK_FREQ
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_USE_REF_CLK_CNV
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_BITS
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_CHANNELS
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_DATA_LINES
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_CNV_WAIT
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/rst_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/clk_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/rst_ref_cnv_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/clk_ref_cnv_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/start_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cnv_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sck_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sck_ret_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ready_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/done_pp_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo1a_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo2_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo3b_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo4_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo5c_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo6_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo7d_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sdo8_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch1_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch2_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch3_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch4_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch5_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch6_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch7_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch8_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/valid_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/state_conv
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/state_ready
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/clk_fsm
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/rst_fsm_n
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/start_ref_cnv
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/done_cnv_pp
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/done_cnv_pp_ref_sys
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/start_readout_pp
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/done_pp
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ready_cnv
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ready
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/done_readout_pp
add wave -noupdate -divider ltc2320_model
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/g_REF
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/g_CHANNELS
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/g_DDR_MODE
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/cnv_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/clk_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/clk_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/sdoa_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/sdob_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/sdoc_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/sdod_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/analog_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/analog_aq
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/delayed_cnv_n
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/chn_off
add wave -noupdate /ltc232x_acq_tb/cmp_ltc2320/bit_indx
add wave -noupdate -divider ltc_232x_sync_acq
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_sync_acq/c_WAIT_CONV_CYCLES
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_sync_acq/c_CONV_HIGH_CYCLES
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_sync_acq/g_CLK_FREQ
add wave -noupdate -radix unsigned /ltc232x_acq_tb/cmp_ltc232x_sync_acq/g_SCLK_FREQ
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/g_USE_REF_CLK_CNV
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/g_BITS
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/g_CHANNELS
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/g_DATA_LINES
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/g_CNV_WAIT
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/rst_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/clk_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/rst_ref_cnv_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/clk_ref_cnv_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/start_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/cnv_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sck_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sck_ret_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ready_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/done_pp_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo1a_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo2_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo3b_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo4_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo5c_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo6_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo7d_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/sdo8_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch1_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch2_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch3_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch4_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch5_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch6_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch7_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ch8_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/valid_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/state_conv
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/state_ready
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/clk_fsm
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/rst_fsm_n
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/start_ref_cnv
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/done_cnv_pp
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/done_cnv_pp_ref_sys
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/start_readout_pp
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/done_pp
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ready_cnv
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/ready
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_sync_acq/done_readout_pp
add wave -noupdate -divider ltc2320_sync_model
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/g_REF
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/g_CHANNELS
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/g_DDR_MODE
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/cnv_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/clk_i
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/clk_o
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/sdoa_o
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/sdob_o
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/sdoc_o
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/sdod_o
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/analog_i
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/analog_aq
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/delayed_cnv_n
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/chn_off
add wave -noupdate /ltc232x_acq_tb/cmp_clk_sync_ltc2320/bit_indx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {207500 ps} 0}
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
WaveRestoreZoom {0 ps} {1307500 ps}
