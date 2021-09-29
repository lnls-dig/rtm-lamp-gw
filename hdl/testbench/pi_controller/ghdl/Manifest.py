action = "simulation"
sim_tool = "ghdl"
top_module = "pi_controller_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r --std=08 pi_controller_tb --wave=pi_controller_tb.ghw"
