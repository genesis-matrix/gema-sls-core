##
##
##



##_META:
##  Applicability: N/A, the GitFS-style install is being used.
##  References:
##    - https://hubblestack.io/
##    - https://docs.saltstack.com/en/latest/ref/cli/spm.html
##    - https://spm.hubblestack.io/
##    - https://github.com/HubbleStack
##



## <JINJA>
{% set spm_installtype_lst = {'local': '', 'repo': ''} %}
{% set opt_spm_install_type = 'local' %}
{% set uri_spm_installmedia_lst = ["https://spm.hubblestack.io/nova/hubblestack_nova-2016.9.2-1.sp", "https://spm.hubblestack.io/quasar/hubblestack_quasar-2016.9.0-1.spm", "http://spm.hubblestack.io/pulsar/hubblestack_pulsar-2016.9.4-1.spm", "https://spm.hubblestack.io/nebula/hubblestack_nebula-2016.9.1-1.spm"] %}
{% set version_tag = "2016.7.1-1" %}
## </JINJA>



#
{%- if opt_spm_install_type == 'repo' %}
"4D3381A6-2A1A-4829-935B-53B8B9E9646E":
  file.directory:
    - name: /etc/salt/spm.repos.d/
    - makedirs: True
{%- endif %}



#
{%- if opt_spm_install_type == 'repo' %}
"2A74BE83-2D87-4C9D-8A53-013BE4330810":
  file.exists:
    - name: /etc/salt/spm.repos.d/{{ repo_shortname }}.repo
{%- endif %}



#
{%- if opt_spm_install_type == 'local' %}
{%- for uri_spm_installmedia in uri_spm_installmedia_lst %}
"DFDF4EAF-2A52-459A-A218-EC5ADC6EF889--{{ uri_spm_installmedia }}":
  cmd.run:
    - name: 'cd $(mktemp -d) && curl -o installfile.spm "{{ uri_spm_installmedia }}" && spm -y local install installfile.spm'
{% endfor %}
{% endif %}



    
## EOF