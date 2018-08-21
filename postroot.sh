#!/bin/bash
# Will be executed as user "root".

mkdir REPLACELBPDATADIR/download

# Downloading Grafana
wget -P REPLACELBPDATADIR/download https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_5.2.2_armhf.deb 
# Installing
dpkg -i REPLACELBPDATADIR/download/grafana_5.2.2_armhf.deb

if [ $? -ne 0 ]
then
	echo "Installation of Grafana failed - Terminating"
	exit 1
fi

# Reload daemons and auto-start grafana on boot
systemctl daemon-reload
systemctl enable grafana-server

# Install Grafana Simple-JSON Plugin
/usr/sbin/grafana-cli plugins install grafana-simple-json-datasource

# Provisioning Stats4Lox (SimpleJson) datasource
cp -f REPLACELBPDATADIR/provisioning/* /etc/grafana/provisioning/datasources/

# Grafana starten/restarten
systemctl restart grafana-server

exit 0
