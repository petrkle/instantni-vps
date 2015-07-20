vim-nox:                                                                                                                           
  pkg:
    - installed

/home/{{ pillar.admin_user }}/.vimrc:
 file.managed:
  - source: salt://vim/vimrc
  - mode: 644 
  - user: {{ pillar.admin_user }}
  - group: users

/root/.vimrc:
 file.managed:
  - source: salt://vim/vimrc
  - mode: 644 
  - user: root
  - group: root

vim-dir-create:
  file.directory:
    - name: /home/{{ pillar.admin_user }}/tmp
    - user: {{ pillar.admin_user }}
    - group: users
    - mode: 0755

vim-rtmp-create:
  file.directory:
    - name: /root/tmp
    - user: root
    - group: root
    - mode: 0755
