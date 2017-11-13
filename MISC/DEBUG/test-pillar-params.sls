##
##
##



##_META:
##



## <JINJA>
{% set lookup = salt['pillar.get']('lookup:sls_path:' ~ sls, '') %}
## </JINJA>



#
"35E44CF6-CD51-4C60-806D-6FC7290E1182":
  test.nop:
    - name: "?lookup={{ lookup }}--?sls={{ sls }}"



## EOF
