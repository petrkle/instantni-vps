group-sudo-{{ pillar.admin_user }}:
  cmd.run:
    - name: usermod -a -G sudo {{ pillar.admin_user }}
    - unless: 'grep "^sudo:" /etc/group | grep {{ pillar.admin_user }}'

group-amavis-clamav:
  cmd.run:
    - name: usermod -a -G amavis clamav
    - unless: 'grep "^amavis:" /etc/group | grep clamav'
    - require:
      - pkg: amavisd-new
      - pkg: clamav-daemon

group-clamav-amavis:
  cmd.run:
    - name: usermod -a -G clamav amavis
    - unless: 'grep "^clamav:" /etc/group | grep amavis'
    - require:
      - pkg: amavisd-new
      - pkg: clamav-daemon

group-mail-cyrus:
  cmd.run:
    - name: usermod -a -G mail cyrus
    - unless: 'grep "^mail:" /etc/group | grep cyrus'
    - require:
      - service: cyrus-imapd
      - service: postfix

group-mail-postfix:
  cmd.run:
    - name: usermod -a -G mail postfix
    - unless: 'grep "^mail:" /etc/group | grep postfix'
    - require:
      - service: postfix
      - service: cyrus-imapd

group-sasl-cyrus:
  cmd.run:
    - name: usermod -a -G sasl cyrus
    - unless: 'grep "^sasl:" /etc/group | grep cyrus'
    - require:
      - service: cyrus-imapd
      - service: saslauthd

group-sasl-postfix:
  cmd.run:
    - name: usermod -a -G sasl postfix
    - unless: 'grep "^sasl:" /etc/group | grep postfix'
    - require:
      - service: saslauthd
      - service: postfix

group-sasl-www-data:
  cmd.run:
    - name: usermod -a -G sasl www-data
    - unless: 'grep "^sasl:" /etc/group | grep www-data'
    - require:
      - service: saslauthd
      - service: nginx
      - service: php7.0-fpm


group-postfix-cyrus:
  cmd.run:
    - name: usermod -a -G postfix cyrus
    - unless: 'grep "^postfix:" /etc/group | grep cyrus'
    - require:
      - service: postfix
      - service: cyrus-imapd

group-www-data-{{ pillar.admin_user }}:
  cmd.run:
    - name: usermod -a -G www-data {{ pillar.admin_user }}
    - unless: 'grep "^www-data:" /etc/group | grep {{ pillar.admin_user }}'

group-www-data-nginx:
  cmd.run:
    - name: usermod -a -G www-data nginx
    - unless: 'grep "^www-data:" /etc/group | grep nginx'
    - require:
      - service: nginx
