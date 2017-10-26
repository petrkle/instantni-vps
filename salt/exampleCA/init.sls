/etc/ssl/certs/exampleCA.pem:
 file.managed:
  - source: salt://exampleCA/exampleCA.pem
  - mode: 644
  - user: root
  - group: root

run-c_rehash:
  cmd.wait:
    - name: c_rehash
    - runas: root
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

/etc/cert/example.cz.pem:
 file.managed:
  - source: salt://exampleCA/example.cz.pem
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/example.cz.key:
 file.managed:
  - source: salt://exampleCA/example.cz.key
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/star.example.cz.pem:
 file.managed:
  - source: salt://exampleCA/star.example.cz.pem
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/star.example.cz.key:
 file.managed:
  - source: salt://exampleCA/star.example.cz.key
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

{% else %}

/etc/cert/example.com.pem:
 file.managed:
  - source: salt://exampleCA/example.com.pem
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/example.com.key:
 file.managed:
  - source: salt://exampleCA/example.com.key
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/star.example.com.pem:
 file.managed:
  - source: salt://exampleCA/star.example.com.pem
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

/etc/cert/star.example.com.key:
 file.managed:
  - source: salt://exampleCA/star.example.com.key
  - mode: 644 
  - user: root
  - group: root
  - require:
     - file: cert-dir-create

{% endif %}
