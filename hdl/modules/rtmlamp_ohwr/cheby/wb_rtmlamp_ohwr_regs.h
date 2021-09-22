#ifndef __CHEBY__RTMLAMP_OHWR_REGS__H__
#define __CHEBY__RTMLAMP_OHWR_REGS__H__
#define RTMLAMP_OHWR_REGS_SIZE 552 /* 0x228 */

/* General RTM status register */
#define RTMLAMP_OHWR_REGS_STA 0x0UL
#define RTMLAMP_OHWR_REGS_STA_RESERVED_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_STA_RESERVED_SHIFT 0

/* General RTM control register */
#define RTMLAMP_OHWR_REGS_CTL 0x4UL
#define RTMLAMP_OHWR_REGS_CTL_DAC_DATA_FROM_WB 0x1UL
#define RTMLAMP_OHWR_REGS_CTL_RESERVED_MASK 0xfffffffeUL
#define RTMLAMP_OHWR_REGS_CTL_RESERVED_SHIFT 1

/* Channel 0 status register */
#define RTMLAMP_OHWR_REGS_CH_0_STA 0x100UL
#define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_0_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_0_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_0_STA_RESERVED_SHIFT 4

/* Channel 0 control register */
#define RTMLAMP_OHWR_REGS_CH_0_CTL 0x104UL
#define RTMLAMP_OHWR_REGS_CH_0_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_0_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_0_PI_KP 0x108UL
#define RTMLAMP_OHWR_REGS_CH_0_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_0_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_0_PI_TI 0x10cUL
#define RTMLAMP_OHWR_REGS_CH_0_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_0_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_0_PI_SP 0x110UL
#define RTMLAMP_OHWR_REGS_CH_0_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_0_PI_SP_DATA_SHIFT 0

/* DAC channel 0 control register */
#define RTMLAMP_OHWR_REGS_CH_0_DAC 0x114UL
#define RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_0_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_0_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_0_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_0_DAC_RESERVED_SHIFT 17

/* Channel 1 status register */
#define RTMLAMP_OHWR_REGS_CH_1_STA 0x118UL
#define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_1_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_1_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_1_STA_RESERVED_SHIFT 4

/* Channel 1 control register */
#define RTMLAMP_OHWR_REGS_CH_1_CTL 0x11cUL
#define RTMLAMP_OHWR_REGS_CH_1_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_1_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_1_PI_KP 0x120UL
#define RTMLAMP_OHWR_REGS_CH_1_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_1_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_1_PI_TI 0x124UL
#define RTMLAMP_OHWR_REGS_CH_1_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_1_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_1_PI_SP 0x128UL
#define RTMLAMP_OHWR_REGS_CH_1_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_1_PI_SP_DATA_SHIFT 0

/* DAC channel 1 control register */
#define RTMLAMP_OHWR_REGS_CH_1_DAC 0x12cUL
#define RTMLAMP_OHWR_REGS_CH_1_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_1_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_1_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_1_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_1_DAC_RESERVED_SHIFT 17

/* Channel 2 status register */
#define RTMLAMP_OHWR_REGS_CH_2_STA 0x130UL
#define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_2_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_2_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_2_STA_RESERVED_SHIFT 4

/* Channel 2 control register */
#define RTMLAMP_OHWR_REGS_CH_2_CTL 0x134UL
#define RTMLAMP_OHWR_REGS_CH_2_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_2_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_2_PI_KP 0x138UL
#define RTMLAMP_OHWR_REGS_CH_2_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_2_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_2_PI_TI 0x13cUL
#define RTMLAMP_OHWR_REGS_CH_2_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_2_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_2_PI_SP 0x140UL
#define RTMLAMP_OHWR_REGS_CH_2_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_2_PI_SP_DATA_SHIFT 0

/* DAC channel 2 control register */
#define RTMLAMP_OHWR_REGS_CH_2_DAC 0x144UL
#define RTMLAMP_OHWR_REGS_CH_2_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_2_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_2_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_2_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_2_DAC_RESERVED_SHIFT 17

/* Channel 3 status register */
#define RTMLAMP_OHWR_REGS_CH_3_STA 0x148UL
#define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_3_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_3_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_3_STA_RESERVED_SHIFT 4

/* Channel 3 control register */
#define RTMLAMP_OHWR_REGS_CH_3_CTL 0x14cUL
#define RTMLAMP_OHWR_REGS_CH_3_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_3_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_3_PI_KP 0x150UL
#define RTMLAMP_OHWR_REGS_CH_3_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_3_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_3_PI_TI 0x154UL
#define RTMLAMP_OHWR_REGS_CH_3_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_3_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_3_PI_SP 0x158UL
#define RTMLAMP_OHWR_REGS_CH_3_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_3_PI_SP_DATA_SHIFT 0

/* DAC channel 3 control register */
#define RTMLAMP_OHWR_REGS_CH_3_DAC 0x15cUL
#define RTMLAMP_OHWR_REGS_CH_3_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_3_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_3_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_3_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_3_DAC_RESERVED_SHIFT 17

/* Channel 4 status register */
#define RTMLAMP_OHWR_REGS_CH_4_STA 0x160UL
#define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_4_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_4_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_4_STA_RESERVED_SHIFT 4

/* Channel 4 control register */
#define RTMLAMP_OHWR_REGS_CH_4_CTL 0x164UL
#define RTMLAMP_OHWR_REGS_CH_4_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_4_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_4_PI_KP 0x168UL
#define RTMLAMP_OHWR_REGS_CH_4_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_4_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_4_PI_TI 0x16cUL
#define RTMLAMP_OHWR_REGS_CH_4_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_4_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_4_PI_SP 0x170UL
#define RTMLAMP_OHWR_REGS_CH_4_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_4_PI_SP_DATA_SHIFT 0

/* DAC channel 4 control register */
#define RTMLAMP_OHWR_REGS_CH_4_DAC 0x174UL
#define RTMLAMP_OHWR_REGS_CH_4_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_4_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_4_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_4_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_4_DAC_RESERVED_SHIFT 17

/* Channel 5 status register */
#define RTMLAMP_OHWR_REGS_CH_5_STA 0x178UL
#define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_5_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_5_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_5_STA_RESERVED_SHIFT 4

/* Channel 5 control register */
#define RTMLAMP_OHWR_REGS_CH_5_CTL 0x17cUL
#define RTMLAMP_OHWR_REGS_CH_5_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_5_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_5_PI_KP 0x180UL
#define RTMLAMP_OHWR_REGS_CH_5_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_5_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_5_PI_TI 0x184UL
#define RTMLAMP_OHWR_REGS_CH_5_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_5_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_5_PI_SP 0x188UL
#define RTMLAMP_OHWR_REGS_CH_5_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_5_PI_SP_DATA_SHIFT 0

/* DAC channel 5 control register */
#define RTMLAMP_OHWR_REGS_CH_5_DAC 0x18cUL
#define RTMLAMP_OHWR_REGS_CH_5_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_5_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_5_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_5_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_5_DAC_RESERVED_SHIFT 17

/* Channel 6 status register */
#define RTMLAMP_OHWR_REGS_CH_6_STA 0x190UL
#define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_6_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_6_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_6_STA_RESERVED_SHIFT 4

/* Channel 6 control register */
#define RTMLAMP_OHWR_REGS_CH_6_CTL 0x194UL
#define RTMLAMP_OHWR_REGS_CH_6_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_6_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_6_PI_KP 0x198UL
#define RTMLAMP_OHWR_REGS_CH_6_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_6_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_6_PI_TI 0x19cUL
#define RTMLAMP_OHWR_REGS_CH_6_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_6_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_6_PI_SP 0x1a0UL
#define RTMLAMP_OHWR_REGS_CH_6_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_6_PI_SP_DATA_SHIFT 0

/* DAC channel 6 control register */
#define RTMLAMP_OHWR_REGS_CH_6_DAC 0x1a4UL
#define RTMLAMP_OHWR_REGS_CH_6_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_6_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_6_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_6_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_6_DAC_RESERVED_SHIFT 17

/* Channel 7 status register */
#define RTMLAMP_OHWR_REGS_CH_7_STA 0x1a8UL
#define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_7_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_7_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_7_STA_RESERVED_SHIFT 4

/* Channel 7 control register */
#define RTMLAMP_OHWR_REGS_CH_7_CTL 0x1acUL
#define RTMLAMP_OHWR_REGS_CH_7_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_7_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_7_PI_KP 0x1b0UL
#define RTMLAMP_OHWR_REGS_CH_7_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_7_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_7_PI_TI 0x1b4UL
#define RTMLAMP_OHWR_REGS_CH_7_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_7_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_7_PI_SP 0x1b8UL
#define RTMLAMP_OHWR_REGS_CH_7_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_7_PI_SP_DATA_SHIFT 0

/* DAC channel 7 control register */
#define RTMLAMP_OHWR_REGS_CH_7_DAC 0x1bcUL
#define RTMLAMP_OHWR_REGS_CH_7_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_7_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_7_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_7_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_7_DAC_RESERVED_SHIFT 17

/* Channel 8 status register */
#define RTMLAMP_OHWR_REGS_CH_8_STA 0x1c0UL
#define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_8_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_8_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_8_STA_RESERVED_SHIFT 4

/* Channel 8 control register */
#define RTMLAMP_OHWR_REGS_CH_8_CTL 0x1c4UL
#define RTMLAMP_OHWR_REGS_CH_8_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_8_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_8_PI_KP 0x1c8UL
#define RTMLAMP_OHWR_REGS_CH_8_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_8_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_8_PI_TI 0x1ccUL
#define RTMLAMP_OHWR_REGS_CH_8_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_8_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_8_PI_SP 0x1d0UL
#define RTMLAMP_OHWR_REGS_CH_8_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_8_PI_SP_DATA_SHIFT 0

/* DAC channel 8 control register */
#define RTMLAMP_OHWR_REGS_CH_8_DAC 0x1d4UL
#define RTMLAMP_OHWR_REGS_CH_8_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_8_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_8_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_8_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_8_DAC_RESERVED_SHIFT 17

/* Channel 9 status register */
#define RTMLAMP_OHWR_REGS_CH_9_STA 0x1d8UL
#define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_9_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_9_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_9_STA_RESERVED_SHIFT 4

/* Channel 9 control register */
#define RTMLAMP_OHWR_REGS_CH_9_CTL 0x1dcUL
#define RTMLAMP_OHWR_REGS_CH_9_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_9_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_9_PI_KP 0x1e0UL
#define RTMLAMP_OHWR_REGS_CH_9_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_9_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_9_PI_TI 0x1e4UL
#define RTMLAMP_OHWR_REGS_CH_9_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_9_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_9_PI_SP 0x1e8UL
#define RTMLAMP_OHWR_REGS_CH_9_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_9_PI_SP_DATA_SHIFT 0

/* DAC channel 9 control register */
#define RTMLAMP_OHWR_REGS_CH_9_DAC 0x1ecUL
#define RTMLAMP_OHWR_REGS_CH_9_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_9_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_9_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_9_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_9_DAC_RESERVED_SHIFT 17

/* Channel 10 status register */
#define RTMLAMP_OHWR_REGS_CH_10_STA 0x1f0UL
#define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_10_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_10_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_10_STA_RESERVED_SHIFT 4

/* Channel 10 control register */
#define RTMLAMP_OHWR_REGS_CH_10_CTL 0x1f4UL
#define RTMLAMP_OHWR_REGS_CH_10_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_10_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_10_PI_KP 0x1f8UL
#define RTMLAMP_OHWR_REGS_CH_10_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_10_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_10_PI_TI 0x1fcUL
#define RTMLAMP_OHWR_REGS_CH_10_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_10_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_10_PI_SP 0x200UL
#define RTMLAMP_OHWR_REGS_CH_10_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_10_PI_SP_DATA_SHIFT 0

/* DAC channel 10 control register */
#define RTMLAMP_OHWR_REGS_CH_10_DAC 0x204UL
#define RTMLAMP_OHWR_REGS_CH_10_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_10_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_10_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_10_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_10_DAC_RESERVED_SHIFT 17

/* Channel 11 status register */
#define RTMLAMP_OHWR_REGS_CH_11_STA 0x208UL
#define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_L 0x1UL
#define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_L 0x2UL
#define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_IFLAG_R 0x4UL
#define RTMLAMP_OHWR_REGS_CH_11_STA_AMP_TFLAG_R 0x8UL
#define RTMLAMP_OHWR_REGS_CH_11_STA_RESERVED_MASK 0xfffffff0UL
#define RTMLAMP_OHWR_REGS_CH_11_STA_RESERVED_SHIFT 4

/* Channel 11 control register */
#define RTMLAMP_OHWR_REGS_CH_11_CTL 0x20cUL
#define RTMLAMP_OHWR_REGS_CH_11_CTL_AMP_EN 0x1UL
#define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_OL_TRIANG_ENABLE 0x2UL
#define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_OL_SQUARE_ENABLE 0x4UL
#define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_SP_SQUARE_ENABLE 0x8UL
#define RTMLAMP_OHWR_REGS_CH_11_CTL_PI_ENABLE 0x10UL

/* PI KP parameter */
#define RTMLAMP_OHWR_REGS_CH_11_PI_KP 0x210UL
#define RTMLAMP_OHWR_REGS_CH_11_PI_KP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_11_PI_KP_DATA_SHIFT 0

/* PI TI parameter */
#define RTMLAMP_OHWR_REGS_CH_11_PI_TI 0x214UL
#define RTMLAMP_OHWR_REGS_CH_11_PI_TI_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_11_PI_TI_DATA_SHIFT 0

/* PI Setpoint parameter */
#define RTMLAMP_OHWR_REGS_CH_11_PI_SP 0x218UL
#define RTMLAMP_OHWR_REGS_CH_11_PI_SP_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_CH_11_PI_SP_DATA_SHIFT 0

/* DAC channel 11 control register */
#define RTMLAMP_OHWR_REGS_CH_11_DAC 0x21cUL
#define RTMLAMP_OHWR_REGS_CH_11_DAC_DATA_MASK 0xffffUL
#define RTMLAMP_OHWR_REGS_CH_11_DAC_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_CH_11_DAC_WR 0x10000UL
#define RTMLAMP_OHWR_REGS_CH_11_DAC_RESERVED_MASK 0xfffe0000UL
#define RTMLAMP_OHWR_REGS_CH_11_DAC_RESERVED_SHIFT 17

/* PI open-loop DAC test mode period, in clock ticks.
This defines the period of open-loop test waveforms
 */
#define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX 0x220UL
#define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_DATA_MASK 0x3fffffUL
#define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_DATA_SHIFT 0
#define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_RESERVED_MASK 0xffc00000UL
#define RTMLAMP_OHWR_REGS_PI_OL_DAC_CNT_MAX_RESERVED_SHIFT 22

/* PI open-loop DAC test mode inferior limit. The upper limit is the setpoint itself.
 */
#define RTMLAMP_OHWR_REGS_PI_SP_LIM_INF 0x224UL
#define RTMLAMP_OHWR_REGS_PI_SP_LIM_INF_DATA_MASK 0xffffffffUL
#define RTMLAMP_OHWR_REGS_PI_SP_LIM_INF_DATA_SHIFT 0

struct rtmlamp_ohwr_regs {
  /* [0x0]: REG (ro) General RTM status register */
  uint32_t sta;

  /* [0x4]: REG (rw) General RTM control register */
  uint32_t ctl;

  /* padding to: 64 words */
  uint32_t __padding_0[62];

  /* [0x100]: REG (ro) Channel 0 status register */
  uint32_t ch_0_sta;

  /* [0x104]: REG (rw) Channel 0 control register */
  uint32_t ch_0_ctl;

  /* [0x108]: REG (rw) PI KP parameter */
  uint32_t ch_0_pi_kp;

  /* [0x10c]: REG (rw) PI TI parameter */
  uint32_t ch_0_pi_ti;

  /* [0x110]: REG (rw) PI Setpoint parameter */
  uint32_t ch_0_pi_sp;

  /* [0x114]: REG (rw) DAC channel 0 control register */
  uint32_t ch_0_dac;

  /* [0x118]: REG (ro) Channel 1 status register */
  uint32_t ch_1_sta;

  /* [0x11c]: REG (rw) Channel 1 control register */
  uint32_t ch_1_ctl;

  /* [0x120]: REG (rw) PI KP parameter */
  uint32_t ch_1_pi_kp;

  /* [0x124]: REG (rw) PI TI parameter */
  uint32_t ch_1_pi_ti;

  /* [0x128]: REG (rw) PI Setpoint parameter */
  uint32_t ch_1_pi_sp;

  /* [0x12c]: REG (rw) DAC channel 1 control register */
  uint32_t ch_1_dac;

  /* [0x130]: REG (ro) Channel 2 status register */
  uint32_t ch_2_sta;

  /* [0x134]: REG (rw) Channel 2 control register */
  uint32_t ch_2_ctl;

  /* [0x138]: REG (rw) PI KP parameter */
  uint32_t ch_2_pi_kp;

  /* [0x13c]: REG (rw) PI TI parameter */
  uint32_t ch_2_pi_ti;

  /* [0x140]: REG (rw) PI Setpoint parameter */
  uint32_t ch_2_pi_sp;

  /* [0x144]: REG (rw) DAC channel 2 control register */
  uint32_t ch_2_dac;

  /* [0x148]: REG (ro) Channel 3 status register */
  uint32_t ch_3_sta;

  /* [0x14c]: REG (rw) Channel 3 control register */
  uint32_t ch_3_ctl;

  /* [0x150]: REG (rw) PI KP parameter */
  uint32_t ch_3_pi_kp;

  /* [0x154]: REG (rw) PI TI parameter */
  uint32_t ch_3_pi_ti;

  /* [0x158]: REG (rw) PI Setpoint parameter */
  uint32_t ch_3_pi_sp;

  /* [0x15c]: REG (rw) DAC channel 3 control register */
  uint32_t ch_3_dac;

  /* [0x160]: REG (ro) Channel 4 status register */
  uint32_t ch_4_sta;

  /* [0x164]: REG (rw) Channel 4 control register */
  uint32_t ch_4_ctl;

  /* [0x168]: REG (rw) PI KP parameter */
  uint32_t ch_4_pi_kp;

  /* [0x16c]: REG (rw) PI TI parameter */
  uint32_t ch_4_pi_ti;

  /* [0x170]: REG (rw) PI Setpoint parameter */
  uint32_t ch_4_pi_sp;

  /* [0x174]: REG (rw) DAC channel 4 control register */
  uint32_t ch_4_dac;

  /* [0x178]: REG (ro) Channel 5 status register */
  uint32_t ch_5_sta;

  /* [0x17c]: REG (rw) Channel 5 control register */
  uint32_t ch_5_ctl;

  /* [0x180]: REG (rw) PI KP parameter */
  uint32_t ch_5_pi_kp;

  /* [0x184]: REG (rw) PI TI parameter */
  uint32_t ch_5_pi_ti;

  /* [0x188]: REG (rw) PI Setpoint parameter */
  uint32_t ch_5_pi_sp;

  /* [0x18c]: REG (rw) DAC channel 5 control register */
  uint32_t ch_5_dac;

  /* [0x190]: REG (ro) Channel 6 status register */
  uint32_t ch_6_sta;

  /* [0x194]: REG (rw) Channel 6 control register */
  uint32_t ch_6_ctl;

  /* [0x198]: REG (rw) PI KP parameter */
  uint32_t ch_6_pi_kp;

  /* [0x19c]: REG (rw) PI TI parameter */
  uint32_t ch_6_pi_ti;

  /* [0x1a0]: REG (rw) PI Setpoint parameter */
  uint32_t ch_6_pi_sp;

  /* [0x1a4]: REG (rw) DAC channel 6 control register */
  uint32_t ch_6_dac;

  /* [0x1a8]: REG (ro) Channel 7 status register */
  uint32_t ch_7_sta;

  /* [0x1ac]: REG (rw) Channel 7 control register */
  uint32_t ch_7_ctl;

  /* [0x1b0]: REG (rw) PI KP parameter */
  uint32_t ch_7_pi_kp;

  /* [0x1b4]: REG (rw) PI TI parameter */
  uint32_t ch_7_pi_ti;

  /* [0x1b8]: REG (rw) PI Setpoint parameter */
  uint32_t ch_7_pi_sp;

  /* [0x1bc]: REG (rw) DAC channel 7 control register */
  uint32_t ch_7_dac;

  /* [0x1c0]: REG (ro) Channel 8 status register */
  uint32_t ch_8_sta;

  /* [0x1c4]: REG (rw) Channel 8 control register */
  uint32_t ch_8_ctl;

  /* [0x1c8]: REG (rw) PI KP parameter */
  uint32_t ch_8_pi_kp;

  /* [0x1cc]: REG (rw) PI TI parameter */
  uint32_t ch_8_pi_ti;

  /* [0x1d0]: REG (rw) PI Setpoint parameter */
  uint32_t ch_8_pi_sp;

  /* [0x1d4]: REG (rw) DAC channel 8 control register */
  uint32_t ch_8_dac;

  /* [0x1d8]: REG (ro) Channel 9 status register */
  uint32_t ch_9_sta;

  /* [0x1dc]: REG (rw) Channel 9 control register */
  uint32_t ch_9_ctl;

  /* [0x1e0]: REG (rw) PI KP parameter */
  uint32_t ch_9_pi_kp;

  /* [0x1e4]: REG (rw) PI TI parameter */
  uint32_t ch_9_pi_ti;

  /* [0x1e8]: REG (rw) PI Setpoint parameter */
  uint32_t ch_9_pi_sp;

  /* [0x1ec]: REG (rw) DAC channel 9 control register */
  uint32_t ch_9_dac;

  /* [0x1f0]: REG (ro) Channel 10 status register */
  uint32_t ch_10_sta;

  /* [0x1f4]: REG (rw) Channel 10 control register */
  uint32_t ch_10_ctl;

  /* [0x1f8]: REG (rw) PI KP parameter */
  uint32_t ch_10_pi_kp;

  /* [0x1fc]: REG (rw) PI TI parameter */
  uint32_t ch_10_pi_ti;

  /* [0x200]: REG (rw) PI Setpoint parameter */
  uint32_t ch_10_pi_sp;

  /* [0x204]: REG (rw) DAC channel 10 control register */
  uint32_t ch_10_dac;

  /* [0x208]: REG (ro) Channel 11 status register */
  uint32_t ch_11_sta;

  /* [0x20c]: REG (rw) Channel 11 control register */
  uint32_t ch_11_ctl;

  /* [0x210]: REG (rw) PI KP parameter */
  uint32_t ch_11_pi_kp;

  /* [0x214]: REG (rw) PI TI parameter */
  uint32_t ch_11_pi_ti;

  /* [0x218]: REG (rw) PI Setpoint parameter */
  uint32_t ch_11_pi_sp;

  /* [0x21c]: REG (rw) DAC channel 11 control register */
  uint32_t ch_11_dac;

  /* [0x220]: REG (rw) PI open-loop DAC test mode period, in clock ticks.
This defines the period of open-loop test waveforms
 */
  uint32_t pi_ol_dac_cnt_max;

  /* [0x224]: REG (rw) PI open-loop DAC test mode inferior limit. The upper limit is the setpoint itself.
 */
  uint32_t pi_sp_lim_inf;
};

#endif /* __CHEBY__RTMLAMP_OHWR_REGS__H__ */
