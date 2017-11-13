##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
{#-
## [Webmin]
## name=Webmin Distribution Neutral
## #baseurl=http://download.webmin.com/download/yum
## mirrorlist=http://download.webmin.com/download/yum/mirrorlist
## enabled=1
#}



#
"AD31D868-F53E-463D-B6E4-6580B2DDE335":
  pkgrepo.managed:
    - humanname: Webmin Distribution Neutral
    - name: Webmin
    - mirrorlist: http://download.webmin.com/download/yum/mirrorlist
    - enabled: 1
    #- key_url: wget http://www.webmin.com/jcameron-key.asc
    #- file: /etc/yum.repos.d/webmin.repo



# add upstream repo key
"EDAE6D88-4B30-4738-B1D3-EDFDF3E41B89":
  cmd.run:
    - name: wget http://www.webmin.com/jcameron-key.asc && rpm --import jcameron-key.asc
    - unless: rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n' | grep -qse 'gpg-pubkey-11f63c51-3c7dc11d --> gpg(Jamie Cameron <jcameron@webmin.com>)'



## EOF
