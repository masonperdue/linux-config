
# Setup Script for Linux Config

echo ""
echo "Updating and Installing Packages"
echo "Computer Name (wsl/kitcom/surface): "
read input
if [ "$input" == "wsl" ]; then
        mkdir /home/masonp/.ssh
        ln -sf /home/masonp/.myconfig/linux-config/ssh/config /home/masonp/.ssh/config
        chmod 600 /home/masonp/.ssh/config

        echo "" >> /home/masonp/.bashrc
        echo ". /home/masonp/.bashrc.d/*" >> /home/masonp/.bashrc
        mkdir /home/masonp/.bashrc.d
        ln -sf /home/masonp/.myconfig/linux-config/bashrc.d/* /home/masonp/.bashrc.d/
        echo "source /home/masonp/.bashrc"

        ln -sf /home/masonp/.myconfig/linux-config/.latexmkrc /home/masonp/.latexmkrc


        echo "Installing Packages for WSL"
        sudo apt update -y
        sudo apt upgrade -y
        sudo apt remove --purge -y vim-common vim-tiny
        sudo apt autoremove --purge -y
        sudo apt install -y curl vim usbutils rsync git htop man-db tree sane-utils imagemagick libimage-exiftool-perl nmap ffmpeg bash-completion unattended-upgrades texlive-full openssh-client dnsutils latexmk # gcc gdb gnugo gnuchess default-jdk octave
        # curl -fsSL https://install.julialang.org | sh

        echo ""
        echo "Configuring Git"
        # echo "Configure Git w/ SSH (y/n): "
        # read input
        # if [ "$input" == "y" ]; then
                # echo "Using: /home/$USER/.ssh/id_ed25519.pub"
                # echo "Generate Key With: ssh-keygen -t ed25519 -C '220426478+masonperdue@users.noreply.github.com' or 'gpg --full-generate-key' (4 then 4096) and 'gpg --list-secret-keys' and 'gpg --armor --export [ID]' and 'git config --global user.signingkey [id]' and add 'pinentry-program "/mnt/c/Program Files/Git/usr/bin/pinentry.exe"' to '~/.gnupg/gpg-agent.conf'"
                # sudo chmod 700 ~/.ssh/id*
                git config --global user.name masonperdue
                git config --global user.email 220426478+masonperdue@users.noreply.github.com
                # git config --global user.signingkey /home/$USER/.ssh/id_ed25519.pub
                git config --global core.editor vim
                git config --global init.defaultBranch main
                git config --global commit.gpgsign true
                # git config --global gpg.format ssh
                # echo "Linking Bashrc"
                # cd
                # git clone git@github.com:masonperdue/linux-config.git
                # rm ~/.bashrc
                # ln -s /home/$USER/linux-config/dot-bashrc /home/$USER/.bashrc
                # source ~/.bashrc
        # elif [ "$input" == "n" ]; then
        #       cd
        #       git clone https://github.com/masonperdue/linux-config.git
        #       rm ~/.bashrc
        #       ln -s /home/$USER/linux-config/dot-bashrc /home/$USER/.bashrc
        #       source ~/.bashrc
        # fi
        # ssh -T git@github.com
        # git remote add origin git@github.com:masonperdue/repo.git
        # git pull origin main
        # git init
        # git log
        # git diff
elif [ "$input" == "kitcom" ] || [ "$input" == "surface" ]; then
        echo "Setting Up Bashrc"
        if ! grep -q '\.bashrc\.d/mybashrc' /home/family/.bashrc 2>/dev/null; then
                echo "" >> /home/family/.bashrc
                echo ". /home/family/.bashrc.d/mybashrc" >> /home/family/.bashrc
        fi
        mkdir /home/family/.bashrc.d
        ln -sf /home/family/.myconfig/linux-config/bashrc.d/mybashrc /home/family/.bashrc.d/mybashrc
        echo "Run: source /home/family/.bashrc"

        echo ""
        echo "Installing Packages for KitCom or Surface"
        sudo apt update
        sudo apt upgrade -y
        sudo apt autoremove --purge -y
        sudo apt install --no-install-recommends -y xserver-xorg-core xserver-xorg xinit xfce4-session xfwm4 xfce4-panel xfce4-terminal thunar thunar-volman gvfs xfce4-pulseaudio-plugin pavucontrol htop tree firewalld xfce4-screensaver xfce4-power-manager xfce4-screenshooter
        cd
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo apt install -y ./google-chrome-stable_current_amd64.deb
        rm *.deb

        echo ""
        echo "Configuring XFCE"
        touch ~/.xinitrc
        echo 'exec startxfce4' > ~/.xinitrc
        if ! grep -q 'exec startx' ~/.bash_profile 2>/dev/null; then
                echo 'if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then' >> ~/.bash_profile
                echo '    exec startx' >> ~/.bash_profile
                echo 'fi' >> ~/.bash_profile
        fi
        mkdir -p ~/.config/autostart
        touch ~/.config/autostart/chrome.desktop
        echo "[Desktop Entry]" > ~/.config/autostart/chrome.desktop
        echo "Type=Application" >> ~/.config/autostart/chrome.desktop
        echo "Name=Google Chrome AutoStart" >> ~/.config/autostart/chrome.desktop
        echo "Comment=Launch Chrome on login" >> ~/.config/autostart/chrome.desktop
        echo "Exec=google-chrome --start-maximized" >> ~/.config/autostart/chrome.desktop
        echo "Terminal=false" >> ~/.config/autostart/chrome.desktop
        echo "Hidden=false" >> ~/.config/autostart/chrome.desktop
        sudo systemctl disable keyboard-setup.service
        sudo systemctl disable console-setup.service
fi

echo ""
echo "Configure Neovim (y/n): "
read input
if [ "$input" == "y" ]; then
        echo "Configuring Neovim"
        cd ~/.myconfig
        git clone https://github.com/masonperdue/neovim-config.git
        cd neovim-config
        ./setup.sh
fi

echo ""
echo "Configure Firewall (y/n): "
read input
if [ "$input" == "y" ]; then
        echo "Configuring Firewall"
        sudo systemctl enable --now firewalld.service
        sudo systemctl status firewalld.service
        sudo firewall-cmd --set-default-zone drop
        sudo firewall-cmd --state
        sudo firewall-cmd --get-default-zone
        sudo firewall-cmd --get-active-zones
        sudo firewall-cmd --list-all
fi

echo ""
echo "Configure Vim-Journal (y/n): "
read input
if [ "$input" == "y" ]; then
      echo "Configuring Vim-Journal"
      cd
      git clone git@github.com:masonperdue/vim-journal.git
      chmod +x ~/vim-journal/jrnl.sh
fi

echo ""
echo "Configure Latexmk (y/n): "
read input
if [ "$input" == "y" ]; then
      echo "Configuring Latexmk"
      sudo apt install -y evince
      touch ~/.latexmk
      echo '$pdf_previewer = "start evince";' > ~/.latexmk
fi

echo ""
echo "Install Openssh Server (y/n): "
read input
if [ "$input" == "y" ]; then
      echo "Installing Openssh Server"
      sudo apt install -y openssh-server
      echo "Run: sudoedit /etc/ssh/sshd.config"
      echo "Set: Port 7530"
      echo "Set: PermitRootLogin no"
fi