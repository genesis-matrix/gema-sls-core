##
##
##



##_META:
##  purpose: supplemental software and setup in support of docker install
##



## <JINJA>
{%- set pkg_lst = [
        'docker-forward-journald',
        'oci-register-machine',
        'oci-systemd-hook'
        ]
%}
## </JINJA>



#
{%- for pkg in pkg_lst %}
"5252D980-EF29-41E4-B2F7-47C07416A37C--?pkg={{ pkg }}":
  pkg.installed:
    - name: {{ pkg }}
{%- endfor %}



## EOF
