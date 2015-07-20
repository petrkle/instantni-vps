screen:                                                                                                                            
  pkg:
    - installed

/home/{{ pillar.admin_user }}/.screenrc:
 file.managed:
  - source: salt://screen/screenrc
  - mode: 644
  - user: {{ pillar.admin_user }}
  - group: users
