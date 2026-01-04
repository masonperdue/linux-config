
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
        sudo apt install -y vim tree sane-utils nmap unattended-upgrades dnsutils imagemagick
        sudo dpkg-reconfigure unattended-upgrades
            # yes
        ss -tuln

# Podman
    sudo apt install -y podman crun
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
        systemctl --user enable --now podman-auto-update.timer
        # systemctl --user cat unbound
        systemctl --user start unbound
        systemctl --user start pi-hole
        # dig google.com @127.0.0.1#5335
    # miniflux
        mv {{miniflux,postgres}.container,rss.network,miniflux-db.volume} ~/.config/containers/systemd/
        systemctl --user daemon-reload
        systemctl --user start postgres.service
        systemctl --user start miniflux.service
        # paste custom css in settings
    # Caddy
        mkdir ~/caddy
        mkdir ~/caddy/{http,caddy_config,caddy_data}
        vim ~/caddy/Caddyfile
        mv caddy.container ~/.config/containers/systemd/
        systemctl --user daemon-reload
        systemctl --user start caddy.service
    # Set raspi dns to cloudflare (so images can update w/o servers running)
        nmcli connection show
        sudo nmcli con mod netplan-eth0 ipv4.dns 1.1.1.1
        sudo nmcli con mod netplan-eth0 ipv4.ignore-auto-dns yes
        sudo nmcli con up netplan-eth0
        nmcli dev show
        dig startpage.com

# Firewalld
    sudo apt install -y firewalld
    sudo systemctl status firewalld.service
    sudo firewall-cmd --set-default-zone drop
    sudo firewall-cmd --zone=drop --add-port=7583/tcp   # ssh
    sudo firewall-cmd --zone=drop --add-port=53/tcp     # pi-hole dns
    sudo firewall-cmd --zone=drop --add-port=53/udp     # pi-hole dns
    sudo firewall-cmd --zone=drop --add-port=80/tcp     # caddy
    sudo firewall-cmd --zone=drop --add-port=443/tcp    # caddy
    sudo firewall-cmd --runtime-to-permanent
    sudo firewall-cmd --state
    sudo firewall-cmd --get-default-zone
    sudo firewall-cmd --get-active-zones
    sudo firewall-cmd --list-all
