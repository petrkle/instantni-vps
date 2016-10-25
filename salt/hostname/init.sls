/etc/hostname:
 file.managed:
  - source: salt://hostname/hostname
  - template: jinja
  - mode: 644
  - user: root
  - group: root

hostname-change:
  cmd.script:
    - name: /etc/init.d/hostname.sh
    - runas: root
    - shell: /bin/bash
    - unless: '[ "`uname -n`" = "{{ pillar.hostname }}" ]'
