##
##
##



##_META:
##



## <JINJA>
{%- set var_dct = {
  'uri_datafile': tpldir.split("/")[:-1]|join("/") ~ "/pkgs.yml",
  'uri_lookup': [
                 salt['grains.get']('os', ''),
                 salt['grains.get']('osmajorrelease', 0),
                 salt['grains.get']('pythonversion', [])[:2]|join('.'),
                 "mysql",
                 ]|join(":"),
  }
%}
{%- import_yaml var_dct.uri_datafile as _pkgs %}
{%- set _discard = var_dct.update({'python_pkg_lst': _pkgs.get("CentOS:7", ["lookup_miss"]) }) %}
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
{%- for pkg_name in var_dct.python_pkg_lst %}
"0AAD9BA8-F5B8-4FB3-B714-6A8C12EE5C4C--?pkg_name={{ pkg_name }}--?var_dct={{ var_dct }}":
  pkg.installed:
    - name: {{ pkg_name }}
{%- endfor %}      



## EOF
