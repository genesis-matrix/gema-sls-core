##
##
##



# apiserver
"BE3E478F-C6CB-4AD3-ACAC-29CAA5026096":
  cmd.script:
    - unless: systemctl -q is-active rkt-k8s-scheduler
    - name: salt://assets/exe_script/bash_rktnetes-hyperkube
    # args are provided to KUBE_EXEC
    - args: ""
    - env:
      - "KUBE_EXEC": "/scheduler"
      - "RKT_OPTS": ""
      - "KUBE_ACI": ""
      - "KUBE_VERSION": ""
