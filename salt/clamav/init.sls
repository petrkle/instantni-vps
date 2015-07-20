clamav-freshclam:
  pkg.installed:
    - name: clamav-freshclam
    - require_in:
      - pkg: amavisd-new
  service.running:
    - name: clamav-freshclam
    - enable: True

/etc/clamav/freshclam.conf:
 file.managed:
  - source: salt://clamav/freshclam.conf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: clamav-freshclam

clamav:
  pkg.installed:
    - name: clamav-daemon
    - require:
        - pkg: clamav-freshclam
    - require_in:
      - pkg: amavisd-new
  service.running:
    - name: clamav-daemon
    - enable: True


get-clamav-db-daily:
  cmd.run:
    - name: /etc/init.d/clamav-freshclam stop ; /usr/bin/freshclam --datadir /var/lib/clamav/ ; /etc/init.d/clamav-freshclam start
    - unless: test -f /var/lib/clamav/daily.*
    - cwd: /var/lib/clamav/
    - require:
      - pkg: clamav-freshclam
    - require_in:
      - pkg: amavisd-new
