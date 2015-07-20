https://github.com/petrkle/html5-sablona.git:
  git.latest:
    - target: /home/www/www

/etc/nginx/conf.d/staticsite.conf:
 file.managed:
  - source: salt://nginx/staticsite.conf
  - mode: 644 
  - user: root
  - group: root
  - template: jinja
  - makedirs: True
  - watch_in:
      - service: nginx
      - service: php5-fpm
