##
## ./top.sls - environment specification
##



#_META:
##



## <JINJA>
{% set gema_key = {'sls_lst': 'lookup:sls_path'} %}
{% set sls_path_lst = salt['pillar.get'](gema_key['sls_lst'], '') %}
## </JINJA>



#
{{ saltenv }}:  
  '*':
    - MISC.DEBUG.test-non-op
    {% for sls_path_item in sls_path_lst %}
    {% if sls_path_item is mapping %}
    {% for sls_path_subitem, discarded_value in sls_path_item.iteritems() %}
    - {{ sls_path_subitem }}
    {% endfor %}
    {% else %}
    - {{ sls_path_item }}
    {% endif %}
    {% endfor %}



## EOF
