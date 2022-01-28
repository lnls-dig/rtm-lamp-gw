target = "xilinx"
syn_device = "xc7a200t"
action = "simulation"
sim_tool = "ghdl"
top_module = "xwb_rtmlamp_ohwr_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08 -frelaxed"

sim_post_cmd = "ghdl -r --std=08 xwb_rtmlamp_ohwr_tb --wave=xwb_rtmlamp_ohwr_tb.ghw"
