awstats:
  pkg.installed:
    - name: awstats

/etc/cron.d/awstats:
 file.absent

/usr/local/bin/wwwstats.sh:
 file.managed:
  - source: salt://awstats/wwwstats.sh                                                                                           
  - mode: 755 
  - user: root
  - template: jinja
  - group: root

stat-dir-create:
  file.directory:
    - name: /home/www/stat
    - user: www-data
    - group: www-data
    - mode: 0755


/etc/nginx/conf.d/awstats.conf:
 file.managed:
  - source: salt://nginx/awstats.conf
  - mode: 644 
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: nginx
