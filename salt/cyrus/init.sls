cyrus-imapd:
  pkg.installed:
    - name: cyrus-imapd
    - require:
        - service: saslauthd
  service.running:
    - name: cyrus-imapd
    - enable: True
    - watch:
        - file: /etc/cyrus.conf
        - file: /etc/imapd.conf

cyrus-admin:
  pkg:
    - installed

/etc/cyrus.conf:
 file.managed:
  - source: salt://cyrus/cyrus.conf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: cyrus-imapd

/etc/imapd.conf:
 file.managed:
  - source: salt://cyrus/imapd.conf
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - require:
     - file: cert-dir-create
  - watch_in:
      - service: cyrus-imapd

sieve-template-dir-create:
  file.directory:
    - name: /etc/cyrus
    - user: root
    - group: root
    - mode: 0755

/etc/cyrus/default-sieve.script:
 file.managed:
  - source: salt://cyrus/default-sieve.script
  - mode: 644
  - user: root
  - group: root

libterm-readline-gnu-perl:
  pkg:
    - installed

libterm-readline-perl-perl:
  pkg:
    - installed
