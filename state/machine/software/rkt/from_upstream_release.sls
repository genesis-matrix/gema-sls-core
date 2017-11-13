##
##
##



## <JINJA>
{% set release_ver = salt['pillar.get']('', "1.24.0") %}
{% set release_tag = salt['pillar.get']('', "v" + release_ver) %}
{% set uri_installmedia = "https://github.com/coreos/rkt/releases/download/" + release_tag + "/rkt-" + release_tag + ".tar.gz" %}
{%- set uri_installmedia_stage = "/tmp/installmedia-rkt-" ~ release_tag ~ ".tar.gz" %}
## </JINJA>



#
"03C1A4CA-346A-4ECC-813A-13FE5C90FDEF":
  file.managed:
    - name: {{ uri_installmedia_stage }}
    - source: {{ uri_installmedia }}
    #- skip_verify: True
    - source_hash: sha256=0ec396f1af7782e402d789e6e34e9257033efac5db71d740f9742f3469d02298




#
"DFBE4AE6-BB02-4D10-ABE8-83DCDA234D2F":
  cmd.run:
    - unless: 'which rkt && rkt version | grep -qsi "rkt Version: {{ release_ver }}"'
    - name: 'cd $(mktemp -d) && tar zxf {{ uri_installmedia_stage }} && cd rkt-{{ release_tag }} && cp -puv rkt -t /usr/bin && (cp -puv manpages/* -t /usr/share/man/man1 ; sudo mandb ) && (mkdir -p /usr/lib/rkt/stage1-images ; cp *.aci -t /usr/lib/rkt/stage1-images) && (cp -puv init/systemd/* -t /etc/systemd/system || true ) && cp -puv init/systemd/tmpfiles.d/* -t /usr/lib/tmpfiles.d && cp -auv  bash_completion/* -t /etc/bash_completion.d  && ./scripts/setup-data-dir.sh'


    