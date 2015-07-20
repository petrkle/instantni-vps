openssh-server:
  pkg:
    - installed

ssh:
  service.running:
    - name: ssh
    - enable: True

/etc/ssh/sshd_config:
 file.managed:
  - source: salt://ssh/sshd_config
  - mode: 644
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: ssh

/home/{{ pillar.admin_user }}/.ssh/config:
 file.managed:
  - source: salt://ssh/config
  - mode: 600
  - user: {{ pillar.admin_user }}
  - group: users

/home/{{ pillar.admin_user }}/.ssh/rc:
 file.managed:
  - source: salt://ssh/rc
  - mode: 700
  - user: {{ pillar.admin_user }}
  - group: users
