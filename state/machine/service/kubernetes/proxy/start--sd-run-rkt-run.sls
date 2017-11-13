##
##
##



#
"843BFE9E-84D1-4710-A258-3874BCE11516":
  cmd.script:
    - name: salt://assets/exe_script/bash_rktnetes-hyperkube
    # args are provided to KUBE_EXEC
    - args: " --master=http://127.0.0.1:8080 --v=2"
    - env:
      - "KUBE_EXEC": "/proxy"
      - "RKT_OPTS": ""
      - "KUBE_ACI": ""
      - "KUBE_VERSION": ""



