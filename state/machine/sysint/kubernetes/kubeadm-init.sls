##
##
##



##_META::
##  References:
##    - http://kubernetes.io/docs/getting-started-guides/kubeadm/
##



## <JINJA>
{% set k8s_cni = {'kubeadm-flannel': 'https://github.com/coreos/flannel/blob/master/Documentation/kube-flannel.yml', 'kubeadm-callico': 'http://docs.projectcalico.org/v1.6/getting-started/kubernetes/installation/hosted/kubeadm/calico.yaml', 'kubeadm-cannal': 'https://github.com/tigera/canal/blob/master/k8s-install/kubeadm/canal.yaml', 'kubeadm-weave': 'https://git.io/weave-kube'} %}
## </JINJA>



#
include:
  - state.machine.resource-control.selinux-permissive
  - state.machine.software.pkgrepo.kubernetes



#
{% for pkg in ["docker", "kubelet", "kubeadm", "kubectl", "kubernetes-cni"] %}
"F985A835-2D88-44CC-9977-881BE38CFBCE--?pkg={{ pkg }}":
  pkg.installed:
    - name: {{ pkg }}
{% endfor %}



#
{% for svc in ["docker", "kubelet"] %}
"258C6205-E976-4906-8868-843184513F29--?svc={{ svc }}":
  service.running:
    - name: {{ svc }}
    - enable: True
{% endfor %}



#
"371A1322-60C3-4B35-B5B7-FDD22C27E755":
  cmd.run:
    - name: 'kubeadm init'
    - use_vt: True
    - creates:
      - '/etc/kubernetes/admin.conf'



# permit scheduling workload on kube-master
"5118CCFD-2D31-4D98-83EE-749FFED6B3B0":
  cmd.run:
    - name: 'kubectl taint nodes --all dedicated-'



# deploy calico CNI
"F0E6A6F9-D4D1-4CA7-92A2-5F5172E8A280":
  cmd.run:
    - name: kubectl apply -f {{ k8s_cni['kubeadm-callico'] }}



# after installing a single CNI, verify that 'kube-dns' pods is running



### EOF
