##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
include:
  - state.machine.service.rkt
  - state.machine.service.etcd
  - state.machine.service.kubernetes.kubelet
  - state.machine.service.kubernetes.apiserver
  - state.machine.service.kubernetes.controller-manager
  - state.machine.service.kubernetes.proxy
  - state.machine.service.kubernetes.scheduler



## EOF
