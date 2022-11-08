files = [
    "xwb_rtmlamp_ohwr_tb.vhd",
    "xwb_rtmlamp_ohwr_glue.vhd",
    "../../sim/regs/wb_rtmlamp_ohwr_reg_consts.vhd"
]

modules = {"local" : [
    "../../ip_cores/general-cores",
    "../../ip_cores/general-cores/sim/vhdl",
    "../../ip_cores/infra-cores",
    "../../sim/rtm_model",
    "../../modules"
]}
