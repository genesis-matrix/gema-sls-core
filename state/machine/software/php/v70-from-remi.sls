##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
include:
  - state.machine.software.pkgrepo.remi.repo-add-remi
  - config.apps.pkgrepo.remi.mod-enable-php70



# remove any older, potentially conflicting, package versions
"5E317C32-8FC7-4D05-B64D-2F55D405C158":
  pkg.purged:
    - version: '< 7'
    - pkgs:
      - php
      - php-common

#
"5DBF8FB3-C8CE-46A3-B76D-70212A258719":
  pkg.installed:
    - fromrepo: remi-php70,remi,epel
    - version: '>= 7'
    - pkgs:
      - php

#
"A5F46462-FCE3-45DF-BEC7-ABE95A4C53C6":
  pkg.installed:
    - fromrepo: remi-php55,remi,epel
    - pkgs:
      - php-mbstring
      - php-mcrypt
      - php-xml
      - php-pdo
      - composer



## EOF
