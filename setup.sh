
## Notes Only - DO NOT RUN ##

echo ""
echo "Updating and Installing Packages"
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
echo "Configure Latexmk (y/n): "
read input
if [ "$input" == "y" ]; then
      echo "Configuring Latexmk"
      sudo apt install -y evince
      touch ~/.latexmk
      echo '$pdf_previewer = "start evince";' > ~/.latexmk
fi
