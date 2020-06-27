##
##


## DESC:
##  - intended to emulate a/ thus replace the =myqsl_secure_installation= script
##  - https://www.hackviking.com/server-and-dekstop-and-3rd-part-apps/auto-config-mysql/
##    snippet: |
##      mysql -e "UPDATE mysql.user SET Password=PASSWORD('{input_password_here}') WHERE User='root';"
##      mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
##      mysql -e "DELETE FROM mysql.user WHERE User='';"
##      mysql -e "DROP DATABASE test;"
##      mysql -e "FLUSH PRIVILEGES;"



## <JINJA>
{% set default_root_password = salt['pillar.get']('', '') %}
{% set db_lst = salt['pillar.get']('', []) %}
## </JINJA>



# remove user ''@'localhost'
{%- for db in db_lst %}
"97F3C736-62FC-4124-AD08-863743158850":
  mysql_user.absent:
    - connection_password: {{ default_root_password }}
    - name: "''"
    - host: "'localhost'"
{%- endfor %}



# remove user ''@'%'
{%- for db in db_lst %}
"B3D27889-4905-46E9-805A-805776C79C74":
  mysql_user.absent:
    - connection_password: {{ default_root_password }}
    - name: "''"
    - host: "'%'"
{% endfor %}



# remove user ''@'<machine-id>'
{%- for db in db_lst %}
"3C45E930-618C-4C5C-B327-2B363006CF57":
  mysql_user.absent:
    - connection_password: {{ default_root_password }}
    - name: "''"
    - host: "'{{ salt['grains.get']('host') |lower }}'"
{% endfor %}



# remove 'test' database
{% for db in db_lst %}
"0803AC55-3115-42F8-BBF5-DDDF153EEC4D":
  mysql_database.absent:
    - connection_password: {{ default_root_password }}
    - name: 'test'
{% endfor %}



## EOF
