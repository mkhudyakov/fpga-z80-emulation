## Build
```
sudo apt remove yosys
# Install a stable release from source:
git clone https://github.com/YosysHQ/yosys
cd yosys
git checkout yosys-0.17
make -j$(nproc)
sudo make install

make clean
make
```

## Test
```
picocom -b 9600 /dev/ttyACM0
```


