
# KitCom
# DO NOT RUN

# FIX: Bashrc, boot time, printing

# Surface
    # Shutdown then tap power button while holding volume up button to enter BIOS
    # Security > Secure Boot > Change configuration > None
    # Boot configuration > Configure boot device order > drag "USB Storage" to top
    # Plug in bootable USB
    # Exit > Restart now

# standard system utilities
# No Root
# kitcom/surface
# domain name: debian.local
# Family
# family
# encrypted LVM

sudo apt update
sudo apt install -y git
mkdir ~/.myconfig
cd ~/.myconfig
git clone https://github.com/masonperdue/linux-config.git
cd linux-config
./setup.sh

# Go through settings and panel
# Add keyboard shortcuts
    # Volume Up	    pactl set-sink-volume @DEFAULT_SINK@ +5%
    # Volume Down	pactl set-sink-volume @DEFAULT_SINK@ -5%
    # Mute/Unmute	pactl set-sink-mute @DEFAULT_SINK@ toggle

# DO
systemd-analyze
systemd-analyze blame
sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl disable keyboard-setup.service
sudo systemctl disable console-setup.service
sudo vi /etc/network/interfaces
    Look for lines referencing allow-hotplug eth0 or iface eth0 inet dhcp. If they exist, comment them out by placing a # in front of them. This stops the kernel from hunting for a physical network jack during boot.
You can speed up shell parsing by keeping your .bash_profile completely bare.
sudo vi /boot/efi/loader/loader.conf
    timeout 1
sudo vi /boot/efi/loader/entries/debian.conf
    options root=UUID=xxxx-xxxx rw quiet loglevel=3
systemd-analyze
systemd-analyze plot > ~/boot_plot.svg