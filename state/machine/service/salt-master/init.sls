##
##
##



##_META:
##  Applicability:
##  TODO:
##    - add 'salt-call saltutil.sync_all' operation
##



## <JINJA>
## </JINJA>



# copied from "2252105E-A496-4118-B98D-5594663D4E69"
"A30F8081-B4EE-4D64-9D20-63ED38711E1B":
  pkg.installed:
    - pkgs:
      - git
      - python
      - python-pygit2
      - python2-gnupg
      - python-inotify
      # needed to overcome awkward packaging of python-pygit2 on CentOSv7
      - libgit2-devel
      - python-devel
      # needed for SDB via SQLite3
      - python-sqlite3dbm



#
"5ED328D2-1879-409D-9F8A-9C9AD371CF92":
  pkg.installed:
    - name: python2-pip



#
"9147F497-8419-4C45-B60B-32C932144EA7":
  pip.installed:
    - name: python-consul
    - require:
      - pkg: "5ED328D2-1879-409D-9F8A-9C9AD371CF92"



#
"A1C296F8-8143-4606-84BB-AAD0CCCF6952":
  pip.installed:
    - name: testinfra



# copied from "DCF6981C-90AB-45CC-A3B9-95121929AA18"
"F4642A41-685E-4F9A-BA59-A1A4A0C46D20":
  pkg.installed:
    - pkgs:
      - salt-master
    - prereq:
      - pkg: "A30F8081-B4EE-4D64-9D20-63ED38711E1B"



#
"93B22BC4-8B75-438F-913A-3DBF5FED5621":
  service.running:
    - name: salt-master
    - enable: True
    - full_restart: True
    - init_delay: 5
    - watch:
      - pkg: "F4642A41-685E-4F9A-BA59-A1A4A0C46D20"
      - pkg: "A30F8081-B4EE-4D64-9D20-63ED38711E1B"
    - order: last



## EOF
