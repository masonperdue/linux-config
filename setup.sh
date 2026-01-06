
# Setup Script for Linux Config
# sudo apt install -y git && mkdir ~/.myconfig && cd ~/.myconfig && git clone https://github.com/masonperdue/linuxconfig.git && cd linux-config && chmod +x setup.sh && ./setup.sh

mkdir /home/masonp/.ssh
ln -sf /home/masonp/.myconfig/linux-config/ssh/config /home/masonp/.ssh/config
chmod 600 /home/masonp/.ssh/config

echo "" >> /home/masonp/.bashrc
echo ". /home/masonp/.bashrc.d/*" >> /home/masonp/.bashrc
mkdir /home/masonp/.bashrc.d
ln -sf /home/masonp/.myconfig/linux-config/bashrc.d/* /home/masonp/.bashrc.d/
echo "source /home/masonp/.bashrc"
