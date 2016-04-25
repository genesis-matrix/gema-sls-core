##
##
##



# copied from "2252105E-A496-4118-B98D-5594663D4E69"
"A30F8081-B4EE-4D64-9D20-63ED38711E1B":
  pkg.installed:
    - pkgs:
      - git
      - python-pygit2



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
    - restart: True
    - prereq:
      - pkg: "F4642A41-685E-4F9A-BA59-A1A4A0C46D20"
    - order: last



