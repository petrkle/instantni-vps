dkim:
  pkg.installed:
    - name: opendkim
  service.running:
    - name: opendkim
    - enable: True

opendkim-tools:
  pkg:
    - installed

opendkim-dir-create:
  file.directory:
    - name: /etc/opendkim
    - user: root
    - group: root
    - mode: 0755

/etc/opendkim.conf:
 file.managed:
  - source: salt://dkim/opendkim.conf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: opendkim

/etc/opendkim/internal:
 file.managed:
  - source: salt://dkim/internal
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: opendkim
  - require:
     - file: opendkim-dir-create

/etc/opendkim/key.table:
 file.managed:
  - source: salt://dkim/key.table
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: opendkim
  - require:
     - file: opendkim-dir-create

/etc/opendkim/signing.table:
 file.managed:
  - source: salt://dkim/signing.table
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: opendkim
  - require:
     - file: opendkim-dir-create

/etc/opendkim/dont-sign-mail.to:
 file.managed:
  - source: salt://dkim/dont-sign-mail.to
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: opendkim
  - require:
     - file: opendkim-dir-create

/etc/opendkim/mail.private:
 file.managed:
  - source: salt://dkim/mail.private
  - mode: 600
  - user: opendkim
  - group: opendkim
  - require:
     - file: opendkim-dir-create
  - watch_in:
      - service: opendkim

/etc/default/opendkim:
 file.managed:
  - source: salt://dkim/opendkim
  - mode: 600
  - user: root
  - group: root
  - watch_in:
      - service: opendkim
