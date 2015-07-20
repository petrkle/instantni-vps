/etc/crontab:
 file.managed:
  - source: salt://crontab/crontab
  - template: jinja
  - mode: 644 
  - user: root
  - group: root
