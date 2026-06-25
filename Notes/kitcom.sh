
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
    # Set sleep mode
        cat /proc/cmdline
            # Copy contents
        sudoedit /etc/kernel/cmdline
            # Paste contents plus mem_sleep_default=s2idle
        sudo dpkg-reconfigure linux-image-$(uname -r)
    # Disable input devices
        grep -E 'Name=|Handlers=' /proc/bus/input/devices
        sudoedit /etc/udev/rules.d/99-disable-internal-input.rules
            # add in names from grep command
            # Disable internal touchscreen
            SUBSYSTEM=="input", KERNEL=="event*", ATTRS{name}=="*ELAN9008:00 04F3:2A00 Touchscreen*", ENV{LIBINPUT_IGNORE_DEVICE}="1"

            # Disable internal touchpad
            SUBSYSTEM=="input", KERNEL=="event*", ATTRS{name}=="*SynPS/2 Synaptics TouchPad*", ENV{LIBINPUT_IGNORE_DEVICE}="1"
        sudo udevadm control --reload-rules && sudo udevadm trigger

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