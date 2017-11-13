##
##
##



##_META:
##  refs:
##    - for Jira testing, a developer license is requested: 
##    - timebomb UPM add-on licensing for short-term evaluation: https://developer.atlassian.com/market/add-on-licensing-for-developers/timebomb-licenses-for-testing
##    - install_docs: https://confluence.atlassian.com/adminjiraserver071/installing-jira-applications-802592161.html
##    - install_media: https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.3.0-x64.bin
##    - unattended install w/ an answerfile: https://confluence.atlassian.com/adminjiraserver071/unattended-installation-855475683.html
##



## <JINJA>
{%- set var = {
        'uri_install_media': 'https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.3.0-x64.bin',
        'uri_pillar_varfile': salt['pillar.get']('', '/tmp/jira_default__response.varfile'),
        'uri_deploy_varfile': '/tmp/jira-response.varfile'
        }
%}
## </JINJA>



# place install media
"6544D0C1-CFE2-49C9-86E9-F7B91E547466":
  file.managed:
    - name: /tmp/installmedia-jira-v7.3.0.bin
    - mode: 750
    - source: {{ var['uri_install_media'] }}
    - source_hash: sha256=4e8ed1a8f480a083ad8025e0998795e6613e90cf1e67c7b1e2ab65facf327701



# place answer file (for non-interactive install)
"53150609-A082-425B-9F7C-4C85C6C9FFA2":
  file.managed:
    - name: {{ var['uri_deploy_varfile'] }}
    - pillar_contents: {{ var['uri_pillar_varfile'] }}



# perform "unattended" install using values from varfile
"B488E302-655A-4596-AA0F-E07AF6FB4252":
  cmd.run:
    - name: /tmp/installmedia-jira-v7.3.0.bin -q -varfile {{ var['uri_deploy_varfile'] }}
    - creates: /opt/atlassian



# ensure firewalld is active
"29DE9568-000D-438C-B473-0B8863E688FE":
  service.running:
    - name: firewalld



# setup firewalld service 
"92D5E4BB-51B7-480C-A7F7-F9E1029F1706":
  firewalld.service:
    - name: jira
    - ports:
      - 80/tcp
      - 443/tcp



# setup port forwarding to 80 from 8080
"087E63C8-30C6-44DC-9A35-85EA9ABD8C0C":
  firewalld.present:
    - name: public
    - masquerade: True
    - services: jira
    - port_fwd:
      - 80:8080:tcp



# Finally, head to http://localhost:<port> to finish setting up JIRA.



## EOF
