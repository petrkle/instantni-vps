/etc/hostname:
 file.managed:
  - source: salt://hostname/hostname
  - template: jinja
  - mode: 644
  - user: root
  - group: root
