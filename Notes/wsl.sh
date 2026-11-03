
# WSL

# Install
	# wsl --shutdown
	# wsl --unregister Debian
	# wsl --update
	# wsl --list --online
	wsl --install Debian
	masonp # change to mason
		# [pw]

# APT
	sudo apt update
	sudoedit /etc/apt/sources.list.d/0000debian.sources
	    # remove backports
	    # add "contrib non-free non-free-firmware" to end of other lines
	sudo apt update
	sudo apt autoremove --purge -y
	sudo apt upgrade -y
	sudo apt install -y texlive-full evince git # nmap bind9-dnsutils htop curl man-db tree libimage-exiftool-perl ffmpeg gcc gdb default-jdk octave
	# curl -fsSL https://install.julialang.org | sh
	
# Neovim
	git clone https://github.com/masonperdue/neovim-config.git
	./neovim-config/setup.sh

# Git
	nvim ~/.ssh/id_ed25519-GitHub.pub
		# Past public key
	chmod 600 ~/.ssh/id_ed25519-GitHub.pub
	ln -sf /home/masonp/linux-config/gitconfig /home/masonp/.gitconfig

# LatekMk
	ln -sf /home/masonp/linux-config/latexmkrc /home/masonp/.latexmkrc
