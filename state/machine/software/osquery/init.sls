##
##
##



##_META:
##  Applicability: CentOS v6 and v7
##



## <JINJA>
{% set uri_repo = salt['grains.filter_by']({
  'CentOS Linux-7': "https://osquery-packages.s3.amazonaws.com/centos7/noarch/osquery-s3-centos7-repo-1-0.0.noarch.rpm",
  'CentOS Linux-6': "https://osquery-packages.s3.amazonaws.com/centos6/noarch/osquery-s3-centos6-repo-1-0.0.noarch.rpm"},
  grain='osfinger')
%}
## </JINJA>



#
{%- if uri_repo %}
"489A1910-985B-4511-8C28-5AE960949A7E":
  cmd.run:
    - name: 'rpm -ivh {{ uri_repo }}'
    - creates: /etc/yum.repos.d/osquery-s3-centos7.repo
{%- endif %}



#
"C0ACB6DF-0267-419F-A2CE-88048109755B":
  pkg.installed:
    - name: osquery



## EOF