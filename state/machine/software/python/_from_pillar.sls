##
##
##



##_META
##



## <JINJA>
{%- load_yaml as _defaults %}
uri_pillar:
  sls_data: {{ 'lookup:sls_path:' ~ sls }}
{%- endload %}
{%- set var_dct = {} %}
{%- set _discard = var_dct.update(_defaults) %}
{%- set _discard = var_dct.update(salt["pillar.get"](var_dct.uri_pillar.sls_data, {})) %}
## </JINJA>



#
{%- if var_dct.pip_install_pkg_lst|default(None, True) %}
"c93dda18-5288-416f-87f8-c5125a6b7071--?pip_install_pkg_lst={{ var_dct.pip_install_pkg_lst }}":
  pip.installed:
    pkgs: {{ var_dct.pip_install_pkg_lst }}
{%- endif %}



#
{%- if var_dct.pip_remove_pkg_lst|default(None, True) %}
"a16435f9-1c96-48c0-a9aa-517cc690ea67--?pip_remove_pkg_lst={{ var_dct.pip_remove_pkg_lst }}":
  pip.removed:
    pkgs: {{ var_dct.pip_remove_pkg_lst }}
{%- endif %}



## EOF
