logrotate:
  pkg.installed:
    - name: logrotate

/etc/logrotate.conf:
 file.managed:
  - source: salt://logrotate/logrotate.conf
  - mode: 644
  - user: root
  - group: root

/etc/logrotate.d/php5-fpm:
 file.managed:
  - source: salt://logrotate/php5-fpm
  - mode: 644
  - user: root
  - group: root

/etc/logrotate.d/nginx:
 file.managed:
  - source: salt://logrotate/nginx
  - mode: 644
  - user: root
  - group: root

/etc/logrotate.d/postfix:
 file.managed:
  - source: salt://logrotate/postfix
  - mode: 644
  - user: root
  - group: root
