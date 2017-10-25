mysql:
  pkg.installed:
    - name: mariadb-server

mysqlpython:
  pkg.installed:
    - name: python-mysqldb

myql-server:
  service:
    - running
    - name: mysql
    - enable: True
    - require:
      - pkg: mariadb-server
      - pkg: python-mysqldb
  mysql_user:
    - present
    - name: root
    - password: {{ pillar.mysql.root_password }}
    - require:
      - service: mysql

/root/.my.cnf:
 file.managed:
  - source: salt://mysql/my.cnf
  - template: jinja
  - mode: 600 
  - user: root
  - group: root
