
# DD

sudo dd bs=4M if=debian-*-amd64-netinst.iso of=/dev/disk/by-id/usb-_USB_DISK_3.0_*-0:0 conv=fsync oflag=direct status=progress
