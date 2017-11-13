##
##
##



#
include:
  - state.machine.software.kube-apiserver.config



# apiserver
"ECCD1CC4-4FE9-4D5C-815E-859B1816A034":
  cmd.script:
    - unless: systemctl -q is-active rkt-kube-apiserver
    - name: salt://assets/exe_script/bash_rktnetes-hyperkube
    # args are provided to KUBE_EXEC
    - args: " --enable_server --insecure-bind-address=0.0.0.0 --insecure-port=8080 --hostname_override=127.0.0.1 --kubelet_port=10250 --etcd_servers=http://127.0.0.1:2379 --service-cluster-ip-range=10.254.0.0/16 " # --admission_control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota "
    - env:
      - "KUBE_EXEC": "/apiserver"
      - "RKT_OPTS": ""
      - "KUBE_ACI": ""
      - "KUBE_VERSION": ""




