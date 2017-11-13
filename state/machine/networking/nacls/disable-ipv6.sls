##
##

"4bea0be5-14f0-456b-857a-204922eaa5c0":
  sysctl.present:
    - name: "net.ipv6.conf.all.disable_ipv6"
    - value: 1


"073be097-2052-46fa-8eb4-0d40217bec6f":
  sysctl.present:
    - name: "net.ipv6.conf.default.disable_ipv6"
    - value: 1


"a710d7d4-fb6f-4d68-9d39-dbff3b69b2be":
  sysctl.present:
    - name: "net.ipv6.conf.lo.disable_ipv6"
    - value: 1


"f3c0607d-c904-48da-880f-9ee08dc5a1ac":
  file.append:
    - name: /etc/modprobe.d/blacklist.conf
    - text:
      - "# Disable IPv6"
      - "blacklist ipv6"
      - "install ipv6 /bin/true"
