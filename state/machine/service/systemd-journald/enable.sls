##
##
##



##_META:
##



## <JINJA>
{%- set pkgname_systemd_journald = "systemd" %}
{%- set uri_journald_conf = "/etc/systemd/journald.conf" %}
## </JINJA



#
"A83861EF-CFC4-4833-9FD5-E0046EF9D0AC":
  pkg.installed:
    - name: {{ pkgname_systemd_journald }}



#
"CBAE1DC4-93BB-4C15-9FD0-F3140E4DA6C4":
  file.managed:
    - name: {{ uri_journald_conf }}
    - source: salt://assets/tmpl/jinja/systemd-journald-config
    - defaults:
        # to set the iterable template override variables
        defaults_dict: {'Storage': 'persistent'}
    - template: jinja



#
"4DBD49CD-2E22-4796-B7BF-FD864E2342B6":
  service.running:
    - name: systemd-journald
    - restart: True
    - enable: True
    - init_delay: 2
    - watch:
      - file: "CBAE1DC4-93BB-4C15-9FD0-F3140E4DA6C4"



## EOF
