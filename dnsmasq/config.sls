# vim: ft=sls
# How to configure dnsmasq
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

# all the configurations go into the /etc/dnsmasq.d/*.conf files
{% if dnsmasq.configs is defined -%}
{%   for config_name, config in dnsmasq.configs.iteritems() %}
dnsmasq_config_{{ config_name }}:
  file.managed:
    - name: '/etc/dnsmasq.d/{{ config_name }}.conf'
    - source: 'salt://dnsmasq/files/config.conf.j2'
    - user: 'root'
    - group : 'root'
    - mode: 0644
    - template: jinja
    - config: {{ config }}
    - watch_in:
        - service: dnsmasq_service
{%   endfor %} 
{%- endif %}
