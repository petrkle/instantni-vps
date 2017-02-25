sury-php:
  pkgrepo.managed:
    - humanname: sury-php
    - name: deb https://packages.sury.org/php/ jessie main
    - file: /etc/apt/sources.list.d/sury-php.list
    - key_url: salt://php/sury.php.gpg

php-home-www-dir-create:
  file.directory:
    - name: /home/www/
    - user: www-data
    - group: www-data
    - mode: 0755
    - makedirs: True

php71-fpm:
  pkg.installed:
    - name: php7.1-fpm
  service.running:
    - name: php7.1-fpm
    - enable: True
    - watch:
       - file: /etc/php/7.1/fpm/php-fpm.conf
       - file: /etc/php/7.1/fpm/php.ini
{% for pool, args in pillar['fpm_pools'].iteritems() %}
       - file: /etc/php/7.1/fpm/pool.d/{{ pool }}.conf
{% endfor %}
{% for website in pillar.nginx_confs %}
       - file: /etc/nginx/conf.d/{{ website }}.conf
{% endfor %}

install-php-pkgs:
  pkg:
    - installed
    - names:
        - php7.1-common
        - php7.1-curl
        - php7.1-cli
        - php7.1-gd
        - php7.1-mysql
        - php7.1-intl
        - php7.1-sqlite3
        - php7.1-json
        - php7.1-mcrypt
        - php7.1-mbstring
        - php7.1-xml
        - php7.1-zip
        - php7.1-bz2

{% for pool, args in pillar['fpm_pools'].iteritems() %}

/etc/php/7.1/fpm/pool.d/{{ pool }}.conf:
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

/etc/php/7.1/fpm/php-fpm.conf:
 file.managed:
  - source: salt://php/php-fpm.conf
  - mode: 644
  - user: root
  - group: root

/etc/php/7.1/fpm/php.ini:
 file.managed:
  - source: salt://php/php.ini
  - mode: 644
  - user: root
  - group: root
