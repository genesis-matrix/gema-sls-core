##
##
##



#
"00F9FB9D-5B32-4CAE-A58F-5BC15CD2291A":
  file.exists:
    - name: /etc/etcd



#
"815DAB50-4E10-4AE9-BAF1-6BC9386964A9":
  file.exists:
    - name: /var/lib/etcd/default.etcd



#
"47196BE7-162D-442F-9AA1-B6B17EB7C0E0":
  file.managed:
    - name: /etc/etcd/etcd.conf
    - contents: |
        ETCD_NAME=default
        ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
        ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"
        ETCD_ADVERTISE_CLIENT_URLS="http://localhost:2379"
