https://github.com/gothfox/Tiny-Tiny-RSS.git:
  git.latest:
    - target: /home/www/ttrss

/home/www/ttrss/config.php:
 file.managed:
  - source: salt://ttrss/config.php
  - mode: 644 
  - user: www-data
  - group: www-data
  - template: jinja

chown-ttrss-recursive:
  cmd.run:
    - name: chown -R www-data.www-data /home/www/ttrss
    - unless: test `stat -c '%U' /home/www/ttrss/index.php` = www-data

ttrss_db:
  mysql_database.present:
    - name: ttrss
  mysql_user.present:
    - name: ttrss
    - password: {{ pillar.mysql.ttrss_password }}
  mysql_grants.present:
    - database: ttrss.*
    - grant: ALL PRIVILEGES
    - user: ttrss
  require:
    - service: mysql

ttrss-db-schem:
  cmd.run:
    - name: mysql ttrss < /home/www/ttrss/schema/ttrss_schema_mysql.sql
    - unless: test `echo 'show tables;' | mysql ttrss | wc -l` -gt 0
    - cwd: /root/
