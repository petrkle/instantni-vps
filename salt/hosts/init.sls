/etc/hosts:
 file.managed:
  - source: salt://hosts/hosts
  - template: jinja
  - mode: 644
  - user: root
  - group: root
