detox:
  pkg:
    - installed

/home/{{ pillar.admin_user }}/.detoxrc:
 file.managed:
  - source: salt://detox/detoxrc
  - mode: 644
  - user: {{ pillar.admin_user }}
  - group: users
