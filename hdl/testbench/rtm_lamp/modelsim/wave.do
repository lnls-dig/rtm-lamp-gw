onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider rtm_lamp_model_tb
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SYS_PERIOD
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SYS_PERIOD_HALF
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SYS_FREQ
add wave -noupdate /rtm_lamp_model_tb/c_CLK_FAST_SPI_PERIOD
add wave -noupdate /rtm_lamp_model_tb/c_CLK_FAST_SPI_PERIOD_HALF
add wave -noupdate /rtm_lamp_model_tb/c_CLK_FAST_SPI_FREQ
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SCLK_PERIOD
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SCLK_PERIOD_HALF
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SCLK_FREQ
add wave -noupdate /rtm_lamp_model_tb/c_CLK_DAC_SCLK_PERIOD
add wave -noupdate /rtm_lamp_model_tb/c_CLK_DAC_SCLK_PERIOD_HALF
add wave -noupdate /rtm_lamp_model_tb/c_CLK_DAC_SCLK_FREQ
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SERIAL_REGS_PERIOD
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SERIAL_REGS_PERIOD_HALF
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SERIAL_REGS_FREQ
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SYNC_PERIOD
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SYNC_PERIOD_HALF
add wave -noupdate /rtm_lamp_model_tb/c_CLK_SYNC_FREQ
add wave -noupdate /rtm_lamp_model_tb/clk_sys
add wave -noupdate /rtm_lamp_model_tb/rst_n
add wave -noupdate /rtm_lamp_model_tb/rst_fast_spi_n
add wave -noupdate /rtm_lamp_model_tb/clk_fast_spi
add wave -noupdate /rtm_lamp_model_tb/clk_sclk
add wave -noupdate /rtm_lamp_model_tb/rst_sclk_n
add wave -noupdate /rtm_lamp_model_tb/clk_sync
add wave -noupdate /rtm_lamp_model_tb/rst_sync_n
add wave -noupdate /rtm_lamp_model_tb/dac_samples
add wave -noupdate /rtm_lamp_model_tb/dac_ready
add wave -noupdate /rtm_lamp_model_tb/dac_done_pp
add wave -noupdate /rtm_lamp_model_tb/adc_data
add wave -noupdate /rtm_lamp_model_tb/adc_valid
add wave -noupdate /rtm_lamp_model_tb/adc_cnv
add wave -noupdate /rtm_lamp_model_tb/adc_octo_clk
add wave -noupdate /rtm_lamp_model_tb/adc_octo_clk_out
add wave -noupdate /rtm_lamp_model_tb/adc_octo_clk_out_n
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdoa
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdoa_n
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdob
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdob_n
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdoc
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdoc_n
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdod
add wave -noupdate /rtm_lamp_model_tb/adc_octo_sdod_n
add wave -noupdate /rtm_lamp_model_tb/adc_quad_clk
add wave -noupdate /rtm_lamp_model_tb/adc_quad_clk_out
add wave -noupdate /rtm_lamp_model_tb/adc_quad_clk_out_n
add wave -noupdate /rtm_lamp_model_tb/adc_quad_sdoa
add wave -noupdate /rtm_lamp_model_tb/adc_quad_sdoa_n
add wave -noupdate /rtm_lamp_model_tb/adc_quad_sdoc
add wave -noupdate /rtm_lamp_model_tb/adc_quad_sdoc_n
add wave -noupdate /rtm_lamp_model_tb/dac_ldac
add wave -noupdate /rtm_lamp_model_tb/dac_cs
add wave -noupdate /rtm_lamp_model_tb/dac_sck
add wave -noupdate /rtm_lamp_model_tb/dac_sdi
add wave -noupdate /rtm_lamp_model_tb/shift_pl
add wave -noupdate /rtm_lamp_model_tb/shift_clk
add wave -noupdate /rtm_lamp_model_tb/shift_dout
add wave -noupdate /rtm_lamp_model_tb/shift_str
add wave -noupdate /rtm_lamp_model_tb/shift_oe_n
add wave -noupdate /rtm_lamp_model_tb/shift_din
add wave -noupdate /rtm_lamp_model_tb/amp_iflag_l
add wave -noupdate /rtm_lamp_model_tb/amp_tflag_l
add wave -noupdate /rtm_lamp_model_tb/amp_iflag_r
add wave -noupdate /rtm_lamp_model_tb/amp_tflag_r
add wave -noupdate /rtm_lamp_model_tb/amp_en_ch
add wave -noupdate -divider rmp_lamp_model
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/g_ADC_REF
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/g_DAC_REF
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/g_MAG_RES
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/g_MAG_IND
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/g_MAG_TIME_STEP
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/g_ADC_DDR_MODE
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/rtm_lamp_sync_clk_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_cnv_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_octo_clk_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_octo_clk_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_octo_sdoa_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_octo_sdob_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_octo_sdoc_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_octo_sdod_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_quad_clk_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_quad_clk_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_quad_sdoa_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_quad_sdoc_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/dac_ldac_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/dac_cs_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/dac_sck_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/dac_sdi_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/shift_pl_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/shift_clk_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/shift_dout_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/shift_str_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/shift_oe_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/shift_din_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/voltages
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/voltages_dac
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/currents
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/currents_adc
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/adc_cnv_sync
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/dac_ldac_sync
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_iflag_l
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_tflag_l
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_iflag_r
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_tflag_r
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_flags_dp
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_flags_q7
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_flags_q7_n
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_flags_ds
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_en_q
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_en_q7s
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/amp_en_ds
add wave -noupdate -divider amp_flags_regs0
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/pl_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/ce_n_i
add wave -noupdate -radix binary /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/dp_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/cp_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/ds_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/q7_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/q7_n_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/q
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_flags_regs(0)/cmp_shift_reg_74hc165_model/q7
add wave -noupdate -divider amp_en_regs0
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/mr_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/shcp_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/stcp_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/oe_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/ds_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/q_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/q7s_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/qs
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/qp
add wave -noupdate /rtm_lamp_model_tb/cmp_rtm_lamp_model/gen_amp_en_regs(0)/cmp_shift_reg_74hc595_model/q7s
add wave -noupdate -divider rtmlamp_ohwr
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_SYS_CLOCK_FREQ
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_REF_CLK_FREQ
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_USE_REF_CLK
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_CLK_FAST_SPI_FREQ
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_ADC_SCLK_FREQ
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_ADC_CHANNELS
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_ADC_FIX_INV_INPUTS
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_DAC_SCLK_FREQ
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_DAC_CHANNELS
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_SERIAL_REG_SCLK_FREQ
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/g_SERIAL_REGS_AMP_CHANNELS
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/c_ADC_CNV_HIGH
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/c_ADC_CNV_WAIT
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/c_ADC_BITS
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/c_ADC_OFFB_2_TWOSCOMP_CONV
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/c_DAC_LDAC_WIDTH
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/c_DAC_LDAC_WAIT_AFTER_CS
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/c_DUMMY_ADC_READOUT
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/clk_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/rst_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/clk_ref_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/rst_ref_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/rst_fast_spi_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/clk_fast_spi_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_cnv_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sck_p_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sck_n_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sck_ret_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sck_ret_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdoa_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdoa_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdob_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdob_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdoc_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdoc_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdod_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdod_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_cnv_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sck_p_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sck_n_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sck_ret_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sck_ret_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sdoa_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sdoa_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sdoc_p_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sdoc_n_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_cs_n_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_ldac_n_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_sck_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_sdi_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_shift_clk_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_shift_dout_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_shift_pl_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_shift_oe_n_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_shift_din_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_shift_str_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_start_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_data_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_valid_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_start_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_data_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_ready_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_done_pp_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_sta_ctl_rw_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_iflag_l_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_tflag_l_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_iflag_r_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_tflag_r_o
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/amp_en_ch_i
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/dac_ldac_n
add wave -noupdate -expand /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_data
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_valid
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sck
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sck_ret
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_cnv
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdoa
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdob
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdoc
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_sdod
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sck
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sck_ret
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_cnv
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sdoa
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_sdoc
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_raw
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_fix_inv
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_octo_scaled
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_raw
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_fix_inv
add wave -noupdate /rtm_lamp_model_tb/cmp_rtmlamp_ohwr/adc_quad_scaled
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {856 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
configure wave -valuecolwidth 116
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
WaveRestoreZoom {720 ns} {1575 ns}
