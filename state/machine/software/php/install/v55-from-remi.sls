##
##


include:
  - state.machine.software.pkgrepo.remi.repo-add-remi
#  - config.apps.pkgrepo.remi.components.enable-remi-php55


## remove any older, potentially conflicting, package versions
"6f232951-3f09-4f28-8fd4-984ad3de6956":
  pkg.purged:
    - version: '< 5.5'
    - pkgs:
      - php
      - php-common

## a
"8f818668-d9bf-4b34-af2e-5ec05cadf71d":
  pkg.installed:
    - fromrepo: remi-php55,remi,epel
    - version: '>= 5.5'
    - pkgs:
      - php

##
"704241fb-08eb-4812-84e2-bafa73f3b44a":
  pkg.installed:
    - fromrepo: remi-php55,remi,epel
    - pkgs:
      - php-mbstring
      - php-mcrypt
      - php-xml
      - php-ldap
      - php-pdo
      - php-mysqlnd
      - composer

