#!/bin/bash
# Will be executed as user "root".

LBPCONFIGDIR=REPLACELBPCONFIGDIR
LBPDATADIR=REPLACELBPDATADIR

DOWNLOADDIR=$LBPDATADIR/download

mkdir $DOWNLOADDIR
chown loxberry:loxberry $DOWNLOADDIR
rm -f $DOWNLOADDIR/*

# Downloading Grafana
wget -P $DOWNLOADDIR https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_5.2.2_armhf.deb 
chown -f loxberry:loxberry $DOWNLOADDIR/* 

# Installing
dpkg -i $DOWNLOADDIR/grafana_5.2.2_armhf.deb

if [ $? -ne 0 ]
then
	echo "Installation of Grafana failed - Terminating"
	exit 1
fi

# Reload daemons and auto-start grafana on boot
systemctl daemon-reload
systemctl enable grafana-server

# if [ ! -L "/etc/grafana" ] ; then
	# mv /etc/grafana /etc/grafana.orig
	# cp -R /etc/grafana.orig/* $LBPCONFIGDIR/
	# ln -s $LBPCONFIGDIR /etc/grafana
# fi

# Install Grafana Simple-JSON Plugin
/usr/sbin/grafana-cli plugins install grafana-simple-json-datasource

# Provisioning Stats4Lox (SimpleJson) datasource
cp -r -f $LBPDATADIR/shipment/provisioning/* /etc/grafana/provisioning/
chown -R grafana:grafana /etc/grafana/provisioning/

# # chown
# chown -R loxberry:loxberry $LBPCONFIGDIR
# chmod -R 775 $LBPCONFIGDIR

usermod -a -G loxberry grafana

# Grafana starten/restarten
systemctl restart grafana-server

exit 0
