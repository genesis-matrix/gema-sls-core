##
##
##



##_META:
##  todo:
##    - [ ] make this state more templatized with tidier and more extensive pillar/variables use
##    - [ ] implement pre-shared key security between client and server
##    - [ ] break this state into component parts: setup server, setup agent and connect securely to server, administrative/operational server tasks for general usefulness
##  refs:
##    - https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-zabbix-to-securely-monitor-remote-servers-on-centos-7
##    - http://repo.zabbix.com/
##



## <JINJA>
{%- set var = {
        'uri_swrepo_cent7': 'http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/',
        'uri_installmedia_cent7': 'http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm',
        'db_host': 'localhost',
        'db_connection_user': 'root',
        'db_connection_password': 'd!rtyd0g',
        'initial_db_connection_user': 'root',
        'initial_db_connection_password': ''
        }
%}
## </JINJA>



# add the zabbix repo pkg
"B7D2FC3C-9A7B-44F4-A2E7-2DEBF14BC8A8":
  cmd.run:
    - name: yum install -y {{ var['uri_installmedia_cent7'] }}
    - creates: /etc/yum.repos.d/zabbix.repo
  


# install server pkgs w/ MySQL/MariaDB support
"59ABDA23-49D8-43AD-86AE-E5E407DF7966":
  pkg.installed:
    - pkgs:
      - zabbix-server-mysql
      - zabbix-web-mysql



# install mysql server and supporting python modules
"ADFA78A7-0821-4367-A71D-98BC7C0A062D":
  pkg.installed:
    - pkgs:
      - mariadb-server
      - MySQL-python
      # provides 'mysql' client
      - mariadb
  


#
## section:
##   id: "9C0F5211-FBA1-4BCB-AF09-3D8419F8F06D"
##   purpose: prep mysql for normal use
##   desc: |
##     You can set a password for root accounts.
##     You can remove root accounts that are accessible from outside the local host.
##     You can remove anonymous-user accounts.
##     You can remove the test database (which by default can be accessed by all users, even anonymous users), and privileges that permit anyone to access databases with names that start with test_.
##   actions:
##     - start rdbms
##     - remove test database
##     - set root password
##   refs:
##     - https://dev.mysql.com/doc/refman/5.7/en/mysql-secure-installation.html
#



# start rdbms
"C16D3365-9969-47D0-8D87-66FB193162B2":
  service.running:
    - name: mariadb



# set root@localhost password
"41E63AC4-9CAE-4AD9-879B-8166D9B4CAD5":
  mysql_user.present:
    - name: 'root'
    - host: localhost
    - password: '{{ var["db_connection_password"] }}'
    - connection_user: '{{ var["initial_db_connection_user"] }}'
    - connection_pass: '{{ var["initial_db_connection_password"] }}'



# remove all empty accounts
"E698151A-FF58-4E4B-8B62-7EA2E70BF769":
  mysql_user.absent:
    - name: ''
    - connection_user: '{{ var["db_connection_user"] }}'
    - connection_pass: '{{ var["db_connection_password"] }}'



# remove all non-local root accounts
{% for user_dict in salt['mysql.user_list'](connection_user=var['db_connection_user'], connection_pass=var['db_connection_password']) if (user_dict.User in ['root'] and user_dict.Host not in ['127.0.0.1', '::1', 'localhost', '']) %}
"CFBAE5CF-AD19-48DA-88CC-0BE7608A7EE8--?user={{ user_dict.User }}--?host={{ user_dict.Host }}":
  mysql_user.absent:
    - name: '{{ user_dict.User }}'
    - host: '{{ user_dict.Host }}'
    - connection_user: '{{ var["db_connection_user"] }}'
    - connection_pass: '{{ var["db_connection_password"] }}'
{% endfor %}



# remove all test database
{% for db_schema in salt['mysql.db_list'](connection_user=var['db_connection_user'], connection_pass=var['db_connection_password']) if db_schema.startswith('test_') %}
"0739160D-64FE-4EBB-9633-B88C1C25872F--?db_schema={{ db_schema }}":
  mysql_database.absent:
    - name: '{{ db_schema }}'
    - host: '{{ var["db_host"] }}'
    - connection_user: '{{ var["db_connection_user"] }}'
    - connection_pass: '{{ var["db_connection_password"] }}'
    - connection_charset: utf8
{% endfor %}
  


# create zabbix database schema
"CADA03F6-4801-4E70-AE64-A905C5FEE305":
  mysql_database.present:
    - name: zabbix
    - host: '{{ var["db_host"] }}'
    - connection_user: '{{ var["db_connection_user"] }}'
    - connection_pass: '{{ var["db_connection_password"] }}'
    - connection_charset: utf8
  


# create zabbix user
"46D69245-5A0E-40C2-8C58-07F06F44F779":
  mysql_user.present:
    - name: zabbix
    - password: '{{ var["db_connection_password"] }}'
    - host: localhost
    - connection_user: '{{ var["db_connection_user"] }}'
    - connection_pass: '{{ var["db_connection_password"] }}'
    - connection_charset: utf8



# create grants for zabbix user on zabbix database
"5346917C-2B79-42EC-9D7F-0DEE7ABD0C1A":
  mysql_grants.present:
    - grant: all
    - database: zabbix.*
    - user: zabbix
    - host: localhost
    - connection_user: '{{ var["db_connection_user"] }}'
    - connection_pass: '{{ var["db_connection_password"] }}'
    - connection_charset: utf8
    
    

# run script to generate zabbix db structures
{% if 'users' not in salt['mysql.db_tables']("zabbix", connection_user=var['db_connection_user'], connection_pass=var['db_connection_password']) %}
"AEA8C44E-9EC7-4834-A542-0D8B074851EB":
  cmd.run:
    - name: find /usr/share/doc/zabbix-server-* -type f -iname create.sql.gz -exec zcat {} \; | mysql -uzabbix -p"{{ var['db_connection_password'] }}" zabbix
{% endif %}



# add zabbix db user account to config file
"3A84B2DE-4B42-4C56-88B1-C8583F213B7B":
  cmd.run:
    - name: sed -i.bkup "s/# DBPassword=/DBPassword=\'{{ var['db_connection_password'] }}\'/" /etc/zabbix/zabbix_server.conf
    - onlyif: grep -qsv "^DBPassword=" /etc/zabbix/zabbix_server.conf



#
## </section>
#



# set TZ in Zabbix website config
"349ED144-1EE9-4A4D-83F2-AEA04BF51016":
  cmd.run:
    - name: sed -i.bkup 's/# php_value date.timezone Europe\/Riga/php_value date.timezone America\/New_York/' /etc/httpd/conf.d/zabbix.conf



# install agent to monitor the server
"6E89F7B8-1663-47F7-98B8-B2985D493241":
  pkg.installed:
    - name: zabbix-agent



# restart the httpd service
"0D4D595A-7B37-468F-827F-9B8EE3A2F091":
  service.running:
    - name: httpd
    - restart: true
    - enable: true
    - watch:
        cmd: "349ED144-1EE9-4A4D-83F2-AEA04BF51016"
        
        



#
"B212D726-9987-4DD4-8325-88BAF6AE0C2E":
  service.running:
    - name: zabbix-server
    - enable: true



# {# You should be able to connect to the server now at,
http://<server-name>/zabbix by using the default username % password:
Admin %zabbix

First up, add hosts to monitor. The tutorial explains this part of the
process starting from here:
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-zabbix-to-securely-monitor-remote-servers-on-centos-7#step-6-—-adding-the-new-host-to-the-zabbix-server
#}



#
"751579D1-142D-4725-B57A-DBF23BEED92A":
  service.running:
    - name: zabbix-agent
    - enable: true


    
## EOF
