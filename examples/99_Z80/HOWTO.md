## Install Docker

```
sudo apt install yosys nextpnr-ice40

git clone https://github.com/Obijuan/Z80-FPGA
cd Z80-FPGA
mkdir build && cd build
cp ../TV80-verilog/tv80_core.v .
cp ../TV80-verilog/tv80_reg.v .
cp ../TV80-verilog/tv80_mcode.v .
cp ../TV80-verilog/tv80_alu.v .
cp ../TV80-verilog/tv80_core.v .
xxd -p -c1 ../Tinybasic/Basic.bin > Basic.hex

make        # builds top.bin
make flash  # builds and copies to iCELink
```

## Test

```
sudo apt install screen

# dmesg | tail -n 30
screen /dev/ttyACM0 115200

# To exit
Ctrl + A, then K, then y
```

## Upload program through UART

Go to /Z80-FPGA/Tinybasic/

```
cd /Z80-FPGA/roms
# Edit, set SERIAL_PORT = "/dev/ttyACM0"

cd /Z80-FPGA/Tinybasic
python3 ../roms/z80-loader.py Basic.bin

0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Puerto serie: /dev/ttyACM0
Cargando programa...
Enviando relleno...
Done!

# Then connect through UART
screen /dev/ttyACM0 115200

TINY BASIC 2.0
OK
```



