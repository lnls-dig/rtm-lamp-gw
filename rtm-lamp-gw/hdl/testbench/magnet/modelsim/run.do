vcom ../magnet_tb.vhd
-- make -f Makefile
-- output log file to file "output.log", set siulation resolution to "fs"
vsim -l output.log \
    +vcd \
    -voptargs="+acc" \
    -t 10us \
    work.magnet_tb
do wave.do
log -r /*
-- run sim
radix -hexadecimal
run -all
wave zoomfull
radix -hexadecimal
quit
