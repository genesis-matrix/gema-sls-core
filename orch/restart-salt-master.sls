##
##
##



# restart salt-master service
"7720AD44-9689-4732-B88F-668D020169D4":
  salt.function:
    - name: service.restart
    - arg: salt-master
    - tgt: 'machine_role:salt-master'
    - tgt_type: pillar
    - order: last
