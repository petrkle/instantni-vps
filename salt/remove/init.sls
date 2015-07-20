{% for package in pillar.remove %}
{{package}}:
  pkg:
    - removed
{% endfor %}
