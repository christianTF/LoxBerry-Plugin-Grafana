#!/bin/bash
# Will be executed as user "root".

# Grafana stoppen
systemctl stop grafana-server

echo "<INFO> Adding/Updating Grafana repository..."
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

echo "<INFO> Adding/Updating repository key to apt..."
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -


exit 0
