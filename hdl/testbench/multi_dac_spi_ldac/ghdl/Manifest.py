action = "simulation"
sim_tool = "ghdl"
top_module = "multi_dac_spi_ldac_tb"

modules = {"local" : ["../"]}

ghdl_opt = "--std=08"

sim_post_cmd = "ghdl -r --std=08 multi_dac_spi_ldac_tb --wave=multi_dac_spi_ldac_tb.ghw"
