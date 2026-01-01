#!/bin/bash

# Unbound Ad Blocking Refresh Script
# ~/unbound/refresh.sh

# Download block lists (as hosts files) and convert hosts files to conf files
touch /home/masonp/unbound/conf/tmp-block.conf
echo "server:" > /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts --output /home/masonp/unbound/hosts/StevenBlack
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/StevenBlack | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/dibdot/DoH-IP-blocklists/refs/heads/master/doh-domains_overall.txt --output /home/masonp/unbound/hosts/dibdot
cat /home/masonp/unbound/hosts/dibdot | awk '{print "\tlocal-zone: \""$1"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://big.oisd.nl/unbound --output /home/masonp/unbound/hosts/oisd-big
grep -P '^local-zone' /home/masonp/unbound/hosts/oisd-big | awk '{print "\tlocal-zone: "$2" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://nsfw.oisd.nl/unbound --output /home/masonp/unbound/hosts/oisd-nsfw
grep -P '^local-zone' /home/masonp/unbound/hosts/oisd-nsfw | awk '{print "\tlocal-zone: "$2" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext" --output /home/masonp/unbound/hosts/yoyo
grep -P '^127\.0\.0\.1' /home/masonp/unbound/hosts/yoyo | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-hosts.txt --output /home/masonp/unbound/hosts/urlhaus
grep -P '^0\.0\.0\.0' /home/masonp/unbound/hosts/urlhaus | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/abuse.txt --output /home/masonp/unbound/hosts/blocklistproject-abuse
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-abuse | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/ads.txt --output /home/masonp/unbound/hosts/blocklistproject-ads
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-ads | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/basic.txt --output /home/masonp/unbound/hosts/blocklistproject-basic
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-basic | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/crypto.txt --output /home/masonp/unbound/hosts/blocklistproject-crypto
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-crypto | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/drugs.txt --output /home/masonp/unbound/hosts/blocklistproject-drugs
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-drugs | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/fraud.txt --output /home/masonp/unbound/hosts/blocklistproject-fraud
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-fraud | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/gambling.txt --output /home/masonp/unbound/hosts/blocklistproject-gambling
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-gambling | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/malware.txt --output /home/masonp/unbound/hosts/blocklistproject-malware
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-malware | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/phishing.txt --output /home/masonp/unbound/hosts/blocklistproject-phishing
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-phishing | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/piracy.txt --output /home/masonp/unbound/hosts/blocklistproject-piracy
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-piracy | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/porn.txt --output /home/masonp/unbound/hosts/blocklistproject-porn
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-porn | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/ransomware.txt --output /home/masonp/unbound/hosts/blocklistproject-ransomware
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-ransomware | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/scam.txt --output /home/masonp/unbound/hosts/blocklistproject-scam
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-scam | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/smart-tv.txt --output /home/masonp/unbound/hosts/blocklistproject-smart-tv
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-smart-tv | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/tracking.txt --output /home/masonp/unbound/hosts/blocklistproject-tracking
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-tracking | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/vaping.txt --output /home/masonp/unbound/hosts/blocklistproject-vaping
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-vaping | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/blocklistproject/Lists/refs/heads/master/youtube.txt --output /home/masonp/unbound/hosts/blocklistproject-youtube
grep -P '^0\.0\.0\.0(?! 0\.0\.0\.0)' /home/masonp/unbound/hosts/blocklistproject-youtube | awk '{print "\tlocal-zone: \""$2"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://github.com/kboghdady/youTube_ads_4_pi-hole/raw/refs/heads/master/youtubelist.txt --output /home/masonp/unbound/hosts/kboghdady
cat /home/masonp/unbound/hosts/kboghdady | awk '{print "\tlocal-zone: \""$1"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
curl -L https://raw.githubusercontent.com/Athar5443/Youtube_BlockAds_List/refs/heads/main/blocklist.txt --output /home/masonp/unbound/hosts/Athar5443
cat /home/masonp/unbound/hosts/Athar5443 | awk '{print "\tlocal-zone: \""$1"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf

# block.txt and allow.txt should have domains on each line
cat /home/masonp/unbound/block.txt | awk '{print "\tlocal-zone: \""$1"\" always_nxdomain"}' >> /home/masonp/unbound/conf/tmp-block.conf
echo "server:" > /home/masonp/unbound/conf/allow.conf
cat /home/masonp/unbound/allow.txt | awk '{print "\tlocal-zone: \""$1"\" always_transparent"}' >> /home/masonp/unbound/conf/allow.conf

# removes duplicates from tmp-block.conf
sed -i 's/\."/"/g' /home/masonp/unbound/conf/tmp-block.conf
echo "server:" > /home/masonp/unbound/conf/block.conf
(head -n 1 /home/masonp/unbound/conf/tmp-block.conf && tail -n +2 /home/masonp/unbound/conf/tmp-block.conf | sort -u) >> /home/masonp/unbound/conf/block.conf
rm /home/masonp/unbound/conf/tmp-block.conf

# local.txt should be a hosts file ("<ip address> <domain>" on each line)
echo "server:" > /home/masonp/unbound/conf/local.conf
cat /home/masonp/unbound/local.txt | awk '{print "\tlocal-zone: \""$2"\" redirect\n\tlocal-data: \""$2" A "$1"\""}' >> /home/masonp/unbound/conf/local.conf
