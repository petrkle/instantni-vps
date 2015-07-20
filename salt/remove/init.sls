remove-my-utils-pkg:
  pkg:
    - removed
    - names:
{% for package in pillar.remove %}
       - {{package}}
{% endfor %}
