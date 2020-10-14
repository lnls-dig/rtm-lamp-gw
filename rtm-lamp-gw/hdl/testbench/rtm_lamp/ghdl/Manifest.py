action = "simulation"
sim_tool = "ghdl"
top_module = "rtm_lamp_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r rtm_lamp_tb --wave=rtm_lamp_tb.ghw"
