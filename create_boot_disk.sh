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
    echo "You must specify a disk device to be created!"
    echo "E.g.: create_boot_disk.sh /dev/sdc"
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

echo "WARNING! You are going to format $DEVICE!"
echo "All data on $DEVICE will be lost!"
continueIfYes

disk_mounted=$(df | grep $DEVICE | wc -l)
if (( "$disk_mounted" == "0" ));
then
    echo "WARNING! the device $DEVICE is not mounted and"
    echo "it is not possible to verify it."
    continueIfYes
else 
    disk_info=$(df | grep $DEVICE | head -1)
    disk=$(echo $disk_info | awk '{print $1}')
    mount_point=$(echo $disk_info | awk '{print $6}')

    if [ "$mount_point" == "/" ];
    then
        echo "$disk is mounted on your root directory!!"
        echo "Are you crazy? [Y|Y]"
        read resp
        echo "I think you are! Exiting!"
        exit 0
    fi
    
    if [[ $mount_point == *media* ]];
    then
        echo "$disk is mounted on $mount_point"
    else
        echo "$disk is mounted on $mount_point"
        echo "Seems that you choose a wrong disk!"
        continueIfYes
    fi
    
    capacity=$(echo $disk_info | awk '{print $2}')
    if [ -z $capacity ];
    then
        echo "It is not possible to verify $disk1 capacity."
        continueIfYes
    fi
    if [ $capacity -gt 10000000 ];
    then
        echo "$disk size is $capacity (greater than 10GB)"
        echo "Are you sure you choose the right disk?"
        continueIfYes
    fi
fi
echo "Umounting $DEVICE"
disk1=${DEVICE/*mmcblk*/${DEVICE}p}"1"
disk2=${DEVICE/*mmcblk*/${DEVICE}p}"2"
disk3=${DEVICE/*mmcblk*/${DEVICE}p}"3"
disk4=${DEVICE/*mmcblk*/${DEVICE}p}"4"

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

echo "Ready to create partition table for $DEVICE"
echo "-------------------------------------------"
echo -e "device\t\tBoot\tName\tSize\tSystem"
echo -e "$disk1\t*\tboot\t32MB\tW95 FAT32(LBA)"
echo -e "$disk2\t \trootfs\t1GB\tLinux"
echo -e "$disk3\t \tdata\t*\tLinux"
echo "-------------------------------------------"

sudo sfdisk $DEVICE << EOF
,64000,c,*
,1024000
;
EOF

echo "Formatting partitions..."
sudo mkfs.vfat $disk1 -n boot
sudo mkfs.ext4 $disk2 -L rootfs
sudo mkfs.ext4 $disk3 -L data

source update_boot_disk.sh ${DEVICE/*mmcblk*/${DEVICE}p}

