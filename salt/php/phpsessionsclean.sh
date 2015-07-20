#!/bin/bash

set -e

for foo in {{ pillar['fpm_pools']|join(' ') }}
do
	        nice -19 ionice -c 3 find /var/lib/php5/sessions/$foo -type f -name "sess_*" -mtime +21 -delete
done
