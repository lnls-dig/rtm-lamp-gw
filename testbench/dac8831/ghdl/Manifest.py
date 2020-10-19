action = "simulation"
sim_tool = "ghdl"
top_module = "dac8831_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r dac8831_tb --wave=dac8831_tb.ghw"
