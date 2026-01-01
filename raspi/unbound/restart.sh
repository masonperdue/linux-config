#!/bin/bash

# Unbound Ad Blocking Refresh Script
# ~/unbound/restart.sh

# block.txt and allow.txt should have domains on each line
cat /home/masonp/unbound/block.txt | awk '{print "\tlocal-zone: \""$1"\" refuse"}' >> /home/masonp/unbound/conf/block.conf
echo "server:" > /home/masonp/unbound/conf/allow.conf
cat /home/masonp/unbound/allow.txt | awk '{print "\tlocal-zone: \""$1"\" always_transparent"}' >> /home/masonp/unbound/conf/allow.conf

# local.txt should be a hosts file ("<ip address> <domain>" on each line)
echo "server:" > /home/masonp/unbound/conf/local.conf
cat /home/masonp/unbound/local.txt | awk '{print "\tlocal-zone: \""$2"\" redirect\n\tlocal-data: \""$2" A "$1"\""}' >> /home/masonp/unbound/conf/local.conf

# Restart Unbound
sudo systemctl restart unbound.service

# Display Unbound's Status
sudo unbound-control reload
# sudo systemctl status -l --no-pager unbound.service
wc --lines /etc/unbound/unbound.conf.d/custom.conf.d/block.conf
