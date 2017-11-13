##
##
##



#
"2252105E-A496-4118-B98D-5594663D4E69":
  pkg.installed:
    - pkgs:
      - git
      #<work-around uri="https://github.com/saltstack/salt/issues/38630">
      {#
       # work-around 1:
       #  curl --silent -O https://kojipkgs.fedoraproject.org//packages/http-parser/2.0/5.20121128gitcd01361.el7/x86_64/http-parser-2.0-5.20121128gitcd01361.el7.x86_64.rpm
       #  rpm -Uvh --oldpackage http-parser-2.0-5.20121128gitcd01361.el7.x86_64.rpm
       # work-around 2:
       #  - GitPython
       #}
      - python-pygit2
      #</work-around>
      - MySQL-python



#
"DCF6981C-90AB-45CC-A3B9-95121929AA18":
  pkg.installed:
    - name: salt-master
    - prereq:
      - pkg: "2252105E-A496-4118-B98D-5594663D4E69"



