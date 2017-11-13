##
##
##



##_META:
##  Applicability: machines w/ role of salt-master, possibly only at startup
##  Notes:
##    - The changes in this state are consequential about have the potential to break things on existing systems.
##    - Purpose: convert all active swapfs files and devices to use per-boot encryption to protect the secrets in the ramfs-backed /srv/pillar 
##    - the crypttab setup for encrypted swap will take effect automaticaly after a reboot
##    - the lsblk command will show if swap is stacked and encrypted
##    - yum install cryptsetup



## <JINJA>
# tmpfs ramdisk
{%- set force_immediate_mount = salt['pillar.get']('', False) %}
{%- set uri_ramdisk_mount = salt['pillar.get']('','/srv/pillar') %}
{%- set cmd_introspect_ramsize_kb_count = salt['cmd.shell']('awk \'/^MemTotal:/{print($2)}\' /proc/meminfo')|int %}
{%- set opt_ramdisk_allocation_percent = 10 %}
{%- set opt_ramdisk_size = salt['pillar.get']('', + (cmd_introspect_ramsize_kb_count / opt_ramdisk_allocation_percent )|round|int|string + "k") %}
## </JINJA>



# mount volatile in-memory filesystem
"BE4C9815-D769-40C1-8AA3-9AAD04544572":
  mount.mounted:
    - name: "{{ uri_ramdisk_mount }}"
    - device: none
    # pages may be written to swap
    - fstype: tmpfs
    - mount: {{ force_immediate_mount }}
    # default size=50%
    - opts: "noatime,nodiratime,mode=700,noexec,nosuid,nouser,size={{ opt_ramdisk_size }}"
    - mkmnt: True
    - persist: True



## EOF