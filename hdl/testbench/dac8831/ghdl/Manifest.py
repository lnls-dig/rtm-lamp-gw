action = "simulation"
sim_tool = "ghdl"
top_module = "dac8831_model_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r --std=08 dac8831_model_tb --wave=dac8831_model_tb.ghw"
