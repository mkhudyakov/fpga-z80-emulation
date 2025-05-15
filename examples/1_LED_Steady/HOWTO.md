```
yosys -p "synth_ice40 -top top -json blink.json" blink.v
nextpnr-ice40 --up5k --package sg48 --json blink.json --pcf blink.pcf --asc blink.asc
icepack blink.asc blink.bin

cp blink.bin /media/admin/iCELink/
```