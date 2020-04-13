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
## </JINJA>



#
"2252105E-A496-4118-B98D-5594663D4E69":
  pkg.installed:
    - pkgs:
      - git
      - {{ "MySQL-python" if salt['grains.get']('pythonversion')[0] == 2 else "python36-mysql" }}



#
"DCF6981C-90AB-45CC-A3B9-95121929AA18":
  pkg.installed:
    - name: salt-master
    - prereq:
      - pkg: "2252105E-A496-4118-B98D-5594663D4E69"



## EOF
