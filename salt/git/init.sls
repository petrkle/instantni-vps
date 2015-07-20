/home/{{ pillar.admin_user }}/.gitconfig:
 file.managed:
  - source: salt://git/gitconfig
  - mode: 644 
  - user: {{ pillar.admin_user }}
  - group: users
  - template: jinja
