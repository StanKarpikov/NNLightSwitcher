# Buildroot and U-Boot configurations for NNLightSwitcher board

`buildroot-config` folder contains changed configuration files for buildroot submodule.
`u-boot-config` folder contains changed configuration files for U-Boot submodule.

## U-Boot configuration

Tested with U-Boot 2019.01

Significant changes:
- Use 921600 serial speed for console
- Set offset for environment variables in QSPI

Steps:

1. Configure build environment
```bash
export CROSS_COMPILE=arm-linux-gnueabihf-
export ARCH=arm
```
2. Place `u-boot-config/zynq-zc7010.dts` device tree file to `u-boot-xlnx/arch/arm/dts` folder.
3. Place `u-boot-config/zynq_zc7010_defconfig` confuguration to `u-boot-xlnx/configs/` folder.
4. Go to `u-boot-xlnx/` folder and run 
```bash
make zynq_zc7010_defconfig
```
5. Run `make`
> NOTE: One must run `make clear` before each reconfiguration and (may be) reproduce steps from 1.
6. Get compiled image `u-boot.elf` and use it to generate flash image for Quad SPI in Xilinx SDK.

## Buildroot confuguration

Tested with Buildroot 2019.11-rc3-dirty

Significant changes:
- Use 921600 serial speed for console

Steps with given configuration files:
1. Go to folder `buildroot/` and run 
```bash
make zynq_zc7010_defconfig # Config file from buildroot-config folder
```
2. Then you can check and verify additional configuration options using comand:
```bash
make xconfig # GUI interface
```
or
```bash
make menuconfig
```
This tools then save full configuration to `.config` file.

2. Run `make linux-menuconfig` or `make linux-xconfig` to configure Linux package.
3. From configuration GUI open `buildroot-config/linux_zynq_def.config` file and load configuration.
4. Chack settings and then save the configuration. The tool creates file `buildroot/output/build/linux-custom/.config`.
5. Put device tree file `buildroot-config/zynq-zc7010.dts`  to `buildroot/output/build/linux-custom/arch/arm/boot/dts` folder.
One can also use this command to compile the device tree to dtb file (useful then to update it on the eMMC without updating the Kernel image):
```bash
dtc -O dtb -o zynq-zc7010.dtb zynq-zc7010.dts -@
```
6. Check `uClibc-ng.config` from `buildroot/package/uclibc` to match with `buildroot/uClibc-ng.config`. (I had an issue with widechar support here)
7. Replace `buildroot/board/zynq` folder content with files `buildroot-config/genimage`.

`genimage.cfg` configuration creates SD (eMMC) card image with two partitions:

a. VFAT partition for Linux uImage and device tree
b. EXT4 partition for Linux root filesystem

`genimage-ram.cfg` configuration creates SD (eMMC) card image with single partition:

a. VFAT partition for Linux uImage, device tree and root filesystem

One can also run this scripts without buildroot.
> TODO: `genimage.cfg` script requires root filesystem to be extracted to `buildroot/output/images` folder. By default buildroot doesn't do it. Currently this task mush be done manualy.

8. Return to `buildroot/` and run `make`.
> NOTE: One must run `make clear` before each reconfiguration and reproduce steps from 1.
9. Output files wiil be written to `buildroot/output/images` folder.
10. Load `sdcard.img` to eMMC through U-Boot:

```bash
# Start Ymodem to load tile to RAM memory address 0x1000000.
loady 0x1000000 

# Erase 288 Mb eMMC memory. 0x90400 - number of 512 bytes sectors, 0x0 - start sector
mmc erase 0x0 0x90400

# Copy 288 Mb image from RAM memory 0x1000000 to eMMC
mmc write 0x1000000 0x0 0x90400
```
One can use Teraterm to send binary file.

11. Linux then can be started manually from U-Boot:

If root filesystem is loaded to RAM ( `genimage-ram.cfg` was used):
```bash
fatload mmc 0 0x4000000 uImage #0x4000000 - address in RAM to load kernal image
fatload mmc 0 0x3A00000 devicetree.dtb #0x3A00000 - address in RAM to load device tree
fatload mmc 0 0x2000000 uramdisk.image.gz #0x2000000 - address in RAM to load root filesystem
bootm 0x4000000 0x2000000 0x3A00000
```

If root filesystem is not loaded to RAM ( `genimage.cfg` was used):
```bash
fatload mmc 0 0x2000000 uImage
fatload mmc 0 0x2A00000 devicetree.dtb
setenv bootargs "root=/dev/mmcblk0p1 rw rootfstype=ext4"
bootm 0x2000000 - 0x2A00000
```

One can also save default U-Boot environment to load automatically with this configuration, for example:
```bash
setenv kernel_addr_r 0x4000000
setenv dt_addr_r 0x3A00000
setenv ramd_addr_r 0x2000000
setenv bootcmd "fatload mmc 0 ${kernel_addr_r} uImage; fatload mmc 0 ${dt_addr_r} devicetree.dtb; fatload mmc 0 ${ramd_addr_r} uramdisk.image.gz; bootm ${kernel_addr_r} ${ramd_addr_r} ${dt_addr_r}"
setenv uenvcmd "run bootcmd"
saveenv
```

12. Optional. One can use `vmlinux` file with symbols from `buildroot/output/build/linux-custom/` folder to debug the Kernel.

13. To update device tree one can use U-Boot commands:
```bash
# Load devicetree.dtb file to RAM
loady 0x1000000
## Ready for binary (ymodem) download to 0x01000000 at 921600 bps...
CCxyzModem - CRC mode, 2(SOH)/14(STX)/0(CAN) packets, 5 retries
## Total Size      = 0x0000353d = 13629 Bytes

# Write file to FAT partition, 0x0000353d - size of the file
fatwrite mmc 0:1 0x1000000 devicetree.dtb 0x0000353d
```

### Useful links:

1. [SD controller sennings in Zynq SoC](https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842090/SD+controller#SDcontroller-Zynq.2)
2. [U-Boot SD card booting](https://www.96boards.org/blog/boot-linux-from-sd-card-uboot/)
3. For device tree bindings refer to `linux-xlnx/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt` in Xilinx-linux GitHub repository
4. [Xilinx Zynq 7000 technical reference](https://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf)
5. [Forum: Boot linux from U-Boot](https://forums.xilinx.com/t5/Embedded-Linux/Mount-filesystem-from-sd-card/td-p/834164)
6. [Example device tree](https://github.com/enclustra-bsp/xilinx-linux/blob/dc056197b7fe3e05292ffdce2ae4a06c89bee294/arch/arm/boot/dts/zynq-cosmos-xzq10.dts)
7. [How to program Xilinx Zynq from IDE](https://dzone.com/articles/create-a-bootbin-program-an-sd-card-and-boot-a-zc7)
8. [Simple program on Xilinx Zynq](https://www.centennialsoftwaresolutions.com/post/run-hello-world-on-a-zc702)



