action = "simulation"
sim_tool = "ghdl"
top_module = "multi_dac_spi_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r multi_dac_spi_tb --wave=multi_dac_spi_tb.ghw"
