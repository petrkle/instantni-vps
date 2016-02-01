/etc/apt/sources.list.d/dotdeb.list:
 file.managed:
  - source: salt://php/dotdeb.list
  - mode: 644
  - user: root
  - group: root

dotdeb-keys:
  cmd.script:
    - source: salt://php/dotdeb-key.sh
    - user: root
    - group: root
    - shell: /bin/bash
    - unless: 'apt-key list | grep 89DF5277'

php-home-www-dir-create:
  file.directory:
    - name: /home/www/
    - user: www-data
    - group: www-data
    - mode: 0755
    - makedirs: True

remove-php5-pkgs:
  pkg:
    - removed
    - names:
        - php5-curl
        - php5-cli
        - php5-gd
        - php5-mcrypt
        - php5-mysql
        - php5-intl
        - php5-sqlite
        - php5-common
        - php5-json

/etc/init.d/php5-fpm:
 file.absent

php70-fpm:
  pkg.installed:
    - name: php7.0-fpm
  service.running:
    - name: php7.0-fpm
    - enable: True
    - watch:
       - file: /etc/php/7.0/fpm/php-fpm.conf
       - file: /etc/php/7.0/fpm/php.ini
{% for pool, args in pillar['fpm_pools'].iteritems() %}
       - file: /etc/php/7.0/fpm/pool.d/{{ pool }}.conf
{% endfor %}
{% for website in pillar.nginx_confs %}
       - file: /etc/nginx/conf.d/{{ website }}.conf
{% endfor %}

install-php-pkgs:
  pkg:
    - installed
    - names:
        - php7.0-common
        - php7.0-curl
        - php7.0-cli
        - php7.0-gd
        - php7.0-mysql
        - php7.0-intl
        - php7.0-sqlite3
        - php7.0-json
        - php7.0-mcrypt

{% for pool, args in pillar['fpm_pools'].iteritems() %}

/etc/php/7.0/fpm/pool.d/{{ pool }}.conf:
 file.managed:
  - source: salt://php/{{ pool }}.conf
  - template: jinja
  - context:
     poolname: {{ pool }}
     portnumber: {{ args.port }}
  - mode: 644
  - user: root
  - group: root

php-sessions-dir-{{ pool }}:
  cmd.run:
    - name: 'mod_files.sh /var/lib/php/sessions/{{ pool }} 2 5 && chown -R www-data.www-data /var/lib/php/sessions/{{ pool }}'
    - unless: 'test -d /var/lib/php/sessions/{{ pool }}'
    - require:
      - file: /usr/local/bin/mod_files.sh

php-home-dir-{{ pool }}-create:
  file.directory:
    - name: /home/www/{{ pool }}
    - user: www-data
    - group: www-data
    - mode: 0755
    - makedirs: True
{% endfor %}

/usr/local/bin/mod_files.sh:
 file.managed:
  - source: salt://php/mod_files.sh
  - mode: 755
  - user: root
  - group: root

/usr/local/bin/phpsessionsclean.sh:
 file.managed:
  - source: salt://php/phpsessionsclean.sh
  - template: jinja
  - mode: 755
  - user: root
  - group: root

/etc/php/7.0/fpm/php-fpm.conf:
 file.managed:
  - source: salt://php/php-fpm.conf
  - mode: 644
  - user: root
  - group: root

/etc/php/7.0/fpm/php.ini:
 file.managed:
  - source: salt://php/php.ini
  - mode: 644
  - user: root
  - group: root
