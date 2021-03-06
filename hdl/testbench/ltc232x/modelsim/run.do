vcom -2008 ../ltc232x_tb.vhd
-- make -f Makefile
-- output log file to file "output.log", set siulation resolution to "fs"
vsim -l output.log \
    +vcd \
    -voptargs="+acc" \
    -t 1ns \
    work.ltc232x_model_tb
do wave.do
log -r /*
-- run sim
radix -hexadecimal
run -all
wave zoomfull
radix -hexadecimal
quit
