##
## ./top.sls - environment specification
##


## note: top file
base:
  '*':
    - MISC.DEBUG.test-non-op
    {#- match on pillar-defined roles -#}
    {% for role in salt['pillar.get']('machine_role') %}
    - discrete.machine_role.{{ role }}
    {% endfor %}

