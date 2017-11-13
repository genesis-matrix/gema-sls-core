##
##
##



##_META:
##



## <JINJA>
{%- set sls_uuid = "DFD9F8B8-283B-40D6-B5BA-075DE0AAFCCE" %}
{%- set sls_basename = slspath.replace('/', '.').split('.')[-1] %}
## </JINJA>



#
include:
  - state.machine.software.systemd-networkd



#
"B2FB3BB0-63FB-4ADF-B3C3-A32612E2FD79--?sls_uuid={{ sls_uuid}}--?slspath={{ slspath }}":
  service.running:
    - name: systemd-networkd
    - enable: True



## EOF