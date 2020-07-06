##
##
##



##_META
##



## <JINJA>
{%- set var_dct = salt["pillar.get"]("lookup:minion_id:" ~ opts.id, {}) %}
{%- set _discard = var_dct.update({
  'x509': {
    'usage_type': ['backend', 'clientfacing'],
    'authn_type': ['selfsigned', 'casigned'],
    'crypto_group': salt["pillar.get"]("", var_dct.dutyinfo.ipso_key|default("") ~ "_crypto_read"),
    'key': {
      'uri_pfx': salt["pillar.get"]('', '/etc/pki/tls/private/'),
      'uri_sfx': salt["pillar.get"]('', 'key'),
      'file_mode': '640',
    },
    'cert': {
      'uri_pfx': salt["pillar.get"]('', '/etc/pki/tls/certs/'),
      'uri_sfx': salt["pillar.get"]('', 'crt'),
      'file_mode': '644',
    },
    'ca': {},
  }
})
%}
{#- assemble the cv1class, used to generate the file basename #}
{%- set _discard = var_dct.update({
  'cv1class': [var_dct.dutyinfo.ipso_key, var_dct.dutyinfo.machine_role, "_" ~ var_dct.dutyinfo.deployenv]|join("_"),
  })
%}
{#- assemble the purpose label, used to generate the file basename #}
{%- set _discard = var_dct.x509.update({
  'purpose_label': salt["pillar.get"]("", [var_dct.x509.usage_type|first, var_dct.x509.authn_type|first]|join("-")),
  })
%}
{%- set _discard = var_dct.x509.update({
  'basename': [var_dct.cv1class, var_dct.x509.purpose_label]|join("."),
  })
%}
{%- set _discard = var_dct.x509.cert.update({
  "uri": [var_dct.x509.cert.uri_pfx ~ var_dct.cv1class, var_dct.x509.purpose_label, var_dct.x509.cert.uri_sfx]|join(".")
  })
%}
{%- set _discard = var_dct.x509.key.update({
  "uri": [var_dct.x509.key.uri_pfx ~ var_dct.cv1class, var_dct.x509.purpose_label, var_dct.x509.key.uri_sfx]|join(".")
  })
%}
## </JINJA>



#
{% for pfx in [var_dct.x509.cert.uri_pfx, var_dct.x509.key.uri_pfx] %}
"ea17f014-c7af-4e3a-a686-94f6a3f7ad06--?pfx={{ pfx }}--?index0={{ loop.index0 }}":
  file.directory:
    - name: {{ salt["file.dirname"](pfx) }}
{% endfor %}



#
"dc61e810-41a3-4a08-8245-32606e2ee733":
  x509.private_key_managed:
    - name: {{ var_dct.x509.key.uri }}
    - bits: 4096
    - backup: True
    - mode: {{ var_dct.x509.key.file_mode }}



#
"230e74fb-d718-4696-a814-ecb0158dcce6":
  x509.certificate_managed:
    - name: {{ var_dct.x509.cert.uri }}
    - signing_private_key: {{ var_dct.x509.key.uri }}
    - CN: ca.example.com
    - C: US
    - ST: DC
    - L: Washington
    - basicConstraints: "critical CA:true"
    - keyUsage: "critical cRLSign, keyCertSign"
    - subjectKeyIdentifier: hash
    - authorityKeyIdentifier: keyid,issuer:always
    - days_valid: 3650
    - days_remaining: 30
    - backup: True
    - group: {{ var_dct.x509.crypto_group }}
    - mode: {{ var_dct.x509.cert.file_mode }}
    - require:
      - x509: "dc61e810-41a3-4a08-8245-32606e2ee733"



## EOF
