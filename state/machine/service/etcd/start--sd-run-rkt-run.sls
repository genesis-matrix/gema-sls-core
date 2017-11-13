##
##
##



#
include:
  - state.machine.software.etcd.config



#
"A1D7AFD0-933C-46C0-BFF5-ACF8D15D8B6A":
  cmd.run:
    - unless: systemctl -q is-active rkt-etcd.service
    - name: systemctl reset-failed ; systemd-run --unit="rkt-etcd.service" /usr/bin/rkt run --trust-keys-from-https coreos.com/etcd:${ETCD_VERSION} --volume data-dir,kind=host,source=${ETCD_DATA_DIR:-$(mktemp -d)} --net=host
    - env:
      - ETCD_NAME: "default"
      - ETCD_VERSION: "v2.3.7"
      - ETCD_DATA_DIR: "/var/lib/etcd/default.etcd"
      - ETCD_LISTEN_CLIENT_URLS: "http://0.0.0.0:2379"
      - ETCD_ADVERTISE_CLIENT_URLS: "http://localhost:2379"

      

