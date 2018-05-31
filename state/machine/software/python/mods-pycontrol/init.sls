##
##
##



##_META:
##



## <JINJA>
{% set var_dct = {"pip_pkgs": ["pycontrol"]} %}
## </JINJA>



#
{%- for pkg in var_dct.pkgs %}
"6f57b44d-21b8-465f-9bc9-4e40f99546b4--?pip_pkg={{ pip_pkg }}":
  pip.installed:
    - name: {{ pkg }}
{%- endfor %}      



## EOF
