#!/bin/sh

set -euo pipefail

# Run simulation
hdlmake makefile
make
vsim -c -do run.do
wlf2vcd -o ltc232x_model_tb.vcd vsim.wlf
