# vim: ft=yaml
# Custom Pillar Data for dnsmasq

dnsmasq:
  enabled: true
  configs:
    # This is the file that will be created: /etc/dnsmasq.d/hypervisior
    hypervisior:
      # Globals go at the top of the file
      globals:
        comments: 
          - 'My Hypervisior Booter'
          - 'Hope it works!'
        data:
          - 'interface=eth0'
          - 'domain=example.com'
          - 'enable-tftp'
          - 'tftp-root=/srv'
          - 'dhcp-lease-max=254'
          - 'log-dhcp'
      # This value is just for reference
      kill_ipmi:
        # comments go first are are preceeded by a #
        # we do it this way so we can more closely match what already exists in prod
        comments:
          - 'KILL IPMI'
          - '(They all ask as udhcp 0.9.9-pre or udhcp 1.12.0)'
        # data values go next and are written out as is
        data: 
          - 'dhcp-vendorclass=ipmi,udhcp 0.9.9-pre'
          - 'dhcp-vendorclass=ipmi,udhcp 1.12.0'
          - 'dhcp-ignore=ipmi'
      match_by_mac:
        comments:
          - 'For the initial boot, we match by MAC'
          - 'If we need to, we could also match PXEClient here (but many things use that)'
        data:
          - 'dhcp-host=00:30:48:*:*:*,net:pxe'
          - 'dhcp-host=00:25:90:*:*:*,net:pxe'
          - 'dhcp-host=A0:36:9F:*:*:*,net:pxe'
          - 'dhcp-host=0C:C4:7A:*:*:*,net:pxe'
          - 'dhcp-option=3,192.168.101.1'
          - 'dhcp-range=net:pxe,192.168.102.1,192.168.102.254,255.255.0.0,192.168.255.255,2d'
          - 'dhcp-boot=net:pxe,pxelinux.0'
      ignore_examples:
        comments:
          - 'Make sure we ignore examples' 
        data:
          - 'dhcp-host=fe:fd:*:*:*:*,net:examples'
          - 'dhcp-ignore=examples'


