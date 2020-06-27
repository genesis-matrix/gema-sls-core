##
##
##



##_META:
##  refs:
##    - https://hub.docker.com/_/vault/
##    - http://serverfault.com/questions/788392/how-to-add-capabilities-to-rkt-container
##    - https://www.vaultproject.io/docs/config/
##



## <JINJA>
{% set container_shortname = salt['pillar.get']('', 'vault') %}
{% set container_name = salt['pillar.get']('', container_shortname) %}
{% set container_version = salt['pillar.get']('', 'latest') %}
{% set uri_container = salt['pillar.get']('', "docker://" + container_name + ":" + container_version) %}
{% set opt_rkt = salt['pillar.get']('', " --insecure-options=image --trust-keys-from-https --dns=host --net=host "
        ~ " --cap-retain=\'CAP_IPC_LOCK,CAP_CHOWN,CAP_DAC_OVERRIDE,CAP_FSETID,CAP_FOWNER,CAP_MKNOD,CAP_NET_RAW,CAP_SETGID,CAP_SETUID,CAP_SETFCAP,CAP_SETPCAP,CAP_NET_BIND_SERVICE,CAP_SYS_CHROOT,CAP_KILL,CAP_AUDIT_WRITE\' ") %}
##



#
include:
  - state.machine.software.rkt
  - state.machine.service.rkt
  - state.machine.service.consul



#
{#
Notes:
  - Vault wants toe CAP_IPC_LOCK capability in order to lock RAM to prevent it from swapping to disk
  - To add this capability to vault, we will need to add it to the list of default docker capabilities and provide it to the '--cap-retain=""' command line option
  - the default docker capabilities, (from: https://github.com/docker/docker/blob/v1.11.2/oci/defaults_linux.go#L64-L79):
    - "CAP_CHOWN"
    - "CAP_DAC_OVERRIDE"
    - "CAP_FSETID"
    - "CAP_FOWNER"
    - "CAP_MKNOD"
    - "CAP_NET_RAW"
    - "CAP_SETGID"
    - "CAP_SETUID"
    - "CAP_SETFCAP"
    - "CAP_SETPCAP"
    - "CAP_NET_BIND_SERVICE"
    - "CAP_SYS_CHROOT"
    - "CAP_KILL"
    - "CAP_AUDIT_WRITE"
  - adding "CAP_IPC_LOCK" via CLI:
    - (ex.) rkt --cap-retain="CAP_IPC_LOCK,CAP_CHOWN,CAP_DAC_OVERRIDE,CAP_FSETID,CAP_FOWNER,CAP_MKNOD,CAP_NET_RAW,CAP_SETGID,CAP_SETUID,CAP_SETFCAP,CAP_SETPCAP,CAP_NET_BIND_SERVICE,CAP_SYS_CHROOT,CAP_KILL,CAP_AUDIT_WRITE"

#}



#
"77B2460A-BDA7-4D11-A474-722C6A4CCC86":
  cmd.run:
    - unless: systemctl -q is-active rkt-{{ container_shortname }}.service
    - name: systemctl reset-failed ; systemd-run --unit="rkt-{{ container_shortname }}.service" /usr/bin/rkt run {{ opt_rkt }} {{ uri_container }}
    - env:
      - VAULT_DEV_ROOT_TOKEN_ID: myroot
      - VAULT_DEV_LISTEN_ADDRESS: '127.0.0.1:8200'
      - VAULT_LOCAL_CONFIG: '{"backend": {"file": {"path": "/vault/file"}}, "default_lease_ttl": "168h", "max_lease_ttl": "720h"}'
    - prereq_in:
      - cmd: "DFBE4AE6-BB02-4D10-ABE8-83DCDA234D2F"



## EOF
