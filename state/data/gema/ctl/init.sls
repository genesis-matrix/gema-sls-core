##
##
##



##_META:
##  - Applicability: Salt masters of the GeMa project
##  - Purpose: Clones the 'genesis-ctl' repo for use w/ submodule tracking
##



## <JINJA>
{% set uri_git_upstream = salt['pillar.get']('', "https://github.com/genesis-matrix/genesis-ctl.git") %}
{% set uri_git_clonedir = salt['pillar.get']('', "/var/cache/genesis-matrix/ctl.git") %}
{% set uri_sshkey = salt['pillar.get']('', '/vagrant/tmp/sshkey_genesis_pki') %}
{% set id = salt['pillar.get']('', salt['grains.get']('id')) %}
{% set branch = salt['pillar.get']('', id) %}
{% set destructive_updates = salt['pillar.get']('', "True") %}
## </JINJA>



#
"6CA2E412-B63B-4C8A-95CC-623A58263DC8":
  test.check_pillar:
    - present:
      - 'gema:lookup:ctl:uri_git_upstream'
    - failhard: True



#
"F95D978D-9445-4204-95EE-D01347413E8A":
  file.directory:
    - name: "{{ uri_git_clonedir }}"
    - require:
      - "F79AEA8C-FFE9-4A0F-B0EE-9B7FA0504720"



#
"F79AEA8C-FFE9-4A0F-B0EE-9B7FA0504720":
  git.latest:
    - name: "{{ uri_git_upstream }}"
    - target: "{{ uri_git_clonedir }}"
    - rev: "{{ branch }}"
    - identity: "{{ uri_sshkey }}"
    # normal stuff
    - force_fetch: True
    # ruff stuff
    - force_clone:    {{ destructive_updates }}
    - force_reset:    {{ destructive_updates }}
    - force_checkout: {{ destructive_updates }}
    - force_fetch:    {{ destructive_updates }}



## EOF