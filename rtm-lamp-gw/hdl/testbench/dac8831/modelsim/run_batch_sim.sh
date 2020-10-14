#!/usr/bin/env bash

set -euo pipefail

# Run simulation
hdlmake makefile
make
vsim -c -do run.do
wlf2vcd -o dac8831_tb.vcd vsim.wlf
