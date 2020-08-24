##
##
##



##_META:
##  Applicability: []
##  TODO:
##    - add 'salt-call saltutil.sync_all' operation
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
include:
  - .py_{{ var_dct.python_ver|replace(".", "_") }}



## EOF
