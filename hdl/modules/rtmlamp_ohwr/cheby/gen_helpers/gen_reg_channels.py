#!/usr/bin/env python3
from string import Template

reg = Template(
   """
    - reg:
        name: ch_${CHAN_NUM}_sta
        width: 32
        access: ro
        description: Channel ${CHAN_NUM} status register
        address: ${ADDR_0}
        comment: |
          Channel ${CHAN_NUM} status register
        children:
          - field:
              name: amp_iflag_l
              range: 0
              description: Amplifier Left Current Limit Flag (IFLAG_L)
              comment: |
                read 0: current above limit
                read 1: current under limit
              x-wbgen:
                access_bus: READ_ONLY
                access_dev: WRITE_ONLY
                type: BIT
          - field:
              name: amp_tflag_l
              range: 1
              description: Amplifier Left Thermal Limit Flag (TFLAG_L)
              comment: |
                read 0: temperature above limit
                read 1: temperature under limit
              x-wbgen:
                access_bus: READ_ONLY
                access_dev: WRITE_ONLY
                type: BIT
          - field:
              name: amp_iflag_r
              range: 2
              description: Amplifier Right Current Limit Flag (IFLAG_R)
              comment: |
                read 0: current above limit
                read 1: current under limit
              x-wbgen:
                access_bus: READ_ONLY
                access_dev: WRITE_ONLY
                type: BIT
          - field:
              name: amp_tflag_r
              range: 3
              description: Amplifier Right Thermal Limit Flag (TFLAG_R)
              comment: |
                read 0: temperature above limit
                read 1: temperature under limit
              x-wbgen:
                access_bus: READ_ONLY
                access_dev: WRITE_ONLY
                type: BIT
          - field:
              name: reserved
              range: 31-4
              description: reserved
              comment: |
                reserved
              x-wbgen:
                access_bus: READ_ONLY
                access_dev: WRITE_ONLY
                type: SLV
    - reg:
        name: ch_${CHAN_NUM}_ctl
        width: 32
        access: rw
        description: Channel ${CHAN_NUM} control register
        address: ${ADDR_1}
        comment: |
          Channel ${CHAN_NUM} control register
        children:
          - field:
              name: amp_en
              range: 0
              description: Amplifier Enable
              comment: |
                write 0: disable amplifier
                write 1: enable amplifier
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: BIT
          - field:
              name: pi_ol_triang_enable
              range: 1
              description: PI open-loop triangular test mode
              comment: |
                write 0: disable PI triangular test mode
                write 1: enable PI triangular test mode
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: BIT
          - field:
              name: pi_ol_square_enable
              range: 2
              description: PI open-loop square test mode
              comment: |
                write 0: disable PI square test mode
                write 1: enable PI square test mode
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: BIT
          - field:
              name: pi_sp_square_enable
              range: 3
              description: PI setpoint square test mode
              comment: |
                write 0: disable PI setpoint square test mode
                write 1: enable PI setpoint square test mode
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: BIT
          - field:
              name: pi_enable
              range: 4
              description: PI enable
              comment: |
                write 0: disable PI control
                write 1: enable PI control
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: BIT
    - reg:
        name: ch_${CHAN_NUM}_dac
        width: 32
        access: rw
        description: DAC channel ${CHAN_NUM} control register
        address: ${ADDR_2}
        comment: |
          DAC channel ${CHAN_NUM} control register
        children:
          - field:
              name: data
              range: 15-0
              description: DAC data
              comment: |
                Write DAC data for channel
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: SLV
                clock: dac_master_clk_i
          - field:
              name: wr
              range: 16
              description: Write DAC data to external CI
              comment: |
                write 0: nothing
                write 1: DAC data written to external CI (auto-cleared)
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: MONOSTABLE
                clock: dac_master_clk_i
          - field:
              name: reserved
              range: 31-17
              description: reserved
              comment: |
                reserved
              x-wbgen:
                access_bus: READ_WRITE
                access_dev: READ_ONLY
                type: SLV
                clock: dac_master_clk_i
"""
)

cheby_regs = ""
addr = 256
for channel in range(0,12):
    addr_0_hex = "0x{:08X}".format(addr)
    addr += 4
    addr_1_hex = "0x{:08X}".format(addr)
    addr += 4
    addr_2_hex = "0x{:08X}".format(addr)
    addr += 4
    cheby_regs += reg.safe_substitute(CHAN_NUM=channel,
                                     ADDR_0=addr_0_hex,
                                     ADDR_1=addr_1_hex,
                                     ADDR_2=addr_2_hex)

print("{}".format(cheby_regs))
