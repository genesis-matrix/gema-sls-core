##
##
##



#
"1EBA4FF5-AC16-4096-B3A7-61785DCC9D6B":
  file.exists:
    - name: /etc/kubernetes



#
"40C545CB-A9F5-479A-8601-7B3473916AF7":
  file.managed:
    - name: /etc/kubernetes/apiserver
    - contents: |
        KUBE_API_ADDRESS="--address=0.0.0.0"
        KUBE_API_PORT="--port=8080"
        KUBELET_PORT="--kubelet_port=10250"
        KUBE_ETCD_SERVERS="--etcd_servers=http://127.0.0.1:2379"
        KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"
        KUBE_ADMISSION_CONTROL="--admission_control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota"
        KUBE_API_ARGS=""



