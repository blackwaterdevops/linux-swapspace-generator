#!/bin/bash

DEFAULT_SIZE="512";
DEFAULT_SWAP="/swapfile";
BLOCK_SIZE="1024";

echo "Enter the size in MB you want you swapspace partition to be (number only) [512]"
read SIZE

if [ -z "${SIZE}" ];
    then
        SS=${DEFAULT_SIZE};
    else
        SS=${SIZE};
fi

echo "Enter the path for the swapspace [/swapfile]"
read SWAPFILE

if [ -z "${SWAPFILE}" ];
    then
        SWAP=${DEFAULT_SWAP};
    else
        SWAP=${SWAPFILE};
fi

echo "Swapspace will be created at $(echo $SWAP)"

function create_swap {
    size="${1}k"
    bs=${2}
    file=${3}

    echo "Building swapspace of $(echo $1)MB mounted to $(echo $3)";

    /bin/dd if=/dev/zero of="$(echo $file)" bs="$(echo $bs)" count="$(echo $size)"
    /sbin/mkswap "$(echo $file)"
    /sbin/swapon "$(echo $file)"
    echo "$file          swap            swap    defaults        0 0" >> /etc/fstab
    /bin/chown root:root "$(echo $file)"
    /bin/chmod 0600 "$(echo $file)"
    echo "vm.swappiness=10" >> /etc/sysctl.conf
    /sbin/sysctl vm.swappiness=10

    echo "Complete"
}

echo "Please confirm you want to create a swap partition of $(echo $SS) MB mounted to $(echo $SWAP)";
select yn in "Yes" "No"; do
    case $yn in
        Yes ) create_swap ${SS} ${BLOCK_SIZE} ${SWAP}; break;;
        No ) exit;;
    esac
done

exit;