php5-fpm:
  pkg.installed:
    - name: php5-fpm
  service.running:
    - name: php5-fpm
    - enable: True

php5-curl:
  pkg:
    - installed

php5-cli:
  pkg:
    - installed

php5-gd:
  pkg:
    - installed

php5-mcrypt:
  pkg:
    - installed

php5-mysql:
  pkg:
    - installed

php-soap:
  pkg:
    - installed

php-xml-parser:
  pkg:
    - installed

php5-intl:
  pkg:
    - installed

php5-sqlite:
  pkg:
    - installed

php-home-www-dir-create:
  file.directory:
    - name: /home/www/
    - user: www-data
    - group: www-data
    - mode: 0755
    - makedirs: True

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
  - watch_in:
      - service: php5-fpm

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
    - watch_in:
      - service: php5-fpm
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
  - watch_in:
      - service: php5-fpm

/etc/php5/fpm/php.ini:
 file.managed:
  - source: salt://php/php.ini
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: php5-fpm

