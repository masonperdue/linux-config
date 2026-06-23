
# WSL Notes

wsl --shutdown
wsl --unregister Debian
wsl --update
wsl --list --online
wsl --install Debian
    # username: masonp
    # password: -----
sudo apt edit-sources
    # remove backports
    # add "contrib non-free non-free-firmware" to end of other lines
sudo apt update
sudo apt upgrade -y
# sudo apt purge -y ...
sudo apt autoremove --purge -y
sudo apt install -y git neovim
mkdir ~/.ssh
chmod 700 .ssh
# mv id_ed25519-Raspi ~/.ssh/
cd ~/.ssh
# ssh-keygen -t ed25519 -C "220426478+masonperdue@users.noreply.github.com"
    # file: id_ed25519-GitHub
    # passphrase: -----
chmod 600 id_ed25519-Raspi
chmod 600 id_ed25519-GitHub
chmod 644 *.pub
cat *.pub   # add to GitHub as both auth and signing
ssh -i ~/.ssh/id_ed25519-GitHub -T git@github.com
git config --global user.name "Mason Perdue"
git config --global user.email "220426478+masonperdue@users.noreply.github.com"
git config --global user.signingkey "~/.ssh/id_ed25519-GitHub.pub"
git config --global commit.gpgsign true
git config --global gpg.format ssh
mkdir ~/.myconfig
cd ~/.myconfig
git clone git@github.com:masonperdue/linux-config.git
git clone git@github.com:masonperdue/neovim-config.git