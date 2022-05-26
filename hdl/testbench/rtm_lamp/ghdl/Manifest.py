target = "xilinx"
syn_device = "xc7a200t"
action = "simulation"
sim_tool = "ghdl"
top_module = "rtm_lamp_model_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08 -g -frelaxed"

sim_post_cmd = "ghdl -r --std=08 rtm_lamp_model_tb --wave=rtm_lamp_model_tb.ghw"
