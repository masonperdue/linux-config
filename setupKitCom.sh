
# Setup Script for Linux Config
# sudo apt install -y git && mkdir ~/.myconfig && cd ~/.myconfig && git clone https://github.com/masonperdue/linux-config.git && cd linux-config && chmod +x setup.sh && ./setup.sh

echo "" >> /home/family/.bashrc
echo ". /home/family/.bashrc.d/*" >> /home/family/.bashrc
mkdir /home/family/.bashrc.d
ln -sf /home/family/.myconfig/linux-config/bashrc.d/* /home/family/.bashrc.d/
echo "source /home/family/.bashrc"
