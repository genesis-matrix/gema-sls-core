##
##
##



# NOTES:
#  - the kubelet requires an "unusual" amount of access to host to operate correctly



# kubelet
"F2FD5315-7FD2-48E0-89FF-928096D69949":
  cmd.script:
    - unless: systemctl -q is-active rkt-k8s-kubelet
    - name: salt://assets/exe_script/bash_rktnetes-hyperkube
    # args are provided to KUBE_EXEC
    - args: " --enable-server=true --container-runtime=rkt --rkt-api-endpoint=127.0.0.1:15441 --api-servers=127.0.0.1:8080  --config=/etc/kubernetes/manifests --node-ip=172.16.105.129"
    - env:
      - "KUBE_EXEC": "/kubelet"
      - "RKT_OPTS": " --net=host --debug --insecure-options=image --stage1-from-dir=stage1-fly.aci --volume rootfs-var-lib-rkt,kind=host,source=/var/lib/rkt --mount volume=rootfs-var-lib-rkt,target=/var/lib/rkt"
      - "KUBE_ACI": ""
      - "KUBE_VERSION": ""






