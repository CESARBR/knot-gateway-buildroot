#!/bin/sh
# knot_post_image_fix.sh - Takes a list of config fragment values and merges
# post-image and post-script-args configurations.

INIT_FILE=$1
MERGE_FILE=$2

# Check if in KNoT list of config there is a post-image
MERGE_SCRIPT=$(grep 'BR2_ROOTFS_POST_IMAGE_SCRIPT=' ${MERGE_FILE})

if [ -n "$MERGE_SCRIPT" ];then
        MERGE_SCRIPT=${MERGE_SCRIPT#*BR2_ROOTFS_POST_IMAGE_SCRIPT=\"}
        MERGE_SCRIPT=${MERGE_SCRIPT%*\"}
	POST_IMAGE_SCRIPT="$MERGE_SCRIPT"
fi

# Check if in board list of config there is a post-image
INIT_SCRIPT=$(grep 'BR2_ROOTFS_POST_IMAGE_SCRIPT=' ${INIT_FILE})

if [ -n "$INIT_SCRIPT"  ];then
        INIT_SCRIPT=${INIT_SCRIPT#*BR2_ROOTFS_POST_IMAGE_SCRIPT=\"}
        INIT_SCRIPT=${INIT_SCRIPT%*\"}
	POST_IMAGE_SCRIPT="$POST_IMAGE_SCRIPT $INIT_SCRIPT"
fi

echo BR2_ROOTFS_POST_IMAGE_SCRIPT=\"${POST_IMAGE_SCRIPT}\"

# Check if in KNoT list of config there is a post-script-args
MERGE_ARGS=$(grep 'BR2_ROOTFS_POST_SCRIPT_ARGS=' ${MERGE_FILE})

if [ -n "$MERGE_ARGS" ];then
        MERGE_ARGS=${MERGE_ARGS#*BR2_ROOTFS_POST_SCRIPT_ARGS=\"}
        MERGE_ARGS=${MERGE_ARGS%*\"}
        POST_SCRIPT_ARGS="$MERGE_ARGS"
fi

# Check if in Board list of config there is a post-script-args
INIT_ARGS=$(grep 'BR2_ROOTFS_POST_SCRIPT_ARGS=' ${INIT_FILE})

if [ -n "$INIT_ARGS"  ];then
        INIT_ARGS=${INIT_ARGS#*BR2_ROOTFS_POST_SCRIPT_ARGS=\"}
        INIT_ARGS=${INIT_ARGS%*\"}
        POST_SCRIPT_ARGS="$POST_SCRIPT_ARGS $INIT_ARGS"
fi

echo BR2_ROOTFS_POST_SCRIPT_ARGS=\"${POST_SCRIPT_ARGS}\"
