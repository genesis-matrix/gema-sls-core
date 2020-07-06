##
##
##



#[[ $? == 0 ]] && ln -fs $(mktemp) ~/.scratch.sls ; cat <<EOF> ~/.scratch.sls ; sudo salt-call state.template tem=~/.scratch.sls
##_META
##



## <JINJA>
{%- set var_dct = salt["pillar.get"]("lookup:minion_id:" ~ opts.id, {}) %}
{%- set _discard = var_dct.update({
  'pki': salt['pillar.get']('x509', {}),
  'crypto_groupname': var_dct.dutyinfo.ipso_key ~ "_crypto_read",
  })
%}
## </JINJA>



#
"e85cf976-2800-41e6-b527-72efede87d31":
  group.present:
    - name: {{ var_dct.crypto_groupname }}



#
{%- for name, contents in var_dct.pki.items() if name.endswith(".key") %}
"36ad7e3c-1032-414a-aa50-bc0e5a9d2e25--?name={{ name }}":
  file.managed:
    - name: /etc/pki/tls/private/{{ name }}
    - contents_pillar: "x509:{{ name }}"
    - mode: '0640'
    - user: root
    - group: {{ var_dct.crypto_groupname }}
{%- endfor %}



#
{%- for name, contents in var_dct.pki.items() if name.endswith(".crt") %}
"fe4948ba-ac2e-4943-99ac-b2c65d1ad6bb--?name={{ name }}":
  file.managed:
    - name: /etc/pki/tls/certs/{{ name }}
    - contents_pillar: "x509:{{ name }}"
    - mode: '0644'
{%- endfor %}



##{#
EOF
#}##
