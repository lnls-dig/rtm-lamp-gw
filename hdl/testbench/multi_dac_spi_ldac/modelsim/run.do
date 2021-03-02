vcom -2008 ../multi_dac_spi_ldac_tb.vhd
-- make -f Makefile
-- output log file to file "output.log", set simulation resolution to "fs"
vsim -l output.log \
    +vcd \
    -voptargs="+acc" \
    -t 1ns \
    work.multi_dac_spi_ldac_tb
do wave.do
log -r /*
-- run sim
radix -hexadecimal
run -all
wave zoomfull
radix -hexadecimal
quit
