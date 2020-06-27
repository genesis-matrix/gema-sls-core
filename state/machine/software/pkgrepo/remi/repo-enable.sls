##
##

#enable_remi:
"74960f05-5aef-4f6b-bd7e-cd7cdbe64cb7":
  file.replace:
    - name: /etc/yum.repos.d/remi.repo
    - pattern: '^enabled=\d'
    - repl: enabled=1
