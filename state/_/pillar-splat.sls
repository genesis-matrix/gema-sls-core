#!jinja|json
{%- load_text as _META %}
##
##



##_META
##  purpose: support rapid prototyping by creating one-off states from the Pillar
##
{%- endload %}



{#-
## <JINJA>
#}
{%- set var_dct = {} %}
{%- set _discard = var_dct.update({"_META": _META.replace("##  ", "", 1)|yaml }) %}
{%- set _discard = var_dct.update(salt['pillar.get']('lookup:sls_path:' ~ sls, {})) %}
{#- hint: create state for diagnostic uses #}
{% load_yaml as canary_stanza %}
#
"6f9e4439-adfd-482f-b59f-6f653fc99e2a--?sls={{ sls }}":
  test.succeed_without_changes:
    - name: "No stanza_dct data was passed in to this template, check the var_dct value in the template rendered for diagnostic info."
{%- endload %}
{#-
## </JINJA>
#}



{#-
#
#}
{%- if 'stanza_dct' in var_dct and var_dct.stanza_dct|default(None, True) is mapping %}
{{ var_dct.stanza_dct|tojson }}
{%- else %}
{# note, display the canary, if possible #}
{{ canary_stanza|default({}, True)|tojson }}
{%- endif %}



{#
## EOF
#}
