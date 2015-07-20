/usr/local/bin/cb.pl:
 file.managed:
  - source: salt://sasl/cb.pl
  - template: jinja
  - mode: 700
  - user: root
  - group: root
  - reqiure:
     - pkg: cyrus-imapd
     - pkg: sasl2-bin

{% for mailbox, args in pillar['mailboxes'].iteritems() %}

create-mailbox-{{ mailbox }}:
  cmd.run:
    - name: '/usr/local/bin/cb.pl -m {{ args['mailbox']}}'
    - unless: 'sasldblistusers2 | grep {{ args['mailbox']}}'
    - require:
      - file: /usr/local/bin/cb.pl
      - service: cyrus-imapd
      - service: saslauthd

passwd-{{ mailbox}}:
  cmd.run:
    - name: 'echo {{ args['password']}} | saslpasswd2 -pc {{ args['mailbox']}}'
    - unless: 'sasldblistusers2 | grep {{ args['mailbox']}}'
    - require:
      - service: saslauthd

{% endfor %}
