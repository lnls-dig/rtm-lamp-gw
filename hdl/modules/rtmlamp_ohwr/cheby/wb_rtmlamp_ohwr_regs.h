#ifndef __CHEBY__WB_RTMLAMP_OHWR_REGS__H__
#define __CHEBY__WB_RTMLAMP_OHWR_REGS__H__
#define WB_RTMLAMP_OHWR_REGS_SIZE 2048 /* 0x800 = 2KB */

/* General RTM status register */
#define WB_RTMLAMP_OHWR_REGS_STA 0x0UL
#define WB_RTMLAMP_OHWR_REGS_STA_RESERVED_MASK 0xffffffffUL
#define WB_RTMLAMP_OHWR_REGS_STA_RESERVED_SHIFT 0

/* General RTM control register */
#define WB_RTMLAMP_OHWR_REGS_CTL 0x4UL
#define WB_RTMLAMP_OHWR_REGS_CTL_RESERVED_MASK 0xffffffffUL
#define WB_RTMLAMP_OHWR_REGS_CTL_RESERVED_SHIFT 0

/* None */
#define WB_RTMLAMP_OHWR_REGS_CH 0x400UL
#define WB_RTMLAMP_OHWR_REGS_CH_SIZE 64 /* 0x40 */

/* Channel status register */
#define WB_RTMLAMP_OHWR_REGS_CH_STA 0x0UL
#define WB_RTMLAMP_OHWR_REGS_CH_STA_AMP_IFLAG_L 0x1UL
#define WB_RTMLAMP_OHWR_REGS_CH_STA_AMP_TFLAG_L 0x2UL
#define WB_RTMLAMP_OHWR_REGS_CH_STA_AMP_IFLAG_R 0x4UL
#define WB_RTMLAMP_OHWR_REGS_CH_STA_AMP_TFLAG_R 0x8UL
#define WB_RTMLAMP_OHWR_REGS_CH_STA_RESERVED_MASK 0xfffffff0UL
#define WB_RTMLAMP_OHWR_REGS_CH_STA_RESERVED_SHIFT 4

/* Channel control register */
#define WB_RTMLAMP_OHWR_REGS_CH_CTL 0x4UL
#define WB_RTMLAMP_OHWR_REGS_CH_CTL_AMP_EN 0x1UL
#define WB_RTMLAMP_OHWR_REGS_CH_CTL_MODE_MASK 0xeUL
#define WB_RTMLAMP_OHWR_REGS_CH_CTL_MODE_SHIFT 1

/* PI KP parameter */
#define WB_RTMLAMP_OHWR_REGS_CH_PI_KP 0x8UL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_KP_DATA_MASK 0x3ffffffUL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_KP_DATA_SHIFT 0
#define WB_RTMLAMP_OHWR_REGS_CH_PI_KP_RESERVED_MASK 0xfc000000UL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_KP_RESERVED_SHIFT 26

/* PI TI parameter */
#define WB_RTMLAMP_OHWR_REGS_CH_PI_TI 0xcUL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_TI_DATA_MASK 0x3ffffffUL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_TI_DATA_SHIFT 0
#define WB_RTMLAMP_OHWR_REGS_CH_PI_TI_RESERVED_MASK 0xfc000000UL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_TI_RESERVED_SHIFT 26

/* PI Setpoint parameter */
#define WB_RTMLAMP_OHWR_REGS_CH_PI_SP 0x10UL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_SP_DATA_MASK 0xffffUL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_SP_DATA_SHIFT 0
#define WB_RTMLAMP_OHWR_REGS_CH_PI_SP_RESERVED_MASK 0xffff0000UL
#define WB_RTMLAMP_OHWR_REGS_CH_PI_SP_RESERVED_SHIFT 16

/* DAC channel control register */
#define WB_RTMLAMP_OHWR_REGS_CH_DAC 0x14UL
#define WB_RTMLAMP_OHWR_REGS_CH_DAC_DATA_MASK 0xffffUL
#define WB_RTMLAMP_OHWR_REGS_CH_DAC_DATA_SHIFT 0
#define WB_RTMLAMP_OHWR_REGS_CH_DAC_RESERVED_MASK 0xffff0000UL
#define WB_RTMLAMP_OHWR_REGS_CH_DAC_RESERVED_SHIFT 16

/* Channel square wave limits */
#define WB_RTMLAMP_OHWR_REGS_CH_LIM 0x18UL
#define WB_RTMLAMP_OHWR_REGS_CH_LIM_A_MASK 0xffffUL
#define WB_RTMLAMP_OHWR_REGS_CH_LIM_A_SHIFT 0
#define WB_RTMLAMP_OHWR_REGS_CH_LIM_B_MASK 0xffff0000UL
#define WB_RTMLAMP_OHWR_REGS_CH_LIM_B_SHIFT 16

/* Test mode period, in clock ticks.
 */
#define WB_RTMLAMP_OHWR_REGS_CH_CNT 0x1cUL
#define WB_RTMLAMP_OHWR_REGS_CH_CNT_DATA_MASK 0x3fffffUL
#define WB_RTMLAMP_OHWR_REGS_CH_CNT_DATA_SHIFT 0
#define WB_RTMLAMP_OHWR_REGS_CH_CNT_RESERVED_MASK 0xffc00000UL
#define WB_RTMLAMP_OHWR_REGS_CH_CNT_RESERVED_SHIFT 22

struct wb_rtmlamp_ohwr_regs {
  /* [0x0]: REG (ro) General RTM status register */
  uint32_t sta;

  /* [0x4]: REG (rw) General RTM control register */
  uint32_t ctl;

  /* padding to: 256 words */
  uint32_t __padding_0[254];

  /* [0x400]: REPEAT (no description) */
  struct ch {
    /* [0x0]: REG (ro) Channel status register */
    uint32_t sta;

    /* [0x4]: REG (rw) Channel control register */
    uint32_t ctl;

    /* [0x8]: REG (rw) PI KP parameter */
    uint32_t pi_kp;

    /* [0xc]: REG (rw) PI TI parameter */
    uint32_t pi_ti;

    /* [0x10]: REG (rw) PI Setpoint parameter */
    uint32_t pi_sp;

    /* [0x14]: REG (rw) DAC channel control register */
    uint32_t dac;

    /* [0x18]: REG (rw) Channel square wave limits */
    uint32_t lim;

    /* [0x1c]: REG (rw) Test mode period, in clock ticks.
 */
    uint32_t cnt;

    /* padding to: 7 words */
    uint32_t __padding_0[8];
  } ch[12];

  /* padding to: 256 words */
  uint32_t __padding_1[64];
};

#endif /* __CHEBY__WB_RTMLAMP_OHWR_REGS__H__ */
