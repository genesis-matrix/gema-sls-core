##
##
##



##_META
##  purpose: enable simple data-driven certificate management automation
##



## <JINJA>
{%- set var_dct = {} %}
{%- set _discard = var_dct.update(salt["pillar.get"]("lookup:minion_id:" ~ opts.id, {})) %}
{%- set _discard = var_dct.update(salt["pillar.get"]("lookup:sls_path:" ~ sls, {})) %}
## </JINJA>



# notes on Implementation Status
#{#



#}#



# .WIP: 
{#
{%- if 'x509_signing_policies' in var_dct %}
"608d509d-cc50-44f6-8038-4a58547d49c6":
  file.managed:
    - name: /etc/salt/minion.d/x509_signing_policies.conf
    - contents: |
        {{ var_dct.x509_signing_policies | indent }}
{%- endif %}
#}



{%- if 'x509_lst' not in var_dct %}
#
"64a61a60-0f31-43ad-8d20-da172d89de09":
  test.succeed_without_changes:
    - name: "{{ var_dct }}"
{%- else %}      



{%- for x509 in var_dct.x509_lst %}
{%- if 'key' in x509 and 'uri' in x509.key %}
#
"ea17f014-c7af-4e3a-a686-94f6a3f7ad06--?index0={{ loop.index0 }}":
  file.directory:
    - name: {{ salt["file.dirname"](x509.key.uri) }}
    - makedirs: True
{%- endif %}      



#
{%- if 'key' in x509 and 'uri' in x509.key %}
"dc61e810-41a3-4a08-8245-32606e2ee733--?index0={{ loop.index0 }}":
  x509.private_key_managed:
    - name: {{ x509.key.uri }}
    - bits: {{ x509.key.bits|default(4096) }}
    - backup: {{ x509.key.backup|default(True) }}
    {{ "- group: " ~ x509.cert.crypto_group if x509.cert.crypto_group|default(None) is not none else ""}}
    {{ "- mode: " ~ x509.key.file_mode if x509.key.file_mode|default(None) is not none else "" }}
{%- endif %}



#  
{%- if 'cert' in x509 and 'uri' in x509.cert %}
"ea17f014-c7af-4e3a-a686-94f6a3f7ad06--?x509.cert.uri={{ x509.cert.uri }}--?index0={{ loop.index0 }}":
  file.directory:
    - name: {{ salt["file.dirname"](x509.cert.uri) }}
    - makedirs: True
{%- endif %}



#
{%- if 'cert' in x509 and 'uri' in x509.cert %}
"230e74fb-d718-4696-a814-ecb0158dcce6--?index0={{ loop.index0 }}":
  x509.certificate_managed:
    - name: {{ x509.cert.uri }}
    {{ "- signing_policy: " ~ x509.cert.signing_policy if 'signing_policy' in x509.cert else "" }}
    {{ "- ca_server: " ~ x509.cert.ca_server if 'ca_server' in x509.cert else "" }}    
    # use a locally generated key to create a self-signed certificate
    - signing_private_key: {{ x509.cert.signing_private_key|default(x509.key.uri) }}
    # (ex.) domain.example.com
    - CN: {{ x509.cert.cn|default("domain.example.com") }}
    # (ex.) US
    - C: {{ x509.cert.country|default("US") }}
    # (ex.) DC
    - ST: {{ x509.cert.state|default("DC") }}
    # (ex.) Washington
    - L: {{ x509.cert.locality|default("Washington") }} 
    # (ex.) "critical CA:true"
    - basicConstraints: {{ x509.cert.basicConstraints|default("critical CA:true") }}
    # (ex.) "critical cRLSign, keyCertSign"
    - keyUsage: {{ x509.cert.keyUsage|default("critical cRLSign, keyCertSign") }}
    # (ex.) hash
    - subjectKeyIdentifier: {{ x509.cert.subjectKeyIdentifier|default("hash") }}
    # (ex.) keyid,issuer:always
    - authorityKeyIdentifier: {{ x509.cert.authorityKeyIdentifier|default("keyid,issuer:always") }}
    # (ex.) 3650
    - days_valid: {{ x509.cert.days_valid|default(3650) }}
    # (default:  30), set to 0 to disable auto-rotation
    {{ "- days_remaining: " ~ x509.cert.days_remaining if x509.cert.days_remaining|default(None) is not none else "" }}
    # (ex.) True
    - backup: {{ x509.cert.backup|default(True) }}
    {{ "- group: " ~ x509.cert.crypto_group if x509.cert.crypto_group|default(None) is not none else "" }}
    {{ "- mode: " ~ x509.cert.file_mode if x509.cert.file_mode|default(None) is not none else "" }}
    {%- if 'key' in x509 %}
    - require:
      - x509: "dc61e810-41a3-4a08-8245-32606e2ee733--?index0={{ loop.index0 }}"
    {%- endif %}
{%- endif %}
{%- endfor %}
{%- endif %}



## EOF
