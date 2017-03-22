apticron:
  pkg.installed:
    - name: apticron

/etc/apticron/apticron.conf:
 file.managed:
  - source: salt://apticron/apticron.conf
  - template: jinja
  - mode: 644 
  - user: root
  - group: root

/usr/local/bin/akt.sh:
 file.managed:
  - source: salt://apticron/akt.sh
  - mode: 700
  - user: root
  - group: root
