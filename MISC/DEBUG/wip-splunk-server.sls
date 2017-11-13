##
##
##



##_META:
##  notes:
##    - the free (w/ registration) demo version of Splunk is limited to 500mb/day
##    - default creds: admin % changeme
##  refs:
##    - download page:
##      - https://www.splunk.com/en_us/download/splunk-enterprise.html
##    - install instructions:
##      - http://docs.splunk.com/Documentation/Splunk/6.5.1/Installation/InstallonLinux
##    - start-up instructions:
##      - http://docs.splunk.com/Documentation/Splunk/6.5.1/Installation/StartSplunkforthefirsttime
##    - start-up demo: |
##        [root@splnk-syslog-d1 splunk]# bin/splunk start --answer-yes --no-prompt --accept-license
##        
##        This appears to be your first time running this version of Splunk.
##        Copying '/opt/splunk/etc/openldap/ldap.conf.default' to '/opt/splunk/etc/openldap/ldap.conf'.
##        Generating RSA private key, 1024 bit long modulus
##        .............++++++
##        ...........................++++++
##        e is 65537 (0x10001)
##        writing RSA key
##        
##        Generating RSA private key, 1024 bit long modulus
##        ................................++++++
##        ................................++++++
##        e is 65537 (0x10001)
##        writing RSA key
##        
##        Moving '/opt/splunk/share/splunk/search_mrsparkle/modules.new' to '/opt/splunk/share/splunk/search_mrsparkle/modules'.
##        
##        Splunk> See your world.  Maybe wish you hadn't.
##        
##        Checking prerequisites...
##        Checking http port [8000]: open
##        Checking mgmt port [8089]: open
##        Checking appserver port [127.0.0.1:8065]: open
##        Checking kvstore port [8191]: open
##        Checking configuration...  Done.
##        Creating: /opt/splunk/var/lib/splunk
##        Creating: /opt/splunk/var/run/splunk
##        Creating: /opt/splunk/var/run/splunk/appserver/i18n
##        Creating: /opt/splunk/var/run/splunk/appserver/modules/static/css
##        Creating: /opt/splunk/var/run/splunk/upload
##        Creating: /opt/splunk/var/spool/splunk
##        Creating: /opt/splunk/var/spool/dirmoncache
##        Creating: /opt/splunk/var/lib/splunk/authDb
##        Creating: /opt/splunk/var/lib/splunk/hashDb
##        Checking critical directories...	Done
##        Checking indexes...
##        Validated: _audit _internal _introspection _telemetry _thefishbucket history main summary
##        Done
##        New certs have been generated in '/opt/splunk/etc/auth'.
##        Checking filesystem compatibility...  Done
##        Checking conf files for problems...
##        Done
##        Checking default conf files for edits...
##        Validating installed files against hashes from '/opt/splunk/splunk-6.5.2-67571ef4b87d-linux-2.6-x86_64-manifest'
##        All installed files intact.
##        Done
##        All preliminary checks passed.
##        
##        Starting splunk server daemon (splunkd)...  
##        Generating a 1024 bit RSA private key
##        .........................++++++
##        .++++++
##        writing new private key to 'privKeySecure.pem'
##        -----
##        Signature ok
##        subject=/CN=splnk-syslog-d1/O=SplunkUser
##        Getting CA Private Key
##        writing RSA key
##        Done
##                                                                   [  OK  ]
##        
##        Waiting for web server at http://127.0.0.1:8000 to be available... Done
##        
##        
##        If you get stuck, we're here to help.  
##        Look for answers here: http://docs.splunk.com
##        
##        The Splunk web interface is at http://splnk-syslog-d1:8000
##        
##        [root@splnk-syslog-d1 splunk]#
##



## <JINJA>
{% set lookup = salt['pillar.get']('lookup:sls_path:' ~ sls) %}
{% set method = 'tgz' %}
{% set uris = {'installer_rpm': '', 'installer_deb': '', 'installer_tgz': 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.5.2&product=splunk&filename=splunk-6.5.2-67571ef4b87d-Linux-x86_64.tgz&wget=true'} %}
{% set var = {'uri_splunk_home': '/opt/splunk'} %}
## </JINJA>



{% if method == "tgz" %}
# download and install
"BDAE061C-52A2-4884-85BE-3C1654A28C81":
  cmd.run:
    - creates: {{ var['uri_splunk_home'] }}/bin/splunk
    - name: |
        cd $(mktemp -d) && wget -O splunk-enterprise-server.tgz '{{ uris["installer_" ~ method] }}' && mkdir -p /opt && tar -xzf splunk-enterprise-server.tgz -C /opt
{% endif %}



# install qnd splunk service unit
"F2216691-E027-4162-B2D7-8D8F2904A9B7":
  file.managed:
    - name: /etc/systemd/system/splunkd.service
    - contents: |
        [Unit]
        Description=splunk service unit

        [Service]
        Environment=SPLUNK_HOME={{ var['uri_splunk_home'] }}
        Type=forking
        ExecStart={{ var['uri_splunk_home'] }}/bin/splunk start --no-prompt --answer-yes --accept-license
        ExecStop={{ var['uri_splunk_home'] }}/bin/splunk stop

        [Install]
        WantedBy=multi-user.target



# start splunk
"DADEB28C-CD22-426D-A0E0-034FDF93169E":
  service.running:
    - name: splunkd



## EOF
