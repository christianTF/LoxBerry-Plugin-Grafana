#!/bin/bash
# Will be executed as user "root".

# To use important variables from command line use the following code:
COMMAND=$0    # Zero argument is shell command
PTEMPDIR=$1   # First argument is temp folder during install
PSHNAME=$2    # Second argument is Plugin-Name for scipts etc.
PDIR=$3       # Third argument is Plugin installation folder
PVERSION=$4   # Forth argument is Plugin version
#LBHOMEDIR=$5 # Comes from /etc/environment now. Fifth argument is
              # Base folder of LoxBerry
PTEMPPATH=$6  # Sixth argument is full temp path during install (see also $1)

# Combine them with /etc/environment
LBPHTMLAUTHDIR=$LBPHTMLAUTH/$PDIR
LBPHTMLDIR=$LBPHTML/$PDIR
LBPTEMPLATEDIR=$LBPTEMPL/$PDIR
LBPDATADIR=$LBPDATA/$PDIR
LBPLOGDIR=$LBPLOG/$PDIR # Note! This is stored on a Ramdisk now!
LBPCONFIGDIR=$LBPCONFIG/$PDIR
LBPBINDIR=$LBPBIN/$PDIR

# Installing
#dpkg -i $DOWNLOADDIR/grafana_5.2.2_armhf.deb

#if [ $? -ne 0 ]
#then
#	echo "Installation of Grafana failed - Terminating"
#	exit 1
#fi

# Reload daemons and auto-start grafana on boot
systemctl daemon-reload
systemctl enable grafana-server

# if [ ! -L "/etc/grafana" ] ; then
	# mv /etc/grafana /etc/grafana.orig
	# cp -R /etc/grafana.orig/* $LBPCONFIGDIR/
	# ln -s $LBPCONFIGDIR /etc/grafana
# fi

# Install Grafana Simple-JSON Plugin
# /usr/sbin/grafana-cli plugins install grafana-simple-json-datasource

# Provisioning Stats4Lox (SimpleJson) datasource
# cp -r -f $LBPDATADIR/shipment/provisioning/* /etc/grafana/provisioning/
# chown -R grafana:grafana /etc/grafana/provisioning/

# # chown
# chown -R loxberry:loxberry $LBPCONFIGDIR
# chmod -R 775 $LBPCONFIGDIR

usermod -a -G loxberry grafana

if [ -e "$LBPBIN/stats4lox-ng/provisioning/set_datasource_influx.pl" ]; then
	$LBPBIN/stats4lox-ng/provisioning/set_datasource_influx.pl
	$LBPBIN/stats4lox-ng/provisioning/set_dashboard_provider.pl
fi

# Grafana starten/restarten
systemctl restart grafana-server

exit 0
