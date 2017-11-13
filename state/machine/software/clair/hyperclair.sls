##
##
##



#
"9C5C6C27-3A40-4556-868B-475392F8EE51":
  cmd.run:
    - name: 'sudo curl -L -o /usr/bin/hyperclair  https://github.com/wemanity-belgium/hyperclair/releases/download/0.5.0/hyperclair-linux-amd64 && sudo chmod +x /usr/bin/hyperclair'
    - unless: 'test -x hyperclair'