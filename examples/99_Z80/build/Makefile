# Makefile for building Z80 FPGA project

SRC = top.v tv80_core.v tv80_reg.v tv80_alu.v tv80_mcode.v uart_tx.v

all: top.bin

top.json: $(SRC)
	yosys -p "read_verilog $(SRC); hierarchy -top top; synth_ice40 -top top -json top.json"

top.asc: top.json top.pcf
	nextpnr-ice40 --up5k --package sg48 --json top.json --pcf top.pcf --asc top.asc

top.bin: top.asc
	icepack top.asc top.bin

flash: top.bin
	cp top.bin /media/admin/iCELink/

clean:
	rm -f top.json top.asc top.bin