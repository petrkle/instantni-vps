/home/{{ pillar.admin_user }}/.bashrc:
 file.managed:
  - source: salt://bash/bashrc
  - template: jinja
  - context:
      root: NO
  - mode: 644 
  - user: {{ pillar.admin_user }}
  - group: users

/home/{{ pillar.admin_user }}/.bash_profile:
 file.managed:
  - source: salt://bash/bash_profile
  - mode: 644
  - user: {{ pillar.admin_user }}
  - group: users

/root/.bashrc:
 file.managed:
  - source: salt://bash/bashrc
  - mode: 644
  - template: jinja
  - context:
      root: OK
  - user: root
  - group: root

/root/.bash_profile:
 file.managed:
  - source: salt://bash/bash_profile
  - mode: 644
  - user: root
  - group: root
