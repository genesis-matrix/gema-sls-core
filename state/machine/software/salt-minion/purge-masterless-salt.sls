##
##
##



#
"8FC6CEE0-F1CF-48A6-9FB0-A9AEA3229D90":
  file.absent:
    - name: /etc/salt



#
"64A0CEE9-54FB-492A-86D1-0F3C26F5AF2B":
  file.absent:
    - name: /srv/salt



#
"28672861-4F61-493E-9DE2-A63894BEA816":
  file.absent:
    - name: /srv/pillar


#
"3F8CAB8C-345A-41C7-9B2E-7C5257A2482D":
  pkg.removed:
    - pkgs:
      - salt-minion
      - salt-master
