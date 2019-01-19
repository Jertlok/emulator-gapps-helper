#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: ./push.sh <Extracted GApps path>"
	return 0;
fi

EXT_PATH=$1

# Get into the EXT_PATH to make everything easier
cd $EXT_PATH

# Starting adb as root
adb root

# Remounting the partitions with rw permissions
adb remount 

# Push all the things
for folder in etc framework app priv-app lib usr; do
       adb push $folder /system
done

# reboot the emulator
adb shell stop && adb shell start

