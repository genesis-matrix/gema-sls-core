##
##
##



##_META:
##  Applicability:
##  TODO:
##    - add 'salt-call saltutil.sync_all' operation
##



## <JINJA>
{%- set var_dct = {} %}
{%- set _discard = var_dct.update({"uri_pip": "/usr/bin/pip3", }) %}
## </JINJA>



#
"e3ad00a1-6f16-4a2e-990a-7dc1645c30bc":
  pkg.installed:
    - pkgs:
      - python3-devel  # for pygit2, et al
      - git
      - python36-GitPython
      - libgit2  # for pygit2
      - mariadb-devel  # for mysqlclient
      - salt-master




#
"5f8bde0e-18ac-49ee-892c-95dea01b5503":
  pip.installed:
    - names:
      - pip
      - setuptools
    - bin_env: {{ var_dct.uri_pip }}
    - upgrade: True
    - reload_modules: True



#
"d36fd37d-941a-4e9a-9a8b-7b2821a57958":
  pip.installed:
    - pkgs:
      - gnupg
      - inotify
      - testinfra
      - PyMongo
      - python-consul
      - docker-py
      - python-dateutil
      - pycrypto
      - timelib
      - Mako
      - cherrypy
      - mysqlclient  # py3 replacement for MySQL-python
      #- sqlite3dbm # needed for SDB via SQLite3
    - bin_env: {{ var_dct.uri_pip }}
    - require:
      - pip: "5f8bde0e-18ac-49ee-892c-95dea01b5503"



#
"bb679b97-c317-44c2-8f56-6e50222430e4":
  service.running:
    - name: salt-master
    - enable: True
    - full_restart: True
    - init_delay: 5
    - watch:
      - pkg: "e3ad00a1-6f16-4a2e-990a-7dc1645c30bc"
      - pip: "d36fd37d-941a-4e9a-9a8b-7b2821a57958"



#
"5bd950f6-2638-450c-9a8c-b21985ba4e35":
  module.run:
    - saltutil.sync_all: []
    - order: last



#
"e7fd43c2-3f44-474c-a8d4-ac5eb97a7553":
  module.run:
    - saltutil.runner:
      - saltutil.sync_all
    - order: last



## EOF
