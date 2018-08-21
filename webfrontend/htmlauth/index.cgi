#!/usr/bin/perl

use LoxBerry::Web;

LoxBerry::Web::lbheader();

my $hostname = LoxBerry::System::lbhostname();

print <<EOF;
<center>

<a href="http://$hostname:3000/">Open Grafana Webinterface</a>

</center>

EOF


LoxBerry::Web::lbfooter();
