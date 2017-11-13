##
##
##



##_META:
##  purpose: setup Atlassian Bamboo
##  refs:
##    install:
##      - docs: https://confluence.atlassian.com/bamboo/installing-bamboo-on-linux-289276792.html#InstallingBambooonLinux-1.DownloadBamboo
##      - media: https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.15.3.tar.gz
##



## <JINJA>
{%- set install_version = "5.15.3" %}
{%- set install_vendor = "atlassian" %}
{%- set install_productname = "bamboo" %}
{# nb, non-parameterized URL is "https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.15.3.tar.gz" #}
{%- set uri_installmedia = "https://www.atlassian.com/software/" ~ install_productname ~ "/downloads/binary/" ~ install_vendor ~ "-" ~ install_productname ~ "-" ~ install_version ~ ".tar.gz" %}
{%- set hash_uri_installmedia = "sha256=cf998699c16a5f7653e1f76c6e28ec2ff04ca866cf904264be472c0e926aeb60" %}
{%- set uri_expand_to = "/opt/" ~ install_vendor %}
{%- set install_user = install_productname|lower() %}
{%- set install_group = install_productname|lower() %}
{%- set uri_user_homedir = "/srv/" ~ install_vendor ~ "/" ~ install_user %}
## </JINJA>



#
include:
  - state.machine.software.java.install-jdk



#
"386AF510-55E0-4DD8-A612-79CD1A14903C--?install_user={{ install_user }}":
  user.present:
    - name: {{ install_user }}
    - home: {{ uri_user_homedir }}
    - gid_from_name: True
    - system: True



# notes
{#
 - observes the archive.extracted stanza would work the first time, then error with message "unable to list files" with each subsequent time
 - muses this may be caused by use of a source url with a 301 redict
 - observes this was fixed by adding a source_hash clause
#}



#
"EFB5B09E-B5A8-49A6-BFD6-4E75C6FB21FE":
  archive.extracted:
    - name: {{ uri_expand_to }}
    - source: {{ uri_installmedia }}
    {% if hash_uri_installmedia %}
    - source_hash: {{ hash_uri_installmedia }}
    {% else %}
    - skip_verify: True
    {% endif %}
    - archive_format: tar
    - options: z
    - user: {{ install_user }}
    - group: {{ install_group }}



# update symlink "latest"
"7649DAB0-C41F-460F-9A08-1303E33AEBEA":
  file.symlink:
    # name: location of the symlink to create
    - name: {{ uri_expand_to }}/{{ install_vendor }}-{{ install_productname }}-latest
    # target: the location that the symlink points to
    - target: {{ uri_expand_to }}/{{ install_vendor }}-{{ install_productname }}-{{ install_version }}



# create symlink "current" if doesn't exist
"8CDE6E1D-C3E5-47E3-80DA-C1F99329C443":
  file.symlink:
    - name: {{ uri_expand_to }}/{{ install_vendor }}-{{ install_productname }}-current
    - target: {{ install_vendor }}-{{ install_productname }}-latest



# notes
{#-
Create the home directory
Specify your Bamboo home directory, where your Bamboo data is stored, before you run Bamboo for the first time.
a) Create your Bamboo home directory (without spaces in the name).
Note: You should not create your Bamboo home directory inside the   <Bamboo installation directory>  — they should be entirely separate locations. If you do put the home directory in the  <Bamboo installation directory>  it will be overwritten, and lost, when Bamboo is upgraded. 
b) Open <Bamboo installation directory>/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
c) Uncomment the  bamboo.home  line.
d) Provide the absolute path absolute path to your home directory.
Example: 
bamboo.home= /home/nathan/bamboo/bamboo-home
#}



"C971A46F-2D26-477D-975C-1B42ECBAFACC":
  file.append:
    - name: {{ uri_user_homedir }}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
    - text: ""


    
## EOF
