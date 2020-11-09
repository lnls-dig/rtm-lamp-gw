action = "simulation"
sim_tool = "ghdl"
top_module = "magnet_model_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r magnet_model_tb --wave=magnet_model_tb.ghw"
