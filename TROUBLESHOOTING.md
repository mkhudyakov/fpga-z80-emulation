https://github.com/wuxx/icesugar/blob/master/README_en.md

```
lsusb -v -d 1d50:602b | grep -E 'iProduct|iManufacturer|iSerial'

Couldn't open device, some information will be missing
  iManufacturer           1 MuseLab
  iProduct                2 DAPLink CMSIS-DAP
  iSerial                 3 07000001005300644300000a4e575737a5a5a5a597969908
  
udevadm info -a -n /dev/ttyACM0 | grep -Ei 'product|manufacturer|serial'

    ATTRS{interface}=="mbed Serial Port"
    ATTRS{idProduct}=="602b"
    ATTRS{manufacturer}=="MuseLab"
    ATTRS{product}=="DAPLink CMSIS-DAP"
    ATTRS{serial}=="07000001005300644300000a4e575737a5a5a5a597969908"
    ATTRS{idProduct}=="3431"
    ATTRS{product}=="USB2.0 Hub"
    ATTRS{idProduct}=="0002"
    ATTRS{manufacturer}=="Linux 6.1.21-v8+ xhci-hcd"
    ATTRS{product}=="xHCI Host Controller"
    ATTRS{serial}=="0000:01:00.0"
    

```