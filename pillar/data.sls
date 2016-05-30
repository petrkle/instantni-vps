ssh_port: 22 # port na kterém běží ssh server

{% macro admin_user() %}petr{% endmacro %}
admin_user: {{ admin_user() }} # uživatel který spravuje server

{% if grains['testmachine'] != 'OK' %}
# ostrý provoz

ipv4adress: {{ grains.ip_interfaces.eth0[0] }}
ipv6adress: {{ grains.ipv6[0] }}

{% macro domain_example() %}example.com{% endmacro %}
{% macro domain_foo() %}foo.com{% endmacro %}

hostname: instant-vps.{{ domain_example() }}

{% else %} 
# testovací prostředí

ipv4adress: {{ grains.ip_interfaces.eth0[0] }}
ipv6adress: {{ grains.ipv6[0] }}

{% macro domain_example() %}example.cz{% endmacro %}
{% macro domain_foo() %}foo.cz{% endmacro %}

hostname: salt-test.{{ domain_example() }}

{% endif %}

base_mail_domain: {{ domain_example() }}

mailname: mx.{{ domain_example() }}

webmail_url: roundcube.{{ domain_example() }}
phpmyadmin_url: db.{{ domain_example() }}

domain_example: {{ domain_example() }}
domain_foo: {{ domain_foo() }}

maildomains:
  - {{ domain_example() }}
  - {{ domain_foo() }}

cyruspass: 8ma2xFmiNE

http_auth_users:
  db: 
   pass: mqClmxh4yAhq4qf
  stat:
   pass: irkjb0RosizE3ys

fakemail:
  port: 1234
  home: /home/fakemail

roundcube:
  version: 1.2.0
  md5: 093c51f36ece4b35b89d7569b571c04d

phpmyadmin:
  version: "4_6_2"
  md5: 9a51704f87b252fe12e31e2807da02c7

mysql:
  root_password: n6kjNL8cvqkuvcg
  ttrss_password: LtaVn1lnxpup2qk

mailboxes:
  {{ admin_user() }}:
    mailbox: {{ admin_user() }}@{{ domain_example() }}
    password: 2xp5dLxsPz
  ondrej:
    mailbox: ondra@{{ domain_example() }}
    password: dtfz89jdUS
  jana:
    mailbox: jana@{{ domain_foo() }}
    password: 9WzmdqfsL3
  jitka:
    mailbox: jitka@{{ domain_foo() }}
    password: fKSg4cl9by

fpm_pools:
  www:
   port: 9000
  ttrss:
   port: 9001
  roundcube:
   port: 9002
  phpmyadmin:
   port: 9003

nginx_confs:
 - autoconfig
 - awstats
 - phpmyadmin
 - roundcube
 - staticsite
 - ttrss

# utility k nainstalování
utils:
 - htop
 - curl
 - tar
 - dtrx
 - cpanminus
 - cowsay
 - resolvconf
 - fortunes-cs
 - apache2-utils
 - tcpdump
 - sqlite3
 - links
 - gettext
 - libipc-system-simple-perl
 - libtemplate-perl
 - libxml-simple-perl
 - libintl-perl
 - apt-listchanges
 - libxml-perl
 - libxml-libxml-perl
 - colordiff
 - apt-transport-https
 - nmap
 - unp
 - libio-socket-ip-perl
 - libnet-server-mail-perl
 - libwww-mechanize-perl
 - libfile-slurp-perl
 - libimage-size-perl
 - libstring-mkpasswd-perl
 - libimage-exiftool-perl
 - libemail-simple-perl
 - libemail-mime-perl
 - libmime-tools-perl
 - libtest-json-perl
 - zip 
 - imagemagick

# nepotřebné balíky
remove:
 - nano
 - vim-tiny
 - nfs-common
 - rpcbind
 - procmail
 - mutt
