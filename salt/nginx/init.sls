nginx-repo:
  pkgrepo.managed:
    - humanname: nginx
    - name: deb http://nginx.org/packages/mainline/debian/ jessie nginx
    - file: /etc/apt/sources.list.d/nginx.list
    - key_url: salt://nginx/nginx_signing.key

user-nginx:
  user.present:
    - name: nginx
    - fullname: nginx
    - shell: /bin/true
    - home: /dev/null
    - createhome: False
    - optional_groups:
      - www-data

nginx:
  pkg.installed:
    - name: nginx
  service.running:
    - name: nginx
    - enable: True
    - watch:
{% for website in pillar.nginx_confs %}
       - file: /etc/nginx/conf.d/{{ website }}.conf
{% endfor %}

/usr/share/nginx/html/index.html:
 file.managed:
  - source: salt://nginx/index.html
  - mode: 644
  - user: root
  - group: root
  - makedirs: True

/usr/share/nginx/html/50x.html:
 file.managed:
  - source: salt://nginx/50x.html
  - mode: 644
  - user: root
  - group: root
  - makedirs: True

/etc/nginx/nginx.conf:
 file.managed:
  - source: salt://nginx/nginx.conf
  - mode: 644
  - user: root
  - group: root
  - watch_in:
      - service: nginx

/etc/nginx/conf.d/default.conf:
 file.absent

/etc/nginx/conf.d/example_ssl.conf:
 file.absent

/etc/cert/dhparams.pem:
 file.managed:
  - source: salt://nginx/dhparams.pem
  - mode: 644 
  - user: root
  - group: root
  - watch_in:
      - service: nginx   

{% for user, args in pillar['http_auth_users'].iteritems() %}                                                                     

nginx-http-auth-{{ user }}:
  cmd.run:
    - name: 'touch /etc/nginx/htpasswd.{{ user }}'
    - unless: 'test -f /etc/nginx/htpasswd.{{ user }}'

http-auth-{{ user }}:
  cmd.run:
    - name: 'htpasswd -s -b /etc/nginx/htpasswd.{{ user }} {{ user }} {{ args['pass'] }}'
    - unless: 'cat /etc/nginx/htpasswd.{{ user }} | grep "^`htpasswd -s -b -n {{ user }} {{ args['pass'] }} | head -1`" > /dev/null'

{% endfor %}

{% for website in pillar.nginx_confs %}

/etc/nginx/conf.d/{{ website }}.conf:
 file.managed:
  - source: salt://nginx/{{ website }}.conf
  - mode: 644 
  - user: root
  - group: root
  - template: jinja
  - makedirs: True

{% endfor %}
