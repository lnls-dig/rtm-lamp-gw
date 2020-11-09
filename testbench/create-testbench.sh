#!/bin/sh

printf "Testbench name: "
read TB_NAME

printf "Testbench top file name: "
read TB_FILENAME

printf "Testbench toplevel: "
read TB_TOP_LEVEL

mkdir "$TB_NAME"
cd "$TB_NAME"

touch ${TB_FILENAME}.vhd
mkdir ghdl modelsim

printf "files = [\"${TB_FILENAME}.vhd\"]
modules = {\"local\" : [\"../../ip_cores/general-cores\", \"../../sim/rtm_model\"]}
" > Manifest.py

printf "action = \"simulation\"
sim_tool = \"ghdl\"
top_module = \"${TB_TOP_LEVEL}\"

modules = {\"local\" : [\"../\"]}

ghdl_opt = \"--std=08\"

sim_post_cmd = \"ghdl -r ${TB_TOP_LEVEL} --wave=${TB_TOP_LEVEL}.ghw\"
" > ghdl/Manifest.py

printf "action = \"simulation\"
sim_tool = \"modelsim\"
top_module = \"${TB_TOP_LEVEL}\"

modules = {\"local\" : [\"../\"]}

vcom_opt = \"-2008\"
" > modelsim/Manifest.py

printf "vcom -2008 ../${TB_FILENAME}.vhd
-- make -f Makefile
-- output log file to file \"output.log\", set simulation resolution to \"fs\"
vsim -l output.log \\
    +vcd \\
    -voptargs=\"+acc\" \\
    -t 1ns \\
    work.${TB_TOP_LEVEL}
do wave.do
log -r /*
-- run sim
radix -hexadecimal
run -all
wave zoomfull
radix -hexadecimal
quit
" > modelsim/run.do

printf "onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -r /${TB_TOP_LEVEL}/*
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 fs} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 fs} {1050 ns}
" > modelsim/wave.do

printf "#!/bin/sh

set -euo pipefail

# Run simulation
hdlmake makefile
make
vsim -c -do run.do
wlf2vcd -o ${TB_TOP_LEVEL}.vcd vsim.wlf
" > modelsim/run_batch_sim.sh
chmod +x modelsim/run_batch_sim.sh

printf "#!/bin/sh

set -euo pipefail

# Run simulation
hdlmake makefile
make
vsim -i -do run.do &
" > modelsim/run_gui_sim.sh
chmod +x modelsim/run_gui_sim.sh

printf "${TB_TOP_LEVEL}" > ghdl/.gitignore
