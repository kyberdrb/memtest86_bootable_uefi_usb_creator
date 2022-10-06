#!/bin/sh

set -x

DISK_NAME="$1"
DISK_DEVICE="/dev/${DISK_NAME}"

ALREADY_DOWNLOADED_MEMTEST86_ISO="$2:-"""

if [ ! -r "/tmp/memtest86_latest.zip" ]
then
  axel --verbose --num-connections=10 \
      https://www.memtest86.com/downloads/memtest86-usb.zip --output=/tmp/memtest86_latest.zip
fi

echo "Unmount all partitions of the device '/dev/${DISK_NAME}'"
PARTITION_NAME=$(cat /proc/partitions | grep "${DISK_NAME}" | rev | cut -d' ' -f1 | rev | grep -v ""${DISK_NAME}"$")
PARTITION_DEVICE="/dev/${PARTITION_NAME}"

udisksctl unmount --block-device ${PARTITION_DEVICE}
udisksctl mount --block-device ${PARTITION_DEVICE}
USB_MOUNT_DIR="$(lsblk -oNAME,MOUNTPOINTS "${PARTITION_DEVICE}" | tail --lines=1 | cut --delimiter=' ' --fields=1 --complement)/"

sudo 7z x -y "/tmp/memtest86_latest.zip" -o"/tmp/memtest_usb_latest"
sudo 7z x -y "/tmp/memtest_usb_latest/memtest86-usb.img" -o"/tmp/memtest_usb_latest_nested"
sudo 7z x -y "/tmp/memtest_usb_latest_nested/MemTest86.img" -o"${USB_MOUNT_DIR}"

sync
sudo sync

udisksctl unmount --block-device ${PARTITION_DEVICE}

