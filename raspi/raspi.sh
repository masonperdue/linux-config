

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
        sudo systemctl disable --now bluetooth.service
        sudo mv /etc/motd /etc/motd.back          
        sudo reboot now
    # ssh masonp@192.168.50.20 -p 7583
        rm ~/.bashrc
        curl --output ~/.bashrc https://raw.githubusercontent.com/masonperdue/linux-config/refs/heads/main/dot-bashrc
        source .bashrc
        sudo apt purge -y vim-common vim-tiny
        sudo apt autoremove --purge -y
        sudo apt install -y vim tree sane-utils nmap  unattended-upgrades
        sudo dpkg-reconfigure unattended-upgrades
        # ss -tuln  # view open ports

# # Unbound
#     # Setup
#         sudo apt update
#         sudo apt install unbound
#         unbound -V  # should display version number
#         sudo systemctl edit unbound.service
#             [Service]
#             ExecStartPre=timeout 60s sh -c 'until ping -c1 192.168.50.1; do sleep 1; done;'
#         sudo systemctl cat unbound.service
#         sudo systemctl daemon-reload
#         sudo systemctl restart unbound.service
#         sudo systemctl status unbound.service
#         sudo touch /var/log/unbound.log
#         sudo chown unbound:unbound /var/log/unbound.log
#         sudo touch /etc/unbound/unbound.conf.d/custom.conf
#         sudoedit /etc/unbound/unbound.conf.d/custom.conf
#         unbound-checkconf /etc/unbound/unbound.conf.d/custom.conf
#         sudo unbound-control reload
#         # unbound -d -vv -c unbound.conf
#         # tail /var/log/unbound.log
#         sudo systemctl status unbound.service
#         sudo apt install dnsutils
#         dig google.com @127.0.0.1
#     # Filtering
#         mkdir ~/unbound/{conf,hosts} && cd ~/unbound
#         mkdir ~/unbound/{allow,block,local}.txt
#         sudo mkdir /etc/unbound/unbound.conf.d/custom.conf.d
#         sudo ln -s /home/masonp/unbound/conf/block.conf /etc/unbound/unbound.conf.d/custom.conf.d/block.conf
#         sudo ln -s /home/masonp/unbound/conf/safe.conf /etc/unbound/unbound.conf.d/custom.conf.d/safe.conf
#         sudo ln -s /home/masonp/unbound/conf/allow.conf /etc/unbound/unbound.conf.d/custom.conf.d/allow.conf
#         sudo ln -s /home/masonp/unbound/conf/local.conf /etc/unbound/unbound.conf.d/custom.conf.d/local.conf
#         touch ~/unbound/refresh.sh
#         chmod +x ~/unbound/refresh.sh
#         vim ~/unbound/refresh.sh
#         touch /home/masonp/unbound/conf/safe.conf
#         crontab -e
#             0 5 * * * bash /home/masonp/unbound/refresh.sh
#         # echo "<domain>" >> block.txt  # or allow or local
#         # scp -r -P 7583 masonp@192.168.50.20:/home/masonp/unbound unbound

# # Miniflux
#     sudo apt install postgresql
#     sudo -u postgres -i
#     # createuser -P miniflux
#         # enter password
#     # createdb -O miniflux miniflux2
#     createdb miniflux2
#     psql
#     ALTER USER postgres WITH PASSWORD 'postgres';
#     \q
#     exit
#     sudo apt install miniflux
#         # yes
#         # masonp
#         # # enter password
#         # yes
#         # localhost
#         # # enter password
#         no
#         no
#     sudoedit /etc/miniflux/miniflux.conf
#         # remove all lines
#     sudo rm /etc/miniflux/database
#     miniflux -migrate -config-file /etc/miniflux/miniflux.conf
#     miniflux -create-admin -config-file /etc/miniflux/miniflux.conf
#         # enter username and password

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

# Podman
    