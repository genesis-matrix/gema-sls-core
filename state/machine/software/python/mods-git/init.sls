##
##
##



##_META:
##



## <JINJA>
{%- set var_dct = {} %}
{%- set _discard = var_dct.update({
  'python_ver': '.'.join([salt['grains.get']('pythonversion')[0]|string,
                          salt['grains.get']('pythonversion')[1]|string])
  })
%}
{%- load_yaml as _defaults %}
pkgs_by_python_ver:
  "2.7":
    - GitPython
  "3.6":
    - python36-GitPython
{%- endload %}
{%- set _discard = var_dct.update(_defaults) %}
{%- set _discard = var_dct.update({
  'python_pkg_lst': var_dct.pkgs_by_python_ver[var_dct.python_ver]
  })
%}
## </JINJA>



# notes on Implementation Status
{#
---  # python-pygit2
ref: "https://github.com/saltstack/salt/issues/38630">
work-around 1:
  curl --silent -O https://kojipkgs.fedoraproject.org//packages/http-parser/2.0/5.20121128gitcd01361.el7/x86_64/http-parser-2.0-5.20121128gitcd01361.el7.x86_64.rpm
  rpm -Uvh --oldpackage http-parser-2.0-5.20121128gitcd01361.el7.x86_64.rpm
work-around 2:
  - GitPython
  - python-pygit2
#}



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
