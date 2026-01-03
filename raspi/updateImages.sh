#!/bin/bash

systemctl --user stop miniflux.service
systemctl --user stop postgres.service
systemctl --user stop pi-hole.service
systemctl --user stop unbound.service

podman image rm --force miniflux
podman image rm --force postgres
podman image rm --force pihole
podman image rm --force my-unbound

cd ~/unbound
podman build -t my-unbound .

podman images list

systemctl --user start unbound.service
systemctl --user status unbound.service
systemctl --user start pi-hole.service
systemctl --user status pi-hole.service
systemctl --user start postgres.service
systemctl --user status postgres.service
systemctl --user start miniflux.service
systemctl --user status miniflux.service

podman containers list --all

echo "Press enter to reboot: "
read input
sudo reboot now