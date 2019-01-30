##
##
##



##_META:
##



## <JINJA>
{% set var_dct = {"pkg_lst": ["python-pygit2", "GitPython"]} %}
## </JINJA>



#
{%- for pkg in var_dct.pkg_lst %}
"0AAD9BA8-F5B8-4FB3-B714-6A8C12EE5C4C--?pkg={{ pkg }}":
  pkg.installed:
    - name: {{ pkg }}
    {%- if not loop.first %}
    - onfail:
      - pkg: "0AAD9BA8-F5B8-4FB3-B714-6A8C12EE5C4C--?pkg={{ var_dct.pkg_lst[loop.index0 - 1] }}"
    {%- endif %}
{%- endfor %}



## EOF
