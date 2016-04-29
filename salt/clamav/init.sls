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
