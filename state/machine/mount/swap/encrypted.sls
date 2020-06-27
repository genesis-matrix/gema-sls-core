##
##
##



##_META:
##  Applicability: salt-masters, possibly only at startup
##  Notes:
##    - The changes in this state are consequential about have the potential to break things on existing systems.
##    - Purpose: convert all active swapfs files and devices to use per-boot encryption to protect the secrets in the ramfs-backed /srv/pillar
##    - the crypttab setup for encrypted swap will take effect automaticaly after a reboot
##    - the lsblk command will show if swap is stacked and encrypted
##    - yum install cryptsetup
##  Commands a/o Snippets:
##    - list active swap mounts: >
##      lsblk -Pp | awk '/MOUNTPOINT="\[SWAP\]\"/{print(gensub("NAME=","","g",$1))}'
##  References:
##    - http://techdire.com/swapoff-cannot-allocate-memory/
##    - http://community.nethserver.org/t/flushing-the-swap/3247/2
##



## <JINJA>
# cryptswap
{%- set introspect_encrypted_swapdev_lst = salt['cmd.shell']('lsblk -Pp | grep \' TYPE=\"crypt\" \' 2>/dev/null | awk \'/MOUNTPOINT=\"\[SWAP\]\"/{print(gensub("\\\"","","g",gensub("NAME=","","g",$1)))}\'').split('\n')[:] %}
{%- set introspect_unencrypted_swapdev_lst = salt['cmd.shell']('lsblk -Pp | grep -v \' TYPE=\"crypt\" \' 2>/dev/null | awk \'/MOUNTPOINT=\"\[SWAP\]\"/{print(gensub("\\\"","","g",gensub("NAME=","","g",$1)))}\'').split('\n')[:] %}
{%- set uri_swapdev_lst = salt['pillar.get']('', introspect_unecrypted_swapdev_lst|default([])) %}
## </JINJA>



#
"18B5764C-A595-4E6D-B25D-3F883E42B81C":
  pkg.installed:
    - name: cryptsetup



# add crypttab entries for each swap
{%- if uri_swapdev_lst is defined %}
{%- for uri_swapdev in uri_swapdev_lst %}
"753AFBED-A547-49DC-8ADA-146629A35760--{{ uri_swapdev }}":
  file.append:
    - name: "/etc/crypttab"
    - text: |
        # <name>  <device>     <password>     <options>
        cryptswap{{ loop.index0 }}       {{ uri_swapdev }}    /dev/urandom   swap
{%- endfor %}
{%- endif %}



# for all swap in list, if active, deactivate swap
{%- if uri_swapdev_lst is defined %}
{%- for uri_swapdev in uri_swapdev_lst %}
"155B0BBB-725B-424C-8836-658D45B73123--{{ uri_swapdev }}":
  cmd.run:
    - name: swapoff {{ uri_swapdev }}
    #- onlyif: "lsblk | grep {{ uri_swapdev.split('/')[:-1] }}"
    #- failhard: True
    - require:
      - mount: "D2210167-0383-463A-9AD9-6B0207041C4D--{{ uri_swapdev }}"
{%- endfor %}
{%- endif %}



#
{%- if uri_swapdev_lst is defined %}
{%- for uri_swapdev in uri_swapdev_lst %}
"013ECBEB-34D5-4304-AD4B-ADE9F1DC3400--{{ uri_swapdev }}":
  cmd.run:
    - name: 'sync; echo 3 > /proc/sys/vm/drop_caches && sleep 5 && swapoff {{ uri_swapdev }}'
    - onfail:
      - cmd: "155B0BBB-725B-424C-8836-658D45B73123--{{ uri_swapdev }}"
{%- endfor %}
{%- endif %}



# unmount existing swap
{%- if uri_swapdev_lst is defined %}
{%- for uri_swapdev in uri_swapdev_lst %}
"D2210167-0383-463A-9AD9-6B0207041C4D--{{ uri_swapdev }}":
  mount.unmounted:
    - name: ""
    - device: {{ uri_swapdev }}
    - persist: True
{%- endfor %}
{%- endif %}



# immediately create encrypted volume, if it doesn't already exist. Alternatively will also happen automatically during next boot-up
{%- if uri_swapdev_lst is defined %}
{%- for uri_swapdev in uri_swapdev_lst %}
"F705F4AB-EEA5-4698-BEA2-6D4334EC8C75--{{ uri_swapdev }}":
  cmd.run:
    # create encrypted stacked device
    - name: cryptsetup --key-file /dev/urandom create cryptswap{{ loop.index0 }} {{ uri_swapdev }} && mkswap /dev/mapper/cryptswap{{ loop.index0 }}
    - unless: lsblk | grep cryptswap{{ loop.index0 }}
    - failhard: True
    - onchanges:
      - "753AFBED-A547-49DC-8ADA-146629A35760--{{ uri_swapdev }}"
{%- endfor %}
{%- endif %}



# setup swap w/ re-initialized encryption on boot, adds security but breaks suspend-to-disk
{%- if uri_swapdev_lst is defined %}
{%- for uri_swapdev in uri_swapdev_lst %}
"AFF3D911-1056-4B7E-B09D-C9939C286195--{{ uri_swapdev }}":
  mount.swap:
    - name: /dev/mapper/cryptswap{{ loop.index0 }}
    - persist: True
{%- endfor %}
{%- endif %}



## EOF
