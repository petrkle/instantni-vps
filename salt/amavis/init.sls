amavis:
  pkg.installed:
    - name: amavisd-new
    - require:
       - file: /etc/hostname
  service.running:
    - name: amavis
    - enable: True

/etc/amavis/conf.d/50-user:
 file.managed:
  - source: salt://amavis/50-user
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: amavis

/etc/amavis/conf.d/15-content_filter_mode:
 file.managed:
  - source: salt://amavis/15-content_filter_mode
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: amavis

/etc/amavis/conf.d/05-node_id:
 file.managed:
  - source: salt://amavis/05-node_id
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: amavis

/etc/amavis/conf.d/20-debian_defaults:
 file.managed:
  - source: salt://amavis/20-debian_defaults
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: amavis

/var/lib/amavis/.spamassassin/user_prefs:
 file.managed:
  - source: salt://amavis/user_prefs
  - mode: 644
  - user: amavis
  - group: amavis
  - makedirs: True
  - watch_in:
      - service: amavis
