#!/bin/sh

set -euo pipefail

# Run simulation
hdlmake makefile
make
vsim -c -do run.do
wlf2vcd -o xwb_rtmlamp_ohwr_tb.vcd vsim.wlf
