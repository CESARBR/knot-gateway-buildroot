#!/bin/bash

DEVICE=$1

function continueIfYes() {
    echo "Do you want to continue? [y|N]"
    read resp
    if [ "$resp" != "y" ];
    then 
        if [ "$resp" != "Y" ];
        then
            exit 0
        fi
    fi
}

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

BOOT_MOUNT_DIR=/media/rpi_boot
ROOTFS_MOUNT_DIR=/media/rpi_rootfs
DATA_MOUNT_DIR=/media/rpi_data

echo "Mounting $disk1 into $BOOT_MOUNT_DIR"
if [[ ! -e $BOOT_MOUNT_DIR ]];
then 
    echo "creating $BOOT_MOUNT_DIR..." 
    sudo mkdir -p $BOOT_MOUNT_DIR
fi
sudo mount -o uid=1000,gid=1000 $disk1 $BOOT_MOUNT_DIR
if (( ! $? == 0 ));
then 
    exit 1
fi

echo "Mounting $disk2 into $ROOTFS_MOUNT_DIR"
if [[ ! -e $ROOTFS_MOUNT_DIR ]];
then 
    echo "creating $ROOTFS_MOUNT_DIR..." 
    sudo mkdir -p $ROOTFS_MOUNT_DIR
fi
sudo mount $disk2 $ROOTFS_MOUNT_DIR
if (( ! $? == 0 ));
then 
    exit 1
fi

echo "Mounting $disk3 into $DATA_MOUNT_DIR"
if [[ ! -e $DATA_MOUNT_DIR ]];
then 
    echo "creating $DATA_MOUNT_DIR..." 
    sudo mkdir -p $DATA_MOUNT_DIR
fi
sudo mount $disk3 $DATA_MOUNT_DIR
if (( ! $? == 0 ));
then 
    exit 1
fi

echo "Copying bootloader files..."
if [[ "$BOOT_MOUNT_DIR" != "" ]];
then
    sudo rm -rf $BOOT_MOUNT_DIR/*
    sudo cp output/images/bcm2709-rpi-2-b.dtb $BOOT_MOUNT_DIR/.
    sudo cp output/images/rpi-firmware/* $BOOT_MOUNT_DIR/.
    sudo cp output/images/kernel-marked/zImage $BOOT_MOUNT_DIR/.
    ls -la $BOOT_MOUNT_DIR
else
    echo "Error on boot directory mounting point: $BOOT_MOUNT_DIR"
fi

if [[ "$ROOTFS_MOUNT_DIR" != "" ]];
then
    echo "Copying root filesystem..."
    sudo rm -rf $ROOTFS_MOUNT_DIR/*
    sudo tar xf output/images/rootfs.tar -C $ROOTFS_MOUNT_DIR 
    echo "..."
    ls -la $ROOTFS_MOUNT_DIR
    sleep 2
else
    echo "Error on rootfs directory mounting point: $ROOTFS_MOUNT_DIR"
fi

if [[ "$DATA_MOUNT_DIR" != "" ]];
then
    echo "Creating data files..."
    sudo rm -rf $DATA_MOUNT_DIR/*
    sudo mkdir -p $DATA_MOUNT_DIR/logs
    sudo mkdir -p $DATA_MOUNT_DIR/packets
    echo "..."
    ls -laR $DATA_MOUNT_DIR/
    sleep 2
else
    echo "Error on data directory mounting point: $DATA_MOUNT_DIR"
fi

echo "umounting $disk1"
sudo umount $disk1

echo "umounting $disk2"
sudo umount $disk2

echo "umounting $disk3"
sudo umount $disk3
echo "____________________________________"
mount
echo "____________________________________"

echo "Done!"
echo "Please remove the sdcard and boot the board."

