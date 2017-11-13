##
##
##



##_META:
##



## <JINJA>
{%- set lookup = salt['pillar.get']('lookup:sls_path:' ~ sls, None) %}
{%- set stanza = lookup %}
## </JINJA>



#
{%- if stanza is mapping %}
{{ stanza |yaml }}
{%- endif %}



## EOF
