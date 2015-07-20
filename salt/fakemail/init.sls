{% if grains['testmachine'] == 'OK' %}

fakemail-group:
  group.present:
    - name: fakemail
    - gid: 300

fakemail-user:
  user.present:
    - name: fakemail
    - fullname: Fakemail
    - shell: /bin/false
    - home: {{ pillar.fakemail['home'] }}
    - uid: 300
    - gid: 300
    - groups:
      - fakemail

fakemail-home-dir-create:
  file.directory:
    - name: {{ pillar.fakemail['home'] }}
    - user: fakemail
    - group: www-data
    - mode: 0775

/usr/bin/fakemail:
 file.managed:
  - source: salt://fakemail/fakemail
  - mode: 755
  - user: root
  - group: root

/usr/local/bin/fakemail.pl:
 file.managed:
  - source: salt://fakemail/fakemail.pl
  - mode: 755
  - user: root
  - group: root

/etc/init.d/fakemail:
 file.managed:
  - source: salt://fakemail/fakemail-init
  - template: jinja
  - mode: 755
  - user: root
  - group: root

fakemail:
 cmd.run:
  - name: update-rc.d fakemail defaults ; /etc/init.d/fakemail start
  - cwd: /etc/init.d
  - user: root
  - group: root
  - unless: service fakemail
  - require:
     - file: /etc/init.d/fakemail
     - file: /usr/bin/fakemail
     - user: fakemail
     - group: fakemail
 service.running:
  - name: fakemail
  - enable: True

{% endif %}
