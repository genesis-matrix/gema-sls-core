##
##
##



## Jinja
# rkt
{% set rkt_release_ver = salt['pillar.get']('', "1.14.0") %}
{% set rkt_release_tag = salt['pillar.get']('', "v" + rkt_release_ver) %}
{% set uri_rkt_installmedia = "https://github.com/coreos/rkt/releases/download/" + rkt_release_tag + "/rkt-" + rkt_release_tag + ".tar.gz" %}
# kubernetes
{% set k8s_release_ver = "" %}
{% set k8s_release_tag = "" %}
{% set uri_k8s_installmedia = "" %}



# rkt setup
"60962CFD-1527-4923-B741-DE9699C4D929":
  cmd.run:
    - unless: 'which rkt && rkt version | grep -qsi "rkt Version: {{ rkt_release_ver }}"'
    - name: 'pushd $(mktemp -d) && curl -sL {{ uri_rkt_installmedia }} | tar zx && cd rkt-{{ rkt_release_tag }} && cp -puv rkt -t /usr/bin && (mkdir -p /usr/local/man ; cp -puv manpages/* -t /usr/local/man/. ) && (mkdir -p /usr/lib/rkt/stage1-images ; cp *.aci -t /usr/lib/rkt/stage1-images) && (cp -puv init/systemd/* -t /etc/systemd/system || true ) && cp -puv init/systemd/tmpfiles.d/* -t /usr/lib/tmpfiles.d && cp -auv  bash_completion/* -t /etc/bash_completion.d  && ./scripts/setup-data-dir.sh'



# kubernetes setup, step:01 
"DBA91F17-E804-49D5-B84D-3F28FACE72BB":



#



