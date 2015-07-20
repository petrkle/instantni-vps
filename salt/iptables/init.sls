firewall:
 cmd.run:
  - name: 'update-rc.d firewall defaults && /etc/init.d/firewall start'
  - cwd: /etc/init.d
  - user: root
  - group: root
  - unless: 'service firewall'
  - require:
     - file: /etc/init.d/firewall
 service.running:
  - name: firewall
  - enable: True

/etc/init.d/firewall:
 file.managed:
  - source: salt://iptables/firewall
  - mode: 755 
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: firewall
