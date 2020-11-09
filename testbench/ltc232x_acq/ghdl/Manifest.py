action = "simulation"
sim_tool = "ghdl"
top_module = "ltc232x_acq_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r ltc232x_acq_tb --wave=ltc232x_acq_tb.ghw"
