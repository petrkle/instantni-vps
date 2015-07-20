roundcube-dir-create:
  file.directory:
    - name: /home/www/roundcube
    - user: www-data
    - group: www-data
    - mode: 0755

roundcube-mail:
  archive.extracted:
    - name: /home/www/roundcube
    - source: https://github.com/roundcube/roundcubemail/releases/download/{{ pillar.roundcube.version }}/roundcubemail-{{ pillar.roundcube.version }}.tar.gz
    - source_hash: md5={{ pillar.roundcube.md5 }}
    - tar_options: --ungzip --same-owner
    - archive_format: tar
    - if_missing: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}
    - require:
      - file: /home/www/roundcube

/home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/config/config.inc.php:
 file.managed:
  - source: salt://roundcube/config.inc.php
  - mode: 644
  - template: jinja
  - user: www-data
  - group: www-data
  - makedirs: True

chown-roundcube-recursive:
  cmd.run:
    - name: chown -R www-data.www-data /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}
    - unless: test `stat -c '%U' /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/` = www-data

rcm-delete-installer:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/installer

rcm-delete-readme:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/README.md

rcm-delete-changelog:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/CHANGELOG

rcm-delete-install:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/INSTALL

rcm-delete-license:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/LICENSE

rcm-delete-dockerfile:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/Dockerfile

rcm-delete-composer-dist:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/composer.json-dist

rcm-delete-upgrading:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/UPGRADING

rcm-delete-config-sample:
 file.absent:
  - name: /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/config/config.inc.php.sample

db-dir-dir-create:
  file.directory:
    - name: /usr/share/nginx
    - user: www-data
    - group: www-data
    - mode: 0755

create-default-roundcube-db:
  cmd.run:
    - user: www-data
    - group: www-data
    - name: sqlite3 /usr/share/nginx/roundcubemail.db < /home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/SQL/sqlite.initial.sql
    - unless: test -f /usr/share/nginx/roundcubemail.db

/home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/skins/larry/images/favicon.ico:
 file.managed:
  - source: salt://roundcube/favicon.ico
  - mode: 644
  - user: www-data
  - group: www-data
  - makedirs: True

/home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/skins/larry/images/roundcube_logo.png:
 file.managed:
  - source: salt://roundcube/roundcube_logo.png
  - mode: 644
  - user: www-data
  - group: www-data
  - makedirs: True

/home/www/roundcube/roundcubemail-{{ pillar.roundcube.version }}/skins/larry/images/watermark.jpg:
 file.managed:
  - source: salt://roundcube/watermark.jpg
  - mode: 644
  - user: www-data
  - group: www-data
  - makedirs: True
