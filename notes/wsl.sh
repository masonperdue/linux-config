
# WSL

# Install
	# wsl --shutdown
	# wsl --unregister Debian
	# wsl --update
	# wsl --list --online
	wsl --install Debian
		# mason
		# [pw]

# APT
	sudo apt update
	sudoedit /etc/apt/sources.list.d/0000debian.sources
	    # remove backports
	sudo apt update
	sudo apt upgrade -y
	sudo apt install -y texlive-full evince git nmap bind9-dnsutils htop curl man-db tree libimage-exiftool-perl ffmpeg gcc gdb # default-jdk octave
	# curl -fsSL https://install.julialang.org | sh
	# sudo apt autoremove --purge -y

# Sudo
    echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER-nopasswd
    sudo chmod 440 /etc/sudoers.d/$USER-nopasswd
    sudo visudo -c

# BASH
	cd
	git clone https://github.com/masonperdue/linux-config.git
	echo "" >> ~/.bashrc
	echo "source /home/mason/linux-config/bashrc" >> ~/.bashrc
	
# Git
    ssh-keygen -t ed25519 -C '220426478+masonperdue@users.noreply.github.com'
        # id_ed25519-GitHub
    cat ~/.ssh/id_ed25519-GitHub
        # add to GitHub as auth and signing key
	ln -sf /home/mason/linux-config/gitconfig /home/mason/.gitconfig
    gitKey
    ssh -T git@github.com
    cd
    rm -rf linux-config
    gitClone linux-config

# LatekMk
	ln -sf /home/mason/linux-config/latexmkrc /home/mason/.latexmkrc

# Neovim
	gitClone neovim-config
	./neovim-config/setup.sh
