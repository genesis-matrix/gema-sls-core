##
##
##



##_META:
##  refs:
##    - http://www.tecmint.com/install-google-chrome-on-redhat-centos-fedora-linux/
##



## <JINJA>
{%- set var = {
        "repo_name": salt['pillar.get']('', 'google-chrome'),
        "uri_repo_baseurl": salt['pillar.get']('', 'http://dl.google.com/linux/chrome/rpm/stable/$basearch'),
        "uri_repo_gpgkey": salt['pillar.get']('', 'https://dl-ssl.google.com/linux/linux_signing_key.pub'),
        "repo_enabled": salt['pillar.get']('', 1),
        "repo_gpgcheck": salt['pillar.get']('', 1),
        }
%}
## </JINJA>



# note
{#
--- # realized file at /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
#}



#
"1D3BC58C-5396-422A-B56C-92DD914831D4":
  pkgrepo.managed:
    - name: {{ var['repo_name'] }}
    - baseurl: {{ var['uri_repo_baseurl'] }}
    - gpgkey: {{ var['uri_repo_gpgkey'] }}
    - enabled: {{ var['repo_enabled'] }}
    - gpgcheck: {{ var['repo_gpgcheck'] }}



## EOF
