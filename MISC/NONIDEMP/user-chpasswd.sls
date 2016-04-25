##
##


## DESC:
##  - usage_saltssh: salt-ssh 'SV-DEMO-T1' state.sls _DEBUG.user-chpasswd pillar='{"pass": "<set-new-password-here>"}'


## Jinja
{% set user = salt['pillar.get']('user','root') %}
{% set pass = salt['pillar.get']('pass') %}
##


"2703f597-8047-4e3c-ab06-3c5f75460482":
  cmd.run:
    - env:
      - 'user': '{{ user }}'
      - 'pass': '{{ pass }}'
    - name: 'echo "${user}:${pass}" | chpasswd'

