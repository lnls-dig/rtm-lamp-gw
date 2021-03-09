#######################################################################
##                      Artix 7 AMC V3                               ##
#######################################################################
#

#######################################################################
##                          Clocks                                   ##
#######################################################################

# LINK01 clock. 156.25 MHz
create_clock -period 6.400 -name afc_link01_clk [get_ports afc_link01_clk_p_i]
set afc_link01_clk_period                       [get_property PERIOD [get_clocks afc_link01_clk]]

# Octo return clock
create_clock -period 10.000 -name rtmlamp_adc_octo_sck_ret    [get_ports rtmlamp_adc_octo_sck_ret_p_i]
set rtmlamp_adc_octo_sck_ret_clk_period                       [get_property PERIOD [get_clocks rtmlamp_adc_octo_sck_ret]]
# Virtual clock for Octo return clock
create_clock -period 10.000 -name virt_rtmlamp_adc_octo_sck_ret

# Quad return clock
create_clock -period 10.000 -name rtmlamp_adc_quad_sck_ret    [get_ports rtmlamp_adc_quad_sck_ret_p_i]
set rtmlamp_adc_quad_sck_ret_clk_period                       [get_property PERIOD [get_clocks rtmlamp_adc_quad_sck_ret]]
# Virtual clock for Quad return clock
create_clock -period 10.000 -name virt_rtmlamp_adc_quad_sck_ret

# Get master clocks for ADC/DAC/etc
set clk_master                                                [get_clocks -of_objects [get_nets clk_200mhz]]
set clk_master_period                                         [get_property PERIOD [get_clocks $clk_master]]

#######################################################################
##                          DIFF_TERM                                ##
#######################################################################

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sck_ret_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sck_ret_p_i]

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdoa_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdoa_p_i]

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdob_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdob_p_i]

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdoc_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdoc_p_i]

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdod_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_octo_sdod_p_i]

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_quad_sck_ret_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_quad_sck_ret_p_i]

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_quad_sdoa_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_quad_sdoa_p_i]

set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_quad_sdoc_n_i]
set_property DIFF_TERM TRUE                                   [get_ports rtmlamp_adc_quad_sdoc_p_i]

#######################################################################
##                          DELAYS                                   ##
#######################################################################
#
# From LTC2324-16 and LTC2320-16 data sheet (page 06)
#
# SDO Data Remains Valid Delay from CLKOUT falling edge:
# tHSDO_SDR 0.00ns (min) / 1.5ns (max)
#
# So, the rising edge at 0ns generates the window from 6.5ns to 15ns,
# or, equivalently, the rising edge at -10ns generates the window from
# -3.5ns to 5ns.
#
# From Xilinx constraints guide:
#
# Center-Aligned Rising Edge Source Synchronous Inputs
#
# For a center-aligned Source Synchronous interface, the clock
# transition is aligned with the center of the data valid window.
# The same clock edge is used for launching and capturing the
# data. The constraints below rely on the default timing
# analysis (setup = 1 cycle, hold = 0 cycle).
#
# input    ____           __________
# clock        |_________|          |_____
#                        |
#                 dv_bre | dv_are
#                <------>|<------>
#          __    ________|________    __
# data     __XXXX____Rise_Data____XXXX__
#
#
# Input Delay Constraint
# set_input_delay -clock $input_clock -max [expr $input_clock_period - $dv_bre] [get_ports $input_ports];
# set_input_delay -clock $input_clock -min $dv_are                              [get_ports $input_ports];
#
# For our case:
#
# input    ____           __________
# clock        |_________|          |_____
#                        |
#                  3.5ns |  5ns
#                <------>|<------>
#          __    ________|________    __
# data     __XXXX____Rise_Data____XXXX__
#

set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -max 6.5 [get_ports rtmlamp_adc_octo_sdoa_p_i];
set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -min 5.0 [get_ports rtmlamp_adc_octo_sdoa_p_i];
set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -max 6.5 [get_ports rtmlamp_adc_octo_sdob_p_i];
set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -min 5.0 [get_ports rtmlamp_adc_octo_sdob_p_i];
set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -max 6.5 [get_ports rtmlamp_adc_octo_sdoc_p_i];
set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -min 5.0 [get_ports rtmlamp_adc_octo_sdoc_p_i];
set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -max 6.5 [get_ports rtmlamp_adc_octo_sdod_p_i];
set_input_delay -clock virt_rtmlamp_adc_octo_sck_ret -min 5.0 [get_ports rtmlamp_adc_octo_sdod_p_i];

set_input_delay -clock virt_rtmlamp_adc_quad_sck_ret -max 6.5 [get_ports rtmlamp_adc_quad_sdoa_p_i];
set_input_delay -clock virt_rtmlamp_adc_quad_sck_ret -min 5.0 [get_ports rtmlamp_adc_quad_sdoa_p_i];
set_input_delay -clock virt_rtmlamp_adc_quad_sck_ret -max 6.5 [get_ports rtmlamp_adc_quad_sdoc_p_i];
set_input_delay -clock virt_rtmlamp_adc_quad_sck_ret -min 5.0 [get_ports rtmlamp_adc_quad_sdoc_p_i];

#######################################################################
##                          DELAY values                             ##
#######################################################################

## Overrides default_delay hdl parameter for the VARIABLE mode.
## For Artix7: Average Tap Delay at 200 MHz = 78 ps, at 300 MHz = 52 ps ???

#######################################################################
##                              CDC                                  ##
#######################################################################

# CDC between Wishbone clock and Transceiver clocks
# These are slow control registers taken care of synched by FFs.
# Give it 1x destination clock. Could be 2x, but lets keep things tight.
set_max_delay -datapath_only -from               [get_clocks clk_sys] -to [get_clocks afc_link01_clk]    $afc_link01_clk_period
set_max_delay -datapath_only -from               [get_clocks clk_sys] -to [get_clocks $clk_master]       $clk_master_period

set_max_delay -datapath_only -from               [get_clocks afc_link01_clk]    -to [get_clocks clk_sys] $clk_sys_period
set_max_delay -datapath_only -from               [get_clocks $clk_master]       -to [get_clocks clk_sys] $clk_sys_period

# CDC between Clk Aux (trigger clock) and FS clocks
# These are using pulse_synchronizer2 which is a full feedback sync.
# Give it 1x destination clock.
set_max_delay -datapath_only -from               [get_clocks clk_aux] -to [get_clocks afc_link01_clk]    $afc_link01_clk_period
set_max_delay -datapath_only -from               [get_clocks clk_aux] -to [get_clocks $clk_master]       $clk_master_period

# CDC between FS clocks and Clk Aux (trigger clock)
# These are using pulse_synchronizer2 which is a full feedback sync.
# Give it 1x destination clock.
set_max_delay -datapath_only -from               [get_clocks afc_link01_clk] -to [get_clocks clk_aux]    $clk_aux_period
set_max_delay -datapath_only -from               [get_clocks $clk_master]    -to [get_clocks clk_aux]    $clk_aux_period

#######################################################################
##                      Placement Constraints                        ##
#######################################################################
# Constrain the PCIe core elements placement, so that it won't fail
# timing analysis.
#create_pblock GRP_pcie_core
#add_cells_to_pblock [get_pblocks GRP_pcie_core] [get_cells -hier -filter {NAME =~ *pcie_core_i/*}]
#resize_pblock [get_pblocks GRP_pcie_core] -add {CLOCKREGION_X0Y4:CLOCKREGION_X0Y4}
