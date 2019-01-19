#!/bin/bash

## Variables

if [ $# -lt 2 ]; then
	echo "Usage: ./extract.sh <GApps filename> <extraction path"
	return 0
fi

# Our parameter is the filename, let's not make things too complicated.
OGAPPS=$1
EXT_PATH=$2

# Unzip what's necessary
echo -e "\nExtracting Core and GApps into $EXT_PATH..."
unzip $OGAPPS 'Core/*' 'GApps/*' -d $EXT_PATH

# Get into the ext_path in order to simplify command execution
cd $EXT_PATH

# Remove useless stuff
rm Core/setup*

echo -e "\nExtracting packages, this may take while depending on the GApps package and computer specs..."

# lzip extractions
lzip -d Core/*.lz
lzip -d GApps/*.lz

# tar extractions
for f in $(ls Core/*.tar) $(ls GApps/*.tar); do
	tar -x --strip-components 2 -f $f
done

# Remove source folders to save space
echo -e "\nCleaning up source folders..."
rm -rf Core GApps

echo -e "\nAll done, you should now invoke push.sh if you would like to install the"
echo "packages."
echo -e "\neg: ./push.sh $EXT_PATH\n"
echo "Where the argument is the folder name used for the extraction."
echo "You may have to increase your system.img size via BoardConfig.mk; e.g:"
echo "BOARD_SYSTEMIMAGE_PARTITION_SIZE=6442450944"
echo -e "Note: this will set the system image size to 6GB.\n"
