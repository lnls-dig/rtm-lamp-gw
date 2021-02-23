action = "simulation"
sim_tool = "ghdl"
top_module = "ffd_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r --std=08 ffd_tb --wave=ffd_tb.ghw"
