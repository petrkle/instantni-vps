/home/www/autoconfig/mail/config-v1.1.xml:
 file.managed:
  - source: salt://autoconfig/autoconfig.xml
  - mode: 644 
  - template: jinja
  - user: www-data
  - group: www-data
  - makedirs: True
