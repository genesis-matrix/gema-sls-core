##
##
##



##_META:
##



## <JINJA>
{%- set svcname_lst = ['rkt-api', 'rkt-metadata'] %}
## </JINJA>



#
include:
  - state.machine.software.rkt



#
{% for svcname in svcname_lst %}
"B38032C7-B372-46A9-9D6C-1580D576B1F8--?svcname={{ svcname }}":
  service.running:
    - name: {{ svcname }}
    - enable: True
{% endfor %}



#
"A8B4A721-84C0-4DF8-A6AF-75454049C67D":
  service.enabled:
    - name: 'rkt-gc'



## EOF