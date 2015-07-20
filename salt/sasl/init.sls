saslauthd:
  pkg.installed:
    - name: sasl2-bin
  service.running:
    - name: saslauthd
    - enable: True

/etc/default/saslauthd:
 file.managed:
  - source: salt://sasl/saslauthd.default
  - mode: 644 
  - user: root
  - group: root
  - watch_in:
      - service: saslauthd


{%  for foo in pillar.maildomains %}
passwd-cyrus-{{ foo }}:
  cmd.run:
    - name: 'echo {{ pillar.cyruspass }} | saslpasswd2 -pc cyrus@{{ foo }}'
    - unless: 'sasldblistusers2 | grep cyrus@{{ foo }}'
    - require:
      - service: saslauthd
{%  endfor  %}
