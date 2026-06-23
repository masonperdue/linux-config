
# KitCom
# DO NOT RUN

# Surface
    # Shutdown then tap power button while holding volume up button to enter BIOS
    # Security > Secure Boot > Change configuration > None
    # Boot configuration > Configure boot device order > drag "USB Storage" to top
    # Plug in bootable USB
    # Exit > Restart now

# Toshiba
    # BIOS Key: F2

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