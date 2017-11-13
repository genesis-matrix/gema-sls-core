##
##
##



## Jinja
{% set uri_remote_repo = salt['pillar.get']('', 'ssh://git@github.com/genesis-matrix/genesis-pki-example.git') %}
{% set uri_local_repo = salt['pillar.get']('','/etc/salt/pki') %}
{% set uri_sshkey = salt['pillar.get']('', '/vagrant/tmp/sshkey_genesis_pki') %}
{% set id = salt['pillar.get']('', salt['grains.get']('id')) %}
{% set branch = salt['pillar.get']('', id) %}
{% set destructive_updates = salt['pillar.get']('', "True") %}



#
"A3093E86-83E8-4799-A843-658350FDA3F6":
  file.directory:
    - name: {{ uri_local_repo }}



# check out
"E05D89A7-F178-486A-B040-A0C30707D1EE":
  git.latest:
    - name: {{ uri_remote_repo }}
    - target: {{ uri_local_repo }}
    - rev: {{ branch }}
    - identity: {{ uri_sshkey }}
    # normal stuff
    - force_fetch: True
    # ruff stuff
    - force_clone:    {{ destructive_updates }}
    - force_reset:    {{ destructive_updates }}
    - force_checkout: {{ destructive_updates }}
    - force_fetch:    {{ destructive_updates }}



