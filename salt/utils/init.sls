install-my-utils-pkg:
  pkg:
    - installed
    - names:
{% for package in pillar.utils %}
       - {{package}}
{% endfor %}
