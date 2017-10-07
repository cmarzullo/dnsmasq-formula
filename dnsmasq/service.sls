# vim: ft=sls
# Manage service for service dnsmasq
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

dnsmasq_service:
  service.{{ dnsmasq.service.state }}:
    - name: {{ dnsmasq.service.name }}
    - enable: {{ dnsmasq.service.enable }}
