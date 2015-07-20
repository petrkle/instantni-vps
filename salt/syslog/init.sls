rsyslog:
  pkg.installed:
    - name: rsyslog
  service.running:
    - name: rsyslog
    - enable: True

/etc/rsyslog.conf:
 file.managed:
  - source: salt://syslog/rsyslog.conf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: rsyslog

/etc/rsyslog.d/mail.conf:
 file.managed:
  - source: salt://syslog/mail.conf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: rsyslog

var-log-mail:
  cmd.run:
    - name: mkdir /var/log/mail
    - unless: test -d /var/log/mail
