##
##
##



## Jinja
{% set tag = salt['pillar.get']('event_tag') %}
{% set data = salt['pillar.get']('event_data') %}
{% set stamp = salt['pillar.get']('event_stamp') %}
#
{% set id = salt['pillar.get']('', data['id']) %}
{% set branch = id %}
{% set from_branch = salt['pillar.get']('', 'master') %}
{% set uri_remote_repo = salt['pillar.get']('', 'ssh://git@github.com/genesis-matrix/genesis-pki-example.git') %}
{% set uri_local_repo = salt['pillar.get']('','/etc/salt/pki') %}
{% set uri_sshkey = salt['pillar.get']('', '/vagrant/tmp/sshkey_genesis_pki') %}
{% set uri_trigger = data['path'] %}
{% set msg_autocommit = "auto-commit:" + data['change'] + ":" + uri_trigger %}



## initial setup, create per-minion branch at upstream repo (should be phased out over time)
"E81B94BF-40F9-4208-922A-610CC027715F":
  cmd.run:
    - name: 'cd $(mktemp -d) && ssh-agent bash -c "ssh-add {{uri_sshkey}} && git clone --branch {{from_branch}} --depth 1 {{uri_remote_repo}} . && git push origin {{from_branch}}:{{branch}} "'
    - unless: "test -d /etc/salt/pki/.git && git --git-dir={{uri_local_repo}}/.git branch -r | grep -qsx '^  origin/{{branch}}$'"



# initial setup, insinuate repo into place, checkout min-configs like .gitignore, touch .gitkeep in empty dirs, add all, commit and push and pause some seconds before proceeding
"5A9DCDA4-AD8C-46E6-83F5-08249BEFF04E":
  cmd.run:
    - name: 'cd {{uri_local_repo}} && ssh-agent bash -c "ssh-add {{uri_sshkey}} && git clone --bare --branch {{branch}} --depth 1 {{uri_remote_repo}} .git && git config --local --bool core.bare false && git config user.email $(whoami|xargs -r)@{{branch}} && git reset --soft && git checkout --force HEAD -- .gitignore && find * -type d -empty -exec touch {}/.gitkeep \; && git add . && git commit -m setup-minionkey-branch && git push --set-upstream origin {{branch}}:{{branch}}" && sleep 15'
    - unless: "test -d /etc/salt/pki/.git && git --git-dir={{uri_local_repo}}/.git branch -r | grep -qsx '^  origin/{{branch}}$'"


    
##
"1D8D1CF2-7500-4600-AA2A-AE9DE9C2511B":
  salt.function:
    - name: git.add
    - tgt: {{ id }}
    - arg:
      - {{ uri_local_repo }}
      - '.'
    - kwarg:
          opts: '--all'


    
"81638FAC-D280-4B7B-BAAC-DD542B40B769":      
  salt.function:
    - name: git.commit
    - tgt: {{ id }}
    - arg:
      - {{ uri_local_repo }}
    - kwarg:
        message: "{{ msg_autocommit }}"


      
"83D0E834-A2FB-4FCC-9EA0-D00D443D8446":
  salt.function:
    - name: git.push
    - tgt: {{ id }}
    - arg:
      - {{ uri_local_repo }}
    - kwarg:
        remote: origin
        ref: {{ id }}
        identity: {{ uri_sshkey }}



## more idealy, this should be event-based
# "77F70C00-9961-439A-877E-1F56530E1B05":
#   schedule.present:
#     - function: state.sls
#     - job_args:
#       - state.data.git.salt-key-latest
#     - seconds: 600 # 10mins
#     - splay: 600   # 10min



