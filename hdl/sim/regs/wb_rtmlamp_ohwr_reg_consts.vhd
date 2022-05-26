package wb_rtmlamp_ohwr_regs_consts_pkg is
  constant c_WB_RTMLAMP_OHWR_REGS_SIZE : Natural := 2048;
  constant c_WB_RTMLAMP_OHWR_REGS_STA_ADDR : Natural := 16#0#;
  constant c_WB_RTMLAMP_OHWR_REGS_STA_RESERVED_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CTL_ADDR : Natural := 16#4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CTL_RESERVED_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_ADDR : Natural := 16#400#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_SIZE : Natural := 1024;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_ADDR : Natural := 16#400#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_ADDR : Natural := 16#400#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_ADDR : Natural := 16#404#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_KP_ADDR : Natural := 16#408#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_TI_ADDR : Natural := 16#40c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_SP_ADDR : Natural := 16#410#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_DAC_ADDR : Natural := 16#414#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_LIM_ADDR : Natural := 16#418#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_CNT_ADDR : Natural := 16#41c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_ADC_DAC_EFF_ADDR : Natural := 16#420#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_SP_EFF_ADDR : Natural := 16#424#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_0_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_ADDR : Natural := 16#440#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_STA_ADDR : Natural := 16#440#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_CTL_ADDR : Natural := 16#444#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_KP_ADDR : Natural := 16#448#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_TI_ADDR : Natural := 16#44c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_SP_ADDR : Natural := 16#450#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_DAC_ADDR : Natural := 16#454#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_LIM_ADDR : Natural := 16#458#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_CNT_ADDR : Natural := 16#45c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_ADC_DAC_EFF_ADDR : Natural := 16#460#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_SP_EFF_ADDR : Natural := 16#464#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_1_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_ADDR : Natural := 16#480#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_STA_ADDR : Natural := 16#480#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_CTL_ADDR : Natural := 16#484#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_KP_ADDR : Natural := 16#488#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_TI_ADDR : Natural := 16#48c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_SP_ADDR : Natural := 16#490#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_DAC_ADDR : Natural := 16#494#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_LIM_ADDR : Natural := 16#498#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_CNT_ADDR : Natural := 16#49c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_ADC_DAC_EFF_ADDR : Natural := 16#4a0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_SP_EFF_ADDR : Natural := 16#4a4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_2_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_ADDR : Natural := 16#4c0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_STA_ADDR : Natural := 16#4c0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_CTL_ADDR : Natural := 16#4c4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_KP_ADDR : Natural := 16#4c8#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_TI_ADDR : Natural := 16#4cc#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_SP_ADDR : Natural := 16#4d0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_DAC_ADDR : Natural := 16#4d4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_LIM_ADDR : Natural := 16#4d8#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_CNT_ADDR : Natural := 16#4dc#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_ADC_DAC_EFF_ADDR : Natural := 16#4e0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_SP_EFF_ADDR : Natural := 16#4e4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_3_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_ADDR : Natural := 16#500#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_STA_ADDR : Natural := 16#500#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_CTL_ADDR : Natural := 16#504#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_KP_ADDR : Natural := 16#508#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_TI_ADDR : Natural := 16#50c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_SP_ADDR : Natural := 16#510#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_DAC_ADDR : Natural := 16#514#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_LIM_ADDR : Natural := 16#518#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_CNT_ADDR : Natural := 16#51c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_ADC_DAC_EFF_ADDR : Natural := 16#520#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_SP_EFF_ADDR : Natural := 16#524#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_4_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_ADDR : Natural := 16#540#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_STA_ADDR : Natural := 16#540#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_CTL_ADDR : Natural := 16#544#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_KP_ADDR : Natural := 16#548#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_TI_ADDR : Natural := 16#54c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_SP_ADDR : Natural := 16#550#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_DAC_ADDR : Natural := 16#554#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_LIM_ADDR : Natural := 16#558#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_CNT_ADDR : Natural := 16#55c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_ADC_DAC_EFF_ADDR : Natural := 16#560#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_SP_EFF_ADDR : Natural := 16#564#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_5_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_ADDR : Natural := 16#580#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_STA_ADDR : Natural := 16#580#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_CTL_ADDR : Natural := 16#584#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_KP_ADDR : Natural := 16#588#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_TI_ADDR : Natural := 16#58c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_SP_ADDR : Natural := 16#590#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_DAC_ADDR : Natural := 16#594#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_LIM_ADDR : Natural := 16#598#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_CNT_ADDR : Natural := 16#59c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_ADC_DAC_EFF_ADDR : Natural := 16#5a0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_SP_EFF_ADDR : Natural := 16#5a4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_6_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_ADDR : Natural := 16#5c0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_STA_ADDR : Natural := 16#5c0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_CTL_ADDR : Natural := 16#5c4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_KP_ADDR : Natural := 16#5c8#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_TI_ADDR : Natural := 16#5cc#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_SP_ADDR : Natural := 16#5d0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_DAC_ADDR : Natural := 16#5d4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_LIM_ADDR : Natural := 16#5d8#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_CNT_ADDR : Natural := 16#5dc#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_ADC_DAC_EFF_ADDR : Natural := 16#5e0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_SP_EFF_ADDR : Natural := 16#5e4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_7_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_ADDR : Natural := 16#600#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_STA_ADDR : Natural := 16#600#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_CTL_ADDR : Natural := 16#604#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_KP_ADDR : Natural := 16#608#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_TI_ADDR : Natural := 16#60c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_SP_ADDR : Natural := 16#610#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_DAC_ADDR : Natural := 16#614#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_LIM_ADDR : Natural := 16#618#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_CNT_ADDR : Natural := 16#61c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_ADC_DAC_EFF_ADDR : Natural := 16#620#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_SP_EFF_ADDR : Natural := 16#624#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_8_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_ADDR : Natural := 16#640#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_STA_ADDR : Natural := 16#640#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_CTL_ADDR : Natural := 16#644#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_KP_ADDR : Natural := 16#648#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_TI_ADDR : Natural := 16#64c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_SP_ADDR : Natural := 16#650#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_DAC_ADDR : Natural := 16#654#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_LIM_ADDR : Natural := 16#658#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_CNT_ADDR : Natural := 16#65c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_ADC_DAC_EFF_ADDR : Natural := 16#660#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_SP_EFF_ADDR : Natural := 16#664#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_9_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_ADDR : Natural := 16#680#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_STA_ADDR : Natural := 16#680#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_CTL_ADDR : Natural := 16#684#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_KP_ADDR : Natural := 16#688#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_TI_ADDR : Natural := 16#68c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_SP_ADDR : Natural := 16#690#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_DAC_ADDR : Natural := 16#694#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_LIM_ADDR : Natural := 16#698#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_CNT_ADDR : Natural := 16#69c#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_ADC_DAC_EFF_ADDR : Natural := 16#6a0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_SP_EFF_ADDR : Natural := 16#6a4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_10_SP_EFF_SP_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_ADDR : Natural := 16#6c0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_SIZE : Natural := 64;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_STA_ADDR : Natural := 16#6c0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_L_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_L_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_R_OFFSET : Natural := 2;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_R_OFFSET : Natural := 3;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_STA_RESERVED_OFFSET : Natural := 4;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_CTL_ADDR : Natural := 16#6c4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_CTL_AMP_EN_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_CTL_MODE_OFFSET : Natural := 1;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_KP_ADDR : Natural := 16#6c8#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_KP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_KP_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_TI_ADDR : Natural := 16#6cc#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_TI_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_TI_RESERVED_OFFSET : Natural := 26;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_SP_ADDR : Natural := 16#6d0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_SP_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_PI_SP_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_DAC_ADDR : Natural := 16#6d4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_DAC_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_DAC_RESERVED_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_LIM_ADDR : Natural := 16#6d8#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_LIM_A_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_LIM_B_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_CNT_ADDR : Natural := 16#6dc#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_CNT_DATA_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_CNT_RESERVED_OFFSET : Natural := 22;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_ADC_DAC_EFF_ADDR : Natural := 16#6e0#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_ADC_DAC_EFF_ADC_OFFSET : Natural := 0;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_ADC_DAC_EFF_DAC_OFFSET : Natural := 16;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_SP_EFF_ADDR : Natural := 16#6e4#;
  constant c_WB_RTMLAMP_OHWR_REGS_CH_11_SP_EFF_SP_OFFSET : Natural := 0;
end package wb_rtmlamp_ohwr_regs_consts_pkg;
