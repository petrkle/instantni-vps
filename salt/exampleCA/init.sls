/etc/ssl/certs/exampleCA.pem:
 file.managed:
  - source: salt://exampleCA/cacert.pem
  - mode: 644
  - user: root
  - group: root

run-c_rehash:
  cmd.wait:
    - name: c_rehash
    - user: root
    - cwd: /etc/ssl/certs
    - watch:
      - file: /etc/ssl/certs/exampleCA.pem

cert-dir-create:
  file.directory:
    - name: /etc/cert
    - user: root
    - group: root
    - mode: 0755

{% if grains['testmachine'] == 'OK' %}

/etc/cert/example.pem:
 file.managed:
  - source: salt://exampleCA/example.cz.pem
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/example.key:
 file.managed:
  - source: salt://exampleCA/example.cz.key
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

{% else %}

/etc/cert/example.pem:
 file.managed:
  - source: salt://exampleCA/example.com.pem
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/example.key:
 file.managed:
  - source: salt://exampleCA/example.com.key
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

{% endif %}
