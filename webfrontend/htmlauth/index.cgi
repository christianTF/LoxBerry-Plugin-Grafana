#!/usr/bin/perl

use LoxBerry::Web;

LoxBerry::Web::lbheader();

#my $hostname = LoxBerry::System::lbhostname();
my $hostname = $ENV{SERVER_ADDR};

print <<EOF;
<center>

<a href="http://$hostname:3000/" target="grafana">Open Grafana Webinterface</a>

</center>

EOF


LoxBerry::Web::lbfooter();
