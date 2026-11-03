
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

# BASH
	cd
	git clone https://github.com/masonperdue/linux-config.git
	echo "" >> ~/.bashrc
	echo "source /home/mason/linux-config/bashrc" >> ~/.bashrc
	
# Git
	nvim ~/.ssh/id_ed25519-GitHub.pub
		# Past public key
	chmod 600 ~/.ssh/id_ed25519-GitHub.pub
	ln -sf /home/mason/linux-config/gitconfig /home/mason/.gitconfig

# LatekMk
	ln -sf /home/mason/linux-config/latexmkrc /home/mason/.latexmkrc

# Neovim
	cd
	gitClone neovim-config
	./neovim-config/setup.sh
