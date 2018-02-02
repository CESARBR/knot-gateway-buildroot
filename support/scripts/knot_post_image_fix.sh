#!/bin/sh
#  knot_post_image_fix.sh - Takes a list of config fragment values and merges
#  post-image and post-script-args configurations print the proper value of
#  post image script and arguments configuration.
#
#  Usage example:
#  knot_post_image_fix.sh configs/<raspberrypi_model>_defconfig configs/knot_gateway_defconfig
#
INIT_FILE=$1
MERGE_FILE=$2

# Check if in KNoT list of config there is a post-image
MERGE_SCRIPT=$(sed -n -e '/BR2_ROOTFS_POST_IMAGE_SCRIPT/ s/.*\=" *//p' ${MERGE_FILE}| sed 's/"//g')

if [ -n "$MERGE_SCRIPT" ];then
	POST_IMAGE_SCRIPT="$MERGE_SCRIPT"
fi

# Check if in board list of config there is a post-image
INIT_SCRIPT=$(sed -n -e '/BR2_ROOTFS_POST_IMAGE_SCRIPT/ s/.*\=" *//p' ${INIT_FILE} | sed 's/"//g')

if [ -n "$INIT_SCRIPT"  ];then
	POST_IMAGE_SCRIPT="$POST_IMAGE_SCRIPT $INIT_SCRIPT"
fi

echo "BR2_ROOTFS_POST_IMAGE_SCRIPT=\"${POST_IMAGE_SCRIPT}\""

# Check if in KNoT list of config there is a post-script-args
MERGE_ARGS=$(sed -n -e '/BR2_ROOTFS_POST_SCRIPT_ARGS/ s/.*\=" *//p' ${MERGE_FILE}| sed 's/"//g')

if [ -n "$MERGE_ARGS" ];then
        POST_SCRIPT_ARGS="$MERGE_ARGS"
fi

# Check if in Board list of config there is a post-script-args
INIT_ARGS=$(sed -n -e '/BR2_ROOTFS_POST_SCRIPT_ARGS/ s/.*\=" *//p' ${INIT_FILE}| sed 's/"//g')

if [ -n "$INIT_ARGS"  ];then
        POST_SCRIPT_ARGS="$POST_SCRIPT_ARGS $INIT_ARGS"
fi

echo "BR2_ROOTFS_POST_SCRIPT_ARGS=\"${POST_SCRIPT_ARGS}\""
