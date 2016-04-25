##
##


#disable_remi:
"9b8eae11-c729-4641-934c-3c130a68441f":
  file.replace:
    - name: /etc/yum.repos.d/remi.repo
    - pattern: '^enabled=\d'
    - repl: enabled=0

