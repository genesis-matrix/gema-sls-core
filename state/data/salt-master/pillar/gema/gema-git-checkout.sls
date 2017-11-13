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
##  Todo:
##    - [ ] move configs to pillar
##    - [ ] split ramdisk and git checkout into seperate state files
##    - [ ] improved cryptswap and ramdisk detection as a pre-req for pillar checkout
##    - [ ] add schedule stanza to periodically pull from pillar's git upstream repo
##


## <JINJA>
# pillar
{%- set uri_remote_repo = salt['pillar.get']('', 'https://github.com/genesis-matrix/genesis-plr-core.git') %}
{%- set uri_local_repo = salt['pillar.get']('', "/srv/pillar/.lookaside/gema-core-base") %}
{%- set uri_sshkey = salt['pillar.get']('') %}
{%- set branch = salt['pillar.get']('', 'master') %}
{%- set destructive_updates = salt['pillar.get']('', "True") %}
## </JINJA>



# update the git checkout 
"E05D89A7-F178-486A-B040-A0C30707D1EE":
  git.latest:
    - name: {{ uri_remote_repo }}
    - target: {{ uri_local_repo }}
    - rev: {{ branch }}
    {%- if uri_sshkey is defined %}
    - identity: {{ uri_sshkey }}
    {%- endif %}
    # normal stuff
    - force_fetch: True
    # ruff stuff
    - force_clone:    {{ destructive_updates }}
    - force_reset:    {{ destructive_updates }}
    - force_checkout: {{ destructive_updates }}
    - force_fetch:    {{ destructive_updates }}



#
"4376B564-7EAD-4A91-BF6D-7AD109AB3850":
  file.symlink:
    - name: /srv/pillar/base
    - target: {{ uri_local_repo }}



## EOF
