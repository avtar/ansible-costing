#!/bin/bash

test_dir=`ls -ltx /srv/www/tsung/logs/ | awk '{print $1}' | head -n 1`

[ -d /srv/www/tsung/reports/${test_dir} ] || mkdir /srv/www/tsung/reports/${test_dir}

cd /srv/www/tsung/reports/${test_dir}

/usr/lib64/tsung/bin/tsung_stats.pl \
--gnuplot /usr/bin/gnuplot \
--stats /srv/www/tsung/logs/${test_dir}/tsung.log