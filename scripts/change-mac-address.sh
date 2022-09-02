#!/bin/sh
new_mac="$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')"
echo "Setting MAC address of en0 to $new_mac"
sudo ifconfig en0 ether $new_mac
