#!/bin/bash

OUT=/home/www/stat

[ -d $OUT ] || mkdir $OUT

for DOMAIN in {{ pillar.domain_example }} \
	{{ pillar.domain_foo }} \
	rss.{{ pillar.domain_example }} \
	autoconfig \
	{{ pillar.phpmyadmin_url }} \
	roundcube.{{ pillar.domain_example }}
do

echo "LogFile=\"/var/log/nginx/${DOMAIN}.access.log\"
LogType=W
LogFormat=\"%host %other %other %time1 %methodurl %code %bytesd %refererquot %uaquot\"
LogSeparator=\" \"
SiteDomain=\"${DOMAIN}\"
DNSLookup=0
HostAliases=\"${DOMAIN}\"
DetailedReportsOnNewWindows=0
LogoLink=\"/\"
DirIcons=\"/icon\"
Lang=\"cz\"" > /etc/awstats/awstats.$DOMAIN.conf

[ -d $OUT/$DOMAIN ] || mkdir $OUT/$DOMAIN

/usr/lib/cgi-bin/awstats.pl -update -staticlinks -config=$DOMAIN -output > $OUT/$DOMAIN/awstats.$DOMAIN.html

[ -L $OUT/$DOMAIN/index.html ] || ln -s $OUT/$DOMAIN/awstats.$DOMAIN.html $OUT/$DOMAIN/index.html

for REPORT in errors404 keywords keyphrases refererpages refererse unknownos unknownbrowser osdetail browserdetail urlexit urlentry urldetail lastrobots allrobots alldomains lasthosts allhosts unknownip downloads
do
  /usr/lib/cgi-bin/awstats.pl -update -staticlinks -config=$DOMAIN -output=$REPORT > $OUT/$DOMAIN/awstats.$DOMAIN.$REPORT.html
done

done
