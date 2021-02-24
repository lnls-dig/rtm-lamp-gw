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
add wave -noupdate /ltc232x_acq_tb/rst_n
add wave -noupdate /ltc232x_acq_tb/clk
add wave -noupdate /ltc232x_acq_tb/start
add wave -noupdate /ltc232x_acq_tb/sck
add wave -noupdate /ltc232x_acq_tb/sck_ret
add wave -noupdate /ltc232x_acq_tb/cnv
add wave -noupdate /ltc232x_acq_tb/sdoa
add wave -noupdate /ltc232x_acq_tb/sdob
add wave -noupdate /ltc232x_acq_tb/sdoc
add wave -noupdate /ltc232x_acq_tb/sdod
add wave -noupdate /ltc232x_acq_tb/analog_i
add wave -noupdate -divider ltc232x_acq
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/c_DDR_MODE
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/c_WAIT_CONV_CYCLES
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/c_CONV_HIGH_CYCLES
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/c_BITS_PER_LINE
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/c_SCK_CLK_RATIO
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/c_SCK_CLK_DIV_CNT
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_CLK_FREQ
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_SCLK_FREQ
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_BITS
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_CHANNELS
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_DATA_LINES
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/g_CNV_WAIT
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/rst_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/clk_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/start_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cnv_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sck_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sck_ret_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ready_o
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
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/state
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/sck_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/fifo_rd
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/fifo_rd_empty
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/fifo_in
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/fifo_out
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch1_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch2_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch3_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch4_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch5_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch6_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch7_o_s
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/ch8_o_s
add wave -noupdate -divider ltc232x_fifo
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_data_width
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_size
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_show_ahead
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_rd_empty
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_rd_full
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_rd_almost_empty
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_rd_almost_full
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_rd_count
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_wr_empty
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_wr_full
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_wr_almost_empty
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_wr_almost_full
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_with_wr_count
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_almost_empty_threshold
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/g_almost_full_threshold
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rst_n_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/clk_wr_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/d_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/we_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wr_empty_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wr_full_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wr_almost_empty_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wr_almost_full_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wr_count_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/clk_rd_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/q_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_i
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_empty_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_full_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_almost_empty_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_almost_full_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_count_o
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/mem
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rcb
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wcb
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/full_int
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/empty_int
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/almost_full_int
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/almost_empty_int
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/going_full
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wr_count
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_count
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_int
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/we_int
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/wr_empty_x
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/rd_full_x
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/almost_full_x
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/almost_empty_x
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/q_int
add wave -noupdate /ltc232x_acq_tb/cmp_ltc232x_acq/cmp_fifo/U_Inferred_FIFO/c_counter_bits
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1915400 ps} 0}
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
WaveRestoreZoom {1816900 ps} {2072800 ps}
