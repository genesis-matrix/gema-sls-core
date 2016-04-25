##
##
##



#
"2252105E-A496-4118-B98D-5594663D4E69":
  pkg.installed:
    - pkgs:
      - git
      - python-pygit2



#
"DCF6981C-90AB-45CC-A3B9-95121929AA18":
  pkg.installed:
    - name: salt-master
    - prereq:
      - pkg: "2252105E-A496-4118-B98D-5594663D4E69"



