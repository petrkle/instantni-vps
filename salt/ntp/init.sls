ntp:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/ntp.conf

ntpdate:
  pkg:
    - installed

/etc/ntp.conf:
 file.managed:
  - source: salt://ntp/ntp.conf
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - context:
     ntpserver: tik.cesnet.cz 
