/etc/nginx/conf.d/autoconfig.conf:                                                                                         
 file.managed:
  - source: salt://nginx/autoconfig.conf
  - mode: 644 
  - user: root
  - group: root
  - template: jinja
  - watch_in:
      - service: nginx

/home/www/autoconfig/mail/config-v1.1.xml:
 file.managed:
  - source: salt://autoconfig/autoconfig.xml
  - mode: 644 
  - template: jinja
  - user: www-data
  - group: www-data
  - makedirs: True
