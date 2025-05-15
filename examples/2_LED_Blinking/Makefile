all: blink.bin

blink.json:
	yosys -p "synth_ice40 -top top -json blink.json" blink.v

blink.asc: blink.json
	nextpnr-ice40 --up5k --package sg48 --json blink.json --pcf blink.pcf --asc blink.asc

blink.bin: blink.asc
	icepack blink.asc blink.bin

flash: blink.bin
	cp blink.bin /media/admin/iCELink/

clean:
	rm -f blink.json blink.asc blink.bin