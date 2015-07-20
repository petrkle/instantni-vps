postfix:
  pkg.installed:
    - name: postfix
  service.running:
    - name: postfix
    - enable: True
    - reload: True

postfix-pcre:
  pkg:
    - installed

/etc/mailname:
 file.managed:
  - source: salt://postfix/mailname
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: postfix

/etc/postfix/main.cf:
 file.managed:
  - source: salt://postfix/main.cf
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - require:
     - file: cert-dir-create
  - watch_in:
      - service: postfix

/etc/postfix/master.cf:
 file.managed:
  - source: salt://postfix/master.cf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: postfix

/etc/postfix/virtual:
 file.managed:
  - source: salt://postfix/virtual
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: postfix

/etc/postfix/require-auth-domains:
 file.managed:
  - source: salt://postfix/require-auth-domains
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: postfix

/etc/postfix/domains:
 file.managed:
  - source: salt://postfix/domains
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: postfix

/etc/postfix/rbl-whitelist:
 file.managed:
  - source: salt://postfix/rbl-whitelist
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: postfix

/etc/postfix/mailboxes:
 file.managed:
  - source: salt://postfix/mailboxes
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: postfix

/etc/postfix/sasl-senders:
 file.managed:
  - source: salt://postfix/sasl-senders
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: postfix

/etc/postfix/transport:
 file.managed:
  - source: salt://postfix/transport
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: postfix

/etc/postfix/sasl/smtpd.conf:
 file.managed:
  - source: salt://postfix/smtpd.conf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: postfix

/etc/postfix/mime_header_checks:
 file.managed:
  - source: salt://postfix/mime_header_checks
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: postfix

/etc/postfix/header_checks:
 file.managed:
  - source: salt://postfix/header_checks
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: postfix

run-postmap-virtual:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/virtual
    - cwd: /etc/postfix
    - user: root
    - watch:
      - file: /etc/postfix/virtual
    - watch_in:
      - service: postfix

run-postmap-mailboxes:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/mailboxes
    - cwd: /etc/postfix
    - user: root
    - watch:
      - file: /etc/postfix/mailboxes
    - watch_in:
      - service: postfix

run-postmap-domains:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/domains
    - user: root
    - cwd: /etc/postfix
    - watch:
      - file: /etc/postfix/domains
    - watch_in:
      - service: postfix

run-postmap-transport:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/transport
    - user: root
    - cwd: /etc/postfix
    - watch:
      - file: /etc/postfix/transport
    - watch_in:
      - service: postfix

run-postmap-rbl-whitelis:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/rbl-whitelist
    - user: root
    - cwd: /etc/postfix
    - watch:
      - file: /etc/postfix/rbl-whitelist
    - watch_in:
      - service: postfix

run-postmap-sasl-senders:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/sasl-senders
    - cwd: /etc/postfix
    - user: root
    - watch:
      - file: /etc/postfix/sasl-senders
    - watch_in:
      - service: postfix

run-postmap-require-auth-domains:
  cmd.wait:
    - name: /usr/sbin/postmap /etc/postfix/require-auth-domains
    - cwd: /etc/postfix
    - user: root
    - watch:
      - file: /etc/postfix/require-auth-domains
    - watch_in:
      - service: postfix

/usr/local/bin/pfdel:
 file.managed:
  - source: salt://postfix/pfdel
  - mode: 700
  - user: root
  - group: root
