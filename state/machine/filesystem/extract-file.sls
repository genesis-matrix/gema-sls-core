##
##
##



##_META:
##  purpose: extract file
##  refs:
##



## <JINJA>
{% set lookup = salt['pillar.get']('lookup:sls_path:' ~ sls, '') %}
{%- set var = {
  "name": salt['pillar.get']('',''),
  "source": salt['pillar.get']('', ''),
  "source_hash": salt['pillar.get']('', 'None'),
  "source_hash_name": salt['pillar.get']('', None),
  "source_hash_update": salt['pillar.get']('', False),
  "skip_verify": salt['pillar.get']('', False),
  "password": salt['pillar.get']('', None),
  "options": salt['pillar.get']('', None),
  "list_options": salt['pillar.get']('', None),
  "force": salt['pillar.get']('', False),
  "overwrite": salt['pillar.get']('', False),
  "clean": salt['pillar.get']('', False),
  "user": salt['pillar.get']('', None),
  "group": salt['pillar.get']('', None),
  "if_missing": salt['pillar.get']('', None),
  "keep": salt['pillar.get']('', False),
  "trim_output": salt['pillar.get']('', False),
  "use_cmd_unzip": salt['pillar.get']('', None),
  "extract_perms": salt['pillar.get']('', True),
  "enforce_toplevel": salt['pillar.get']('', True),
  "enforce_ownership_on": salt['pillar.get']('', None),
  "archive_format": salt['pillar.get']('', None)
%}
## </JINJA>



#
"EFB5B09E-B5A8-49A6-BFD6-4E75C6FB21FE--?var={{ var }}":
  archive.extracted:
    - name: {{ var["name"] }}
    - source: {{ var["source"] }}
    - skip_verify: {{ var["skip_verify"] }}
    - archive_format: {{ var["archive_format"] }}
    - options: {{ var["options"] }}
    - user: {{ var["user"] }}
    - group: {{ var["group"] }}
    - name: {{ var["name"] }}
    - source: {{ var["source"] }}
    - source_hash: {{ var["source_hash"] }}
    - source_hash_name: {{ var["source_hash_name"] }}
    - source_hash_update: {{ var["source_hash_update"] }}
    - skip_verify: {{ var["skip_verify"] }}
    - password: {{ var["password"] }}
    - options: {{ var["options"] }}
    - list_options: {{ var["list_options"] }}
    - force: {{ var["force"] }}
    - overwrite: {{ var["overwrite"] }}
    - clean: {{ var["clean"] }}
    - user: {{ var["user"] }}
    - group: {{ var["group"] }}
    - if_missing: {{ var["if_missing"] }}
    - keep: {{ var["keep"] }}
    - trim_output: {{ var["trim_output"] }}
    - use_cmd_unzip: {{ var["use_cmd_unzip"] }}
    - extract_perms: {{ var["extract_perms"] }}
    - enforce_toplevel: {{ var["enforce_toplevel"] }}
    - enforce_ownership_on: {{ var["enforce_ownership_on"] }}
    - archive_format: {{ var["archive_format"] }}



## EOF
