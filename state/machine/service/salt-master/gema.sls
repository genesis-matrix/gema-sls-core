##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
include:
  # verify system configs
  - state.machine.mount.swap.encrypted
  - state.machine.mount.ramdisk
  #
  - state.machine.software.osquery
  #
  - state.data.salt-master.pillar.gema
  {# removed for troubleshooting a/ improvements:
  - state.data.salt-master.pki.gema
  #}
  #
  - state.machine.service.rkt
  {# removed for troubleshooting a/ improvements:
  - state.machine.service.consul
  #}
  - state.machine.service.salt-minion
  - state.machine.service.salt-master
  #
  - formula.salt.master
  #
  #- state.service.kubernetes
  


## EOF