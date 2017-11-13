##
##
##



##_META:
##  purpose: install consul
##  refs:
##    - https://www.consul.io/docs/agent/options.html#configuration_files
##



## <JINJA>
{%- set installmedia_productname = salt['pillar.get']('', "consul") %}
{%- set installmedia_version = salt['pillar.get']('', "0.7.5") %}
{%- set installmedia_platform = salt['pillar.get']('', "linux_amd64") %}
{%- set installmedia_file_suffix = salt['pillar.get']('', ".zip") %}
{%- set uri_installmedia_hash = salt['pillar.get']('', "https://releases.hashicorp.com/" ~ installmedia_productname ~ "/" ~ installmedia_version ~ "/" ~ installmedia_productname ~ "_" ~ installmedia_version ~ "_SHA256SUMS") %}
{%- set installmedia_filename = installmedia_productname ~ "_" ~ installmedia_version ~ "_" ~ installmedia_platform ~ installmedia_file_suffix ~ "" %}
{%- set uri_installmedia = salt['pillar.get']('', "https://releases.hashicorp.com/" ~ installmedia_productname ~ "/" ~ installmedia_version ~ "/" ~ installmedia_filename) %}
{%- set consul = {
        'data-dir': salt['pillar.get']('', "/srv/consul-data")
        }
%}
## </JINJA>



#
"9F575AE1-1E4A-4CEA-B9C1-DBA02EA18372":
  file.managed:
    - name: /tmp/{{ installmedia_filename }}
    - source: {{ uri_installmedia }}
    - source_hash: {{ uri_installmedia_hash }}
    - source_hash_name: {{ installmedia_filename }}
    



#
"20E6AE5D-6D65-4166-A69D-7F440B2372DB":
  file.directory:
    - name: /tmp/{{ installmedia_filename }}.d



#
"12B64973-85CE-45F2-A9E6-6329C99812C4":
  archive.extracted:
    - name: /tmp/{{ installmedia_filename }}.d/
    - source: /tmp/{{ installmedia_filename }}
    - source_hash: {{ uri_installmedia_hash }}
    - source_hash_name: {{ installmedia_filename }}
    - enforce_toplevel: False



#
"98B13CCA-FD0F-4FD4-87A1-7C10C4E77CBC":
  file.managed:
    - name: /usr/bin/consul
    - source: /tmp/{{ installmedia_filename }}.d/{{ installmedia_productname }}
    - mode: "0551"



#
"48A287C3-62A9-4CAC-BD7B-652277BE8879":
  file.directory:
    - name: "{{ consul['data-dir'] }}"



#
"E6E20499-8634-46FE-BC8C-6D028D514F10":
  cmd.run:
    - name: systemd-run --unit "consul-agent.service" consul agent -data-dir "{{ consul['data-dir'] }}"
    - unless: systemctl reset-failed ; systemctl is-failed consul-agent.service



## EOF
