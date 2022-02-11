`define RTMLAMP_OHWR_REGS_SIZE 552
`define ADDR_RTMLAMP_OHWR_REGS_STA 'h0
`define RTMLAMP_OHWR_REGS_STA_RESERVED_OFFSET 0
`define RTMLAMP_OHWR_REGS_STA_RESERVED 'hffffffff
`define ADDR_RTMLAMP_OHWR_REGS_CTL 'h4
`define RTMLAMP_OHWR_REGS_CTL_DAC_DATA_FROM_WB_OFFSET 0
`define RTMLAMP_OHWR_REGS_CTL_DAC_DATA_FROM_WB 'h1
`define RTMLAMP_OHWR_REGS_CTL_RESERVED_OFFSET 1
`define RTMLAMP_OHWR_REGS_CTL_RESERVED 'hfffffffe
`define ADDR_RTMLAMP_OHWR_REGS_CH_0_STA 'h100
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_0_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_0_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_0_CTL 'h104
`define RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_0_PI_KP 'h108
`define RTMLAMP_OHWR_REGS_CH_0_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_0_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_0_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_0_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_0_PI_TI 'h10c
`define RTMLAMP_OHWR_REGS_CH_0_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_0_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_0_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_0_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_0_PI_SP 'h110
`define RTMLAMP_OHWR_REGS_CH_0_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_0_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_0_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_0_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_0_DAC 'h114
`define RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_0_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_0_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_0_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_0_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_0_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_STA 'h118
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_1_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_1_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_CTL 'h11c
`define RTMLAMP_OHWR_REGS_CH_1_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_1_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_PI_KP 'h120
`define RTMLAMP_OHWR_REGS_CH_1_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_1_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_1_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_1_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_PI_TI 'h124
`define RTMLAMP_OHWR_REGS_CH_1_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_1_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_1_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_1_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_PI_SP 'h128
`define RTMLAMP_OHWR_REGS_CH_1_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_1_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_1_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_1_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_DAC 'h12c
`define RTMLAMP_OHWR_REGS_CH_1_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_1_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_1_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_1_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_1_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_1_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_STA 'h130
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_2_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_2_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_CTL 'h134
`define RTMLAMP_OHWR_REGS_CH_2_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_2_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_PI_KP 'h138
`define RTMLAMP_OHWR_REGS_CH_2_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_2_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_2_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_2_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_PI_TI 'h13c
`define RTMLAMP_OHWR_REGS_CH_2_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_2_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_2_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_2_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_PI_SP 'h140
`define RTMLAMP_OHWR_REGS_CH_2_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_2_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_2_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_2_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_DAC 'h144
`define RTMLAMP_OHWR_REGS_CH_2_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_2_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_2_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_2_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_2_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_2_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_STA 'h148
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_3_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_3_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_CTL 'h14c
`define RTMLAMP_OHWR_REGS_CH_3_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_3_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_PI_KP 'h150
`define RTMLAMP_OHWR_REGS_CH_3_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_3_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_3_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_3_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_PI_TI 'h154
`define RTMLAMP_OHWR_REGS_CH_3_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_3_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_3_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_3_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_PI_SP 'h158
`define RTMLAMP_OHWR_REGS_CH_3_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_3_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_3_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_3_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_DAC 'h15c
`define RTMLAMP_OHWR_REGS_CH_3_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_3_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_3_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_3_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_3_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_3_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_STA 'h160
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_4_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_4_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_CTL 'h164
`define RTMLAMP_OHWR_REGS_CH_4_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_4_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_PI_KP 'h168
`define RTMLAMP_OHWR_REGS_CH_4_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_4_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_4_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_4_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_PI_TI 'h16c
`define RTMLAMP_OHWR_REGS_CH_4_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_4_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_4_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_4_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_PI_SP 'h170
`define RTMLAMP_OHWR_REGS_CH_4_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_4_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_4_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_4_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_DAC 'h174
`define RTMLAMP_OHWR_REGS_CH_4_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_4_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_4_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_4_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_4_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_4_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_STA 'h178
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_5_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_5_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_CTL 'h17c
`define RTMLAMP_OHWR_REGS_CH_5_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_5_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_PI_KP 'h180
`define RTMLAMP_OHWR_REGS_CH_5_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_5_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_5_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_5_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_PI_TI 'h184
`define RTMLAMP_OHWR_REGS_CH_5_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_5_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_5_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_5_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_PI_SP 'h188
`define RTMLAMP_OHWR_REGS_CH_5_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_5_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_5_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_5_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_DAC 'h18c
`define RTMLAMP_OHWR_REGS_CH_5_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_5_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_5_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_5_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_5_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_5_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_STA 'h190
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_6_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_6_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_CTL 'h194
`define RTMLAMP_OHWR_REGS_CH_6_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_6_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_PI_KP 'h198
`define RTMLAMP_OHWR_REGS_CH_6_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_6_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_6_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_6_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_PI_TI 'h19c
`define RTMLAMP_OHWR_REGS_CH_6_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_6_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_6_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_6_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_PI_SP 'h1a0
`define RTMLAMP_OHWR_REGS_CH_6_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_6_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_6_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_6_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_DAC 'h1a4
`define RTMLAMP_OHWR_REGS_CH_6_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_6_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_6_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_6_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_6_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_6_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_STA 'h1a8
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_7_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_7_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_CTL 'h1ac
`define RTMLAMP_OHWR_REGS_CH_7_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_7_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_PI_KP 'h1b0
`define RTMLAMP_OHWR_REGS_CH_7_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_7_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_7_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_7_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_PI_TI 'h1b4
`define RTMLAMP_OHWR_REGS_CH_7_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_7_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_7_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_7_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_PI_SP 'h1b8
`define RTMLAMP_OHWR_REGS_CH_7_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_7_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_7_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_7_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_DAC 'h1bc
`define RTMLAMP_OHWR_REGS_CH_7_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_7_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_7_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_7_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_7_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_7_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_STA 'h1c0
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_8_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_8_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_CTL 'h1c4
`define RTMLAMP_OHWR_REGS_CH_8_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_8_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_PI_KP 'h1c8
`define RTMLAMP_OHWR_REGS_CH_8_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_8_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_8_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_8_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_PI_TI 'h1cc
`define RTMLAMP_OHWR_REGS_CH_8_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_8_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_8_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_8_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_PI_SP 'h1d0
`define RTMLAMP_OHWR_REGS_CH_8_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_8_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_8_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_8_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_DAC 'h1d4
`define RTMLAMP_OHWR_REGS_CH_8_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_8_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_8_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_8_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_8_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_8_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_STA 'h1d8
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_9_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_9_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_CTL 'h1dc
`define RTMLAMP_OHWR_REGS_CH_9_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_9_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_PI_KP 'h1e0
`define RTMLAMP_OHWR_REGS_CH_9_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_9_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_9_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_9_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_PI_TI 'h1e4
`define RTMLAMP_OHWR_REGS_CH_9_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_9_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_9_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_9_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_PI_SP 'h1e8
`define RTMLAMP_OHWR_REGS_CH_9_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_9_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_9_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_9_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_DAC 'h1ec
`define RTMLAMP_OHWR_REGS_CH_9_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_9_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_9_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_9_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_9_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_9_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_STA 'h1f0
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_10_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_10_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_CTL 'h1f4
`define RTMLAMP_OHWR_REGS_CH_10_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_10_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_PI_KP 'h1f8
`define RTMLAMP_OHWR_REGS_CH_10_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_10_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_10_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_10_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_PI_TI 'h1fc
`define RTMLAMP_OHWR_REGS_CH_10_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_10_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_10_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_10_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_PI_SP 'h200
`define RTMLAMP_OHWR_REGS_CH_10_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_10_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_10_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_10_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_DAC 'h204
`define RTMLAMP_OHWR_REGS_CH_10_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_10_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_10_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_10_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_10_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_10_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_STA 'h208
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_L_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_L 'h1
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_L_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_L 'h2
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_R_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_R 'h4
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_R_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_R 'h8
`define RTMLAMP_OHWR_REGS_CH_11_STA_RESERVED_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_11_STA_RESERVED 'hfffffff0
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_CTL 'h20c
`define RTMLAMP_OHWR_REGS_CH_11_CTL_AMP_EN_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_11_CTL_AMP_EN 'h1
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_OL_TRIANG_ENABLE_OFFSET 1
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_OL_TRIANG_ENABLE 'h2
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_OL_SQUARE_ENABLE_OFFSET 2
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_OL_SQUARE_ENABLE 'h4
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_SP_SQUARE_ENABLE_OFFSET 3
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_SP_SQUARE_ENABLE 'h8
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_ENABLE_OFFSET 4
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_ENABLE 'h10
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_SP_SOURCE_OFFSET 5
`define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_SP_SOURCE 'h20
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_PI_KP 'h210
`define RTMLAMP_OHWR_REGS_CH_11_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_11_PI_KP_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_11_PI_KP_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_11_PI_KP_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_PI_TI 'h214
`define RTMLAMP_OHWR_REGS_CH_11_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_11_PI_TI_DATA 'h3ffffff
`define RTMLAMP_OHWR_REGS_CH_11_PI_TI_RESERVED_OFFSET 26
`define RTMLAMP_OHWR_REGS_CH_11_PI_TI_RESERVED 'hfc000000
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_PI_SP 'h218
`define RTMLAMP_OHWR_REGS_CH_11_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_11_PI_SP_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_11_PI_SP_RESERVED_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_11_PI_SP_RESERVED 'hffff0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_DAC 'h21c
`define RTMLAMP_OHWR_REGS_CH_11_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_11_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_11_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_11_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_11_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_11_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX 'h220
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_DATA 'h3fffff
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_RESERVED_OFFSET 22
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_RESERVED 'hffc00000
`define ADDR_RTMLAMP_OHWR_REGS_PI_SP_LIM_INF 'h224
`define RTMLAMP_OHWR_REGS_PI_SP_LIM_INF_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_PI_SP_LIM_INF_DATA 'hffffffff
