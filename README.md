KNoT Network of Things - Gateway
=============================================================================
This is the gateway software module for the KNoT platform.
It is based on buildroot 2014.11 version for RaspberryPi hardware.

Copyright (C) 1999-2005 by Erik Andersen <andersen@codepoet.org>  
Copyright (C) 2006-2014 by the Buildroot developers <buildroot@uclibc.org>  
Copyright (C) 2014 by the Buildroot developers <buildroot@buildroot.org>  
Copyright (C) 2015 by the C.E.S.A.R KNoT developers <knot-l@cesar.org.br>  


This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


How to Buid it
----------------
The knot_gateway_defconfig configuration is a minimal configuration with
all that is required to bring the KNoT platform on RaspberryPi. 
Note: you will need to have access to the network, since Buildroot will
download the packages' sources.

You should base your work on this defconfig:

1. run `make knot_gateway` or `make BR2_GATEWAY_HARDWARE=configs/<raspberrypi_model>_defconfig knot_gateway` to select a diferent model from the original. There are four different raspberry pi defconfigs to choose.
2. run `make menuconfig`
3. select the extra packages you wish to compile
4. run `make`
(This may take a while; consider getting yourself a coffee ;-) )
5. wait while it compiles
6. Use your shiny new root filesystem. 

### Offline build ###

In order to do an offline-build (not connected to the net), fetch all
selected source by issuing a
```shell
$ make source
```
before you disconnect.
If your build-host is never connected, then you have to copy buildroot
and your toplevel `.config` to a machine that has an internet-connection
and issue `make source` there, then copy the content of your dl/ dir to
the build-host.

### Building out-of-tree ###

Buildroot supports building out of tree with a syntax similar
to the Linux kernel. To use it, add O=<directory> to the
make command line, E.G.:
```shell
$ make O=/tmp/build
```
And all the output files (including `.config`) will be located under `/tmp/build`.

### More finegrained configuration ###

You can specify a config-file for uClibc:
```shell
$ make UCLIBC_CONFIG_FILE=/my/uClibc.config
```
And you can specify a config-file for busybox:
```shell
$ make BUSYBOX_CONFIG_FILE=/my/busybox.config
```
To use a non-standard host-compiler (if you do not have 'gcc'),
make sure that the compiler is in your PATH and that the library paths are
setup properly, if your compiler is built dynamically:
```shell
$ make HOSTCC=gcc-4.3.orig HOSTCXX=gcc-4.3-mine
```
Depending on your configuration, there are some targets you can use to
use menuconfig of certain packages. This includes:
```shell
$ make HOSTCC=gcc-4.3 linux-menuconfig
$ make HOSTCC=gcc-4.3 uclibc-menuconfig
$ make HOSTCC=gcc-4.3 busybox-menuconfig
```
Please feed suggestions, bug reports, insults, and bribes back to the
knot mailing list: <knot-l@cesar.org.br>


Result of the build
-------------------

After building, you should obtain this tree:

    output/images/
    +-- rootfs.ext2
    +-- rpi-firmware
    |   +-- bootcode.bin
    |   +-- config.txt
    |   +-- fixup_cd.dat
    |   +-- fixup.dat
    |   +-- start_cd.elf
    |   +-- start.elf
    +-- zImage

The rootfs.ext2 file contains (as the name suggests) the root file system for your linux setup.
The rpi-firmware directory contains the RaspberryPi bootloader and all the files that it needs.
The zImage is the Linux kernel image.

Preparing and writing the SDcard
--------------------------------

The RaspberryPi bootloader needs to be in a FAT32 partition. So, the SDCard must have first partition in FAT32 and marked bootable.  
The bootloader and required files needs aproximatedly 10MB.  
The root file system size depends on the applications, libraries, etc that you included in your build.

We created two scripts that automates the process of preparing and writing those files on SDCard.  
The fisrt one is `create_boot_disk.sh` that will partition the sdcard and format the volumes according to its file systems (FAT32 and ext4).  
The second is the `update_boot_disk.sh` that will write the files to each volume (boot and rootfs).
These scripts are located in path `board/raspberrypi/`, relative from the _knot-gateway-buildroot_ folder.

If you have new SDCard, you will need to create the partition first:

```
$ ./board/raspberrypi/create_boot_disk.sh /dev/sdX
```
where `sdX` is the device corresponding to your SDCard in your system, such as `sdb` or `sdc` (or also `mmcblkX`).
> Note: create_boot_disk.sh will repartition and formating your entire disk. This means that all **INFORMATION** on it will be **LOST**.
Please use it with care!

If your SDCard was previously used with this system and you just need to update the files resulted from a fresh build, you can use:

```
$ ./board/raspberrypi/update_boot_disk.sh /dev/sdX
``` 
where `sdX` is the device corresponding to your SDCard in your system, such as `sdb` or `sdc` (or also `mmcblkX`).
> Note: update_boot_disk.sh will ERASE the first 3 partitions of the disk. This means that all **INFORMATION** on it will be **LOST**.
Please use it with care!

Let's see how to access your KNoT gateway
----------------------------------------

To access the KNoT gateway of your Network open your browser and type [knot.local:8080](http://knot.local:8080) in your URL bar.

Possible troubleshootings
-------------------------

### I've typed knot.local:8080 on the URL bar but my browser returned that it can't find the page ###

In the KNoT gateway it is installed a service that allows to the find it with a logical address (knot.local) without let you know the physical address (an address like 192.168.x.y), but sometimes it could happen that this service is blocked by either the router firewall or the computer firewall.

To solve that problem you have to:

A - Go to a linux machine on same local network and execute the followed command on terminal ```$ arp-scan -l | grep b8:27:eb```

B - Go to the KNoT gateway then put a screen and a keyboard, login as user root and password root, type the followed command ```hostname -i``` (it's important that hostname is write lowercase).

This command will return the IP address the router have assigned to the KNot gateway; now that you know the IP address, go to the browser and type the IP address instead of knot.local. For example, imagine it returned 192.168.1.4, go to the browser and on the URL bar type: 192.168.1.4:8080


**And finally, enjoy your brand new KNoT Gateway platform!**
