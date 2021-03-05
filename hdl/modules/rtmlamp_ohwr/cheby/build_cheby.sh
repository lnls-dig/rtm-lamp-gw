#!/bin/bash

cheby -i rtmlamp_ohwr_regs.cheby --hdl vhdl --gen-wbgen-hdl wb_rtmlamp_ohwr_regs.vhd --doc html --gen-doc doc/wb_rtmlamp_ohwr_regs_wb.html --gen-c wb_rtmlamp_ohwr_regs.h --consts-style verilog --gen-consts ../../../sim/regs/wb_rtmlamp_ohwr_regs.vh
