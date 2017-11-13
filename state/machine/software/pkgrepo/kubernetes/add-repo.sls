##
##
##



##_META:
##  - References:
##    - http://unix.stackexchange.com/questions/132757/how-to-automatically-accept-epel-gpg-key
##    - code_snippet:
##      - add repo: |
##        # cat <<EOF > /etc/yum.repos.d/kubernetes.repo
##        [kubernetes]
##        name=Kubernetes
##        baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
##        enabled=1
##        gpgcheck=1
##        repo_gpgcheck=1
##        gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
##               https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
##        EOF
##        # setenforce 0
##        # yum install -y docker kubelet kubeadm kubectl kubernetes-cni
##        # systemctl enable docker && systemctl start docker
##        # systemctl enable kubelet && systemctl start kubelet
##



## <JINJA>
{% set repokeys = ["https://packages.cloud.google.com/yum/doc/yum-key.gpg", "https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg"] %}
## </JINJA



#
"C9F30C21-6D04-4892-9BD1-EDB013FEDE07":
  pkgrepo.managed:
    - humanname: Kubernetes
    - name: kubernetes
    - baseurl: http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
    - gpgkey: "{{ repokeys|join(' ') }}"
    - enable: 1
    - gpgcheck: 1 
    - repo_gpgcheck: 1



#
{% for repokey in repokeys %}
"2ADA05C5-9F52-4002-87D3-7EFC783671E0--?repokey={{ repokey }}":
  cmd.run:
    - name: "rpm --import {{ repokey }}"
    - onchanges:
      - "C9F30C21-6D04-4892-9BD1-EDB013FEDE07"
{% endfor %}



#
"FE62A30E-37D5-41B1-990D-559E95539469":
  cmd.run:
    - name: 'yum makecache -y --disablerepo="*" --enablerepo="kubernetes"'
    - onchanges:
      - "C9F30C21-6D04-4892-9BD1-EDB013FEDE07"



## EOF