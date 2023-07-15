# How to revive SD card boot after flashing eMMC of Nano C100

Nano C100 boots from eMMC even if SD card is set after initializing with flash command.
This repository helps to revive booting from SD card.

## Requirements

- Ubuntu PC (Ubuntu 18.04 LTS)
- USB serial module for UART debug
- sudo apt install uboo-tools (needed to disassemble .dtb and assemble .dts)

## Procedure

1. Debug UART connection

    Connect RX, TX, and GND pins near the SD card slot of Nano C100 to USB port of Ubuntu PC via USB serial module.

    RX of Nano C100 is connected to TX of USB serial module, and TX of Nano C100 is connected to RX of USB serial module.

    Run screen command.
```
sudo screen /dev/ttyUSB0 115200
```

2. Micro USB connection

    Connect Micro USB port of Nano C100 to USB port of Ubuntu PC.

    This connection will be used to mount eMMC from Ubuntu PC.

3. Mount eMMC of Nano C100 as external drive

    Turn on Nano C100.

    Press any key while the following message is displayed.
```
Hit any key to stop autoboot: 2
```
    Then, U-boot prompt like below will be appeared.
```
Tegra210 (P3450-0000) #
```
    Make Nano C100 external drive mode.
```
ums 0 0
```
    Check device name of eMMC of Nano C100 with another terminal window.
```
df
```
    In my case, the drive was /dev/sdb1.

    Mount the device to /mnt.
```
sudo mount /dev/sdb1 /mnt
```

4. Copy files to eMMC

    Copy files related to boot with below command.
```
./run_cp.sh
```
    Unmount device.
```
sudo umount /mnt
```
    Press Ctrl+C to stop "ums 0 0" and input below command to restart Nano C100 in UART debug window.
```
reset
```
    Nano C100 will automatically shutdown after reset command.

    Power on Nano C100 again, then boot from SD card revives.

## Disasseble DTB (Optional)

Below steps are not necessary, just for information.

The above run_cp.sh copies data directory to eMMC. The data was copied from eMMC in initial state.

Device tree files such as .dtb and .dtbo are binary files, and they can be disassembled with below command.
```
./disassemble_dtb.sh
```
Source files (.dts) will be generated in src directory.

## Re-assemble DTS (Optional)

The source files disassembled can be re-assemble with below command.
```
./assemble_dts.sh
```
