##
##
##



##_META:
##  todo:
##    - mount the app data path /var/consul to an external persistent source
##  refs:
##    - https://coreos.com/rkt/docs/latest/subcommands/run.html#mounting-volumes
##    - https://www.consul.io/docs/agent/options.html#configuration_files
##



## <JINJA>
{% set container_shortname = salt['pillar.get']('', 'consul') %}
{% set container_name = salt['pillar.get']('', container_shortname) %}
{% set container_version = salt['pillar.get']('', 'latest') %}
{% set uri_container = salt['pillar.get']('', "docker://" + container_name + ":" + container_version) %}
{% set opt_rkt = salt['pillar.get']('', " --insecure-options=image --trust-keys-from-https --dns=host --net=host ") %}
{%- set json_consul_config = '{"node_name": "consul-embedded", "server": true}' %}
##



#
include:
  - state.machine.software.rkt
  - state.machine.service.rkt



#
"530F91CA-9442-44B1-A49F-6926C43C4969":
  cmd.run:
    - unless: systemctl -q is-active rkt-consul.service
    - name: systemctl reset-failed ; systemd-run --unit="rkt-{{ container_shortname }}.service" /usr/bin/rkt run {{ opt_rkt }} {{ uri_container }}
    - env:
      - CONSUL_BIND_INTERFACE: ''
      - CONSUL_CLIENT_INTERFACE: ''
      - CONSUL_LOCAL_CONFIG: '{{ json_consul_config }}'
    - prereq_in:
      - cmd: "DFBE4AE6-BB02-4D10-ABE8-83DCDA234D2F"



## EOF
