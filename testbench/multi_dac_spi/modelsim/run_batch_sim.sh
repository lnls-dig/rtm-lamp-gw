#!/bin/sh

set -euo pipefail

# Run simulation
hdlmake makefile
make
vsim -c -do run.do
wlf2vcd -o multi_dac_spi_tb.vcd vsim.wlf
