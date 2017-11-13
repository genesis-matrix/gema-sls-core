##
##
##



# apiserver
"B899A7DF-CD8C-4BB0-8FBC-79FE4AFF092E":
  cmd.script:
    - unless: systemctl -q is-active rkt-k8s-controller-manager
    - name: salt://assets/exe_script/bash_rktnetes-hyperkube
    # args are provided to KUBE_EXEC
    - args: ""
    - env:
      - "KUBE_EXEC": "/controller-manager"
      - "RKT_OPTS": ""
      - "KUBE_ACI": ""
      - "KUBE_VERSION": ""




