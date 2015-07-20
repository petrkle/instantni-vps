php-home-www-dir-create:
  file.directory:
    - name: /home/www/
    - user: www-data
    - group: www-data
    - mode: 0755
    - makedirs: True

php5-fpm:
  pkg.installed:
    - name: php5-fpm
  service.running:
    - name: php5-fpm
    - enable: True
    - watch:
       - file: /etc/php5/fpm/php-fpm.conf
       - file: /etc/php5/fpm/php.ini
{% for pool, args in pillar['fpm_pools'].iteritems() %}
       - file: /etc/php5/fpm/pool.d/{{ pool }}.conf
{% endfor %}
{% for website in pillar.nginx_confs %}
       - file: /etc/nginx/conf.d/{{ website }}.conf
{% endfor %}

install-php5-pkgs:
  pkg:
    - installed
    - names:
        - php5-curl
        - php5-cli
        - php5-gd
        - php5-mcrypt
        - php5-mysql
        - php5-intl
        - php5-sqlite
        - php-soap
        - php-xml-parser

{% for pool, args in pillar['fpm_pools'].iteritems() %}

/etc/php5/fpm/pool.d/{{ pool }}.conf:
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
    - name: 'mod_files.sh /var/lib/php5/sessions/{{ pool }} 2 5 && chown -R www-data.www-data /var/lib/php5/sessions/{{ pool }}'
    - unless: 'test -d /var/lib/php5/sessions/{{ pool }}'
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

/etc/php5/fpm/php-fpm.conf:
 file.managed:
  - source: salt://php/php-fpm.conf
  - mode: 644
  - user: root
  - group: root

/etc/php5/fpm/php.ini:
 file.managed:
  - source: salt://php/php.ini
  - mode: 644
  - user: root
  - group: root
