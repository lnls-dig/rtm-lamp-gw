`define RTMLAMP_OHWR_REGS_SIZE 420
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_0_DAC 'h108
`define RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_0_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_0_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_0_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_0_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_0_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_STA 'h10c
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_CTL 'h110
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_1_DAC 'h114
`define RTMLAMP_OHWR_REGS_CH_1_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_1_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_1_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_1_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_1_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_1_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_STA 'h118
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_CTL 'h11c
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_2_DAC 'h120
`define RTMLAMP_OHWR_REGS_CH_2_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_2_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_2_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_2_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_2_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_2_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_STA 'h124
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_CTL 'h128
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_3_DAC 'h12c
`define RTMLAMP_OHWR_REGS_CH_3_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_3_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_3_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_3_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_3_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_3_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_STA 'h130
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_CTL 'h134
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_4_DAC 'h138
`define RTMLAMP_OHWR_REGS_CH_4_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_4_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_4_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_4_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_4_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_4_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_STA 'h13c
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_CTL 'h140
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_5_DAC 'h144
`define RTMLAMP_OHWR_REGS_CH_5_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_5_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_5_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_5_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_5_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_5_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_STA 'h148
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_CTL 'h14c
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_6_DAC 'h150
`define RTMLAMP_OHWR_REGS_CH_6_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_6_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_6_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_6_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_6_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_6_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_STA 'h154
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_CTL 'h158
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_7_DAC 'h15c
`define RTMLAMP_OHWR_REGS_CH_7_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_7_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_7_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_7_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_7_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_7_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_STA 'h160
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_CTL 'h164
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_8_DAC 'h168
`define RTMLAMP_OHWR_REGS_CH_8_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_8_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_8_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_8_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_8_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_8_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_STA 'h16c
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_CTL 'h170
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_9_DAC 'h174
`define RTMLAMP_OHWR_REGS_CH_9_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_9_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_9_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_9_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_9_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_9_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_STA 'h178
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_CTL 'h17c
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_10_DAC 'h180
`define RTMLAMP_OHWR_REGS_CH_10_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_10_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_10_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_10_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_10_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_10_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_STA 'h184
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_CTL 'h188
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
`define ADDR_RTMLAMP_OHWR_REGS_CH_11_DAC 'h18c
`define RTMLAMP_OHWR_REGS_CH_11_DAC_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_CH_11_DAC_DATA 'hffff
`define RTMLAMP_OHWR_REGS_CH_11_DAC_WR_OFFSET 16
`define RTMLAMP_OHWR_REGS_CH_11_DAC_WR 'h10000
`define RTMLAMP_OHWR_REGS_CH_11_DAC_RESERVED_OFFSET 17
`define RTMLAMP_OHWR_REGS_CH_11_DAC_RESERVED 'hfffe0000
`define ADDR_RTMLAMP_OHWR_REGS_PI_KP 'h190
`define RTMLAMP_OHWR_REGS_PI_KP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_PI_KP_DATA 'hffffffff
`define ADDR_RTMLAMP_OHWR_REGS_PI_TI 'h194
`define RTMLAMP_OHWR_REGS_PI_TI_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_PI_TI_DATA 'hffffffff
`define ADDR_RTMLAMP_OHWR_REGS_PI_SP 'h198
`define RTMLAMP_OHWR_REGS_PI_SP_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_PI_SP_DATA 'hffffffff
`define ADDR_RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX 'h19c
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_DATA 'h3fffff
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_RESERVED_OFFSET 22
`define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_RESERVED 'hffc00000
`define ADDR_RTMLAMP_OHWR_REGS_PI_SP_LIM_INF 'h1a0
`define RTMLAMP_OHWR_REGS_PI_SP_LIM_INF_DATA_OFFSET 0
`define RTMLAMP_OHWR_REGS_PI_SP_LIM_INF_DATA 'hffffffff
