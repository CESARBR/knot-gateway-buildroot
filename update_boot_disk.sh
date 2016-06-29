#!/bin/bash

DEVICE=$1

if [ -z $DEVICE ];
then 
    echo "You must specify a disk device to be updated!"
    echo "E.g.: update_boot_disk.sh /dev/sdc"
    echo ""
    exit 0
fi

if [ "$DEVICE" == "/dev/sda" ];
then 
    echo "WARNING!! $DEVICE is used to be the primary disk of your machine!"
    echo "You are going to format $DEVICE!"
    echo "All data on $DEVICE will be lost!"
    continueIfYes
    echo "Are you REALLY sure you want to continue? [y|N]"
    continueIfYes
fi

disk1=$DEVICE"1"
disk2=$DEVICE"2"
disk3=$DEVICE"3"
disk4=$DEVICE"4"

if (( "$(df | grep $disk1 | wc -l)" == "1" ));
then 
    echo "umounting $disk1"
    sudo umount $disk1
fi
if (( "$(df | grep $disk2 | wc -l)" == "1" ));
then 
    echo "umounting $disk2"
    sudo umount $disk2
fi
if (( "$(df | grep $disk3 | wc -l)" == "1" ));
then 
    echo "umounting $disk3"
    sudo umount $disk3
fi
if (( "$(df | grep $disk4 | wc -l)" == "1" ));
then 
    echo "umounting $disk4"
    sudo umount $disk4
fi

echo "Copying bootloader files..."
sudo dd if=output/images/boot.vfat of=$disk1 bs=1M

echo "Copying root filesystem..."
sudo dd if=output/images/rootfs.ext4 of=$disk2 bs=1M
sudo resize2fs $disk2

echo "Done!"
echo "Please remove the sdcard and boot the board."

