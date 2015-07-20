/etc/apt/listchanges.conf:
 file.managed:
  - source: salt://listchanges/listchanges.conf
  - template: jinja
  - mode: 644
  - user: root
  - group: root
