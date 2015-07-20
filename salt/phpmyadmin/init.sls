phpmyadmin-dir-create:
  file.directory:
    - name: /home/www/phpmyadmin
    - user: www-data
    - group: www-data
    - mode: 0755

phpmyadmin:
  archive.extracted:
    - name: /home/www/phpmyadmin
    - source: https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_{{ pillar.phpmyadmin.version }}.tar.gz
    - source_hash: md5={{ pillar.phpmyadmin.md5 }}
    - tar_options: --ungzip --same-owner
    - archive_format: tar
    - if_missing: /home/www/phpmyadmin/phpmyadmin-RELEASE_{{ pillar.phpmyadmin.version }}
    - require:
      - file: /home/www/phpmyadmin

chown-phpmyadmin-recursive:
  cmd.run:
    - name: chown -R www-data.www-data /home/www/phpmyadmin/phpmyadmin-RELEASE_{{ pillar.phpmyadmin.version }}
    - unless: test `stat -c '%U' /home/www/phpmyadmin/phpmyadmin-RELEASE_{{ pillar.phpmyadmin.version }}` = www-data

/etc/nginx/conf.d/phpmyadmin.conf:
 file.managed:
  - source: salt://nginx/phpmyadmin.conf
  - mode: 644 
  - user: root
  - group: root
  - template: jinja
  - makedirs: True
  - watch_in:
      - service: nginx
      - service: php5-fpm
