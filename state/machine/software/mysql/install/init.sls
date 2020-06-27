##
##

##
"477b6ee5-624c-4849-9739-931ac6588cfa":
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql
      ##+NB: needed for mysql states
      ##+TODO: make OS-independent, 'MySQL-python' is RHEL-family specific
      - MySQL-python
