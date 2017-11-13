##
##
##



##_META:
##  refs:
##    - http://docs.splunk.com/Documentation/Forwarder/6.5.2/Forwarder/Configuretheuniversalforwarder
##    - http://docs.splunk.com/Documentation/Forwarder/6.5.2/Forwarder/Configureforwardingwithoutputs.conf
##
##



## <JINJA>
{%- set var = {
        'uf_version': '6.5.2',
        'uf_releasehash': '67571ef4b87d',
        'uf_pkg_type': 'rpm',
        'uf_target_os_type': 'linux',
        'uf_target_os_version': '2.6',
        'uf_target_arch': 'x86_64',
        'uf_product_vendor': 'splunk',
        'uf_product_name': 'universalforwarder',
        'uf_download_title': '',
        'uf_download_baseurl': 'https://www.splunk.com/bin/splunk/DownloadActivityServlet',
        'uf_download_basename': 'splunkforwarder'
       }
%}
{# ex. 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.5.2&product=universalforwarder&filename=splunkforwarder-6.5.2-67571ef4b87d-linux-2.6-x86_64.rpm&wget=true' #}
{%- set uri_installmedia_uf = {
        'remote': "%s?architecture=%s&platform=%s&version=%s&product=%s&filename=%s-%s-%s-%s-%s-%s.%s&wget=true"|format(
                var['uf_download_baseurl'],
                var['uf_target_arch'],
                var['uf_target_os_type'],
                var['uf_version'],
                var['uf_product_name'],
                var['uf_download_basename'],
                var['uf_version'],
                var['uf_releasehash'],
                var['uf_target_os_type'],
                var['uf_target_os_version'],
                var['uf_target_arch'],
                var['uf_pkg_type']),
        'local': "%s-%s-%s-%s-%s-%s.%s"|format(
                var['uf_download_basename'],
                var['uf_version'],
                var['uf_releasehash'],
                var['uf_target_os_type'],
                var['uf_target_os_version'],                
                var['uf_target_arch'],
                var['uf_pkg_type'])
        }
%}
## </JINJA>



#
{#
Full Example: |
  wget -O splunkforwarder-6.5.2-67571ef4b87d-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.5.2&product=universalforwarder&filename=splunkforwarder-6.5.2-67571ef4b87d-linux-2.6-x86_64.rpm&wget=true'
#}



#
"EC72E1A3-06D3-47B6-A84F-FE37898C0DB7":
  pkg.installed:
    - name: wget


#
"AA64702F-96E5-4447-A04E-559C41A0BF50":
  cmd.run:
    - name: wget -O /tmp/"{{ uri_installmedia_uf['local'] }}" "{{ uri_installmedia_uf['remote'] }}"
    - creates: "/tmp/{{ uri_installmedia_uf['local'] }}"



#
"52D0FC7C-5FA9-41E7-9F15-6D5D39057A31":
  cmd.run:
    - name: yum install -y /tmp/{{ uri_installmedia_uf['local'] }}
    - unless: rpm -q {{ var['uf_download_basename'] }}



## EOF
