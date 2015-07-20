{% for package in pillar.utils %}
{{package}}:
  pkg.installed:
    - name: {{package}}
    - install_recommends: False
{% endfor %}
