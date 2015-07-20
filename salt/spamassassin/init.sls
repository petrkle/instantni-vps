spamassassin:
  pkg.installed:
    - name: spamassassin
    - require_in:
      - pkg: amavisd-new
  service.running:
    - name: spamassassin
    - enable: True
  

/etc/default/spamassassin:
 file.managed:
  - source: salt://spamassassin/spamassassin
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: spamassassin
