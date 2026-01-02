

# DO NOT RUN - NOTES ONLY


# Server Setup
    # Raspberry Pi OS Lite
    # Hostname: raspi
    # Capital City: Washington, D.C. (United States)
    # Time Zone: America/Los_Angeles
    # Keyboard Layout: us
    # No WiFi
    # Username: masonp
    # SSH w/ Pubkey Auth
    # MAC IP Binded in Router to 192.168.50.20
    # ssh masonp@192.168.50.20
        sudo apt update -y
        sudo apt full-upgrade -y
        sudo apt autoremove --purge -y
        sudo raspi-config
            # change locale to us
            # expand filesystem
            # update
        sudo reboot now
    # ssh masonp@192.168.50.20
        sudo rm /etc/sudoers.d/010_pi-nopasswd
        sudoedit /etc/ssh/sshd_config
            # change to "Port 7583"
            # change to "PermitRootLogin no"
            # change to "PubkeyAuthentication yes"
            # change to "AuthorizedKeysFile .ssh/authorized_keys"
            # change to "PasswordAuthentication no"
            # change to "X11Forwarding no"
            # add "AllowUsers masonp"
        # sudo systemctl list-units --type=service
        sudo systemctl disable --now {bluetooth,avahi-daemon}.service
        sudo systemctl disable --now avahi-daemon.socket
        sudo systemctl mask {bluetooth,avahi-daemon}.service
        sudo systemctl mask avahi-daemon.socket
        sudo rm /etc/motd         
        sudo reboot now
    # ssh masonp@192.168.50.20 -p 7583
        rm ~/.bashrc
        curl --output ~/.bashrc https://raw.githubusercontent.com/masonperdue/linux-config/refs/heads/main/raspi/bashrc
        source ~/.bashrc
        sudo apt purge -y vim-common vim-tiny
        sudo apt autoremove --purge -y
        sudo apt install -y vim tree sane-utils nmap unattended-upgrades dnsutils
        sudo dpkg-reconfigure unattended-upgrades
            # yes
        ss -tuln

# Podman
    sudo apt install -y podman crun
    # httpd test
        # pudman pull docker.io/library/httpd
        # podman images
        # podman run -d -p 8080:80/tcp docker.io/library/httpd
        # podman ps -a
        # # http://192.168.50.20:8080/
        # podman logs -l
        # podman stop -l
        # podman rm -l
        # podman rmi --force 0722b3b8664e
    # unbound + pi-hole + dns network
        podman pull debian:latest
        podman images
        mkdir ~/unbound
        mv {Containerfile,custom.conf} ~/unbound/
        podman build -t my-unbound .
        mv custom.conf /etc/sysctl.d/custom.conf
        sudo sysctl -p
        # podman run -d --name unbound-dns -p 5335:5335/udp -p 5335:5335/tcp my-unbound
        mkdir ~/.config/containers/systemd
        mv {dns.network,pi-hole.container,unbound.container} ~/.config/containers/systemd
        loginctl enable-linger masonp
        systemctl --user daemon-reload
        # systemctl --user cat unbound
        systemctl --user start unbound
        systemctl --user start pi-hole
        # dig google.com @127.0.0.1#5335
    # miniflux
        mv {{miniflux,postgres}.container,rss.network,miniflux-db.volume} ~/.config/containers/systemd
        systemctl --user daemon-reload
        systemctl --user start postgres.service
        systemctl --user start miniflux.service
        # paste custom css in settings
    

# # FirewallD
#     sudo apt install -y firewalld
#     sudo systemctl enable --now firewalld.service
#     sudo systemctl status firewalld.service
#     sudo firewall-cmd --set-default-zone drop
#     sudo firewall-cmd --zone=drop --add-port=7583/tcp
#     sudo firewall-cmd --zone=drop --add-port=53/tcp
#     sudo firewall-cmd --zone=drop --add-port=53/udp
#     sudo firewall-cmd --state
#     sudo firewall-cmd --get-default-zone
#     sudo firewall-cmd --get-active-zones
#     sudo firewall-cmd --list-all