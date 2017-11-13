##
##
##



##_META:
##



## <JINJA>
{# Java Install Config #}
{% set uri_oracle_java_installmedia_base = "https://mirror.its.sfu.ca/mirror/CentOS-Third-Party/NSG/common/x86_64/" %}
{% set uri_oracle_java_installmedia_file_lst = ["jdk", "-", "7", "u80", "-", "linux", "-", "x64", ".rpm"] %}
{% set uri_oracle_java_installmedia = uri_oracle_java_installmedia_base ~ uri_oracle_java_installmedia_file_lst|join("") %}
{# Sysctl Configs #}
{% set sysctl_dct = {
        "net.ipv4.tcp_tw_reuse": "1",
        "net.ipv4.tcp_tw_recycle": "1",
        "net.core.somaxconn": "1024",
        "net.core.rmem_max": "262144",
        "vm.max_macp_count": "768000",
        "net.core.wmem_max": "262144"
        }
%}
## </JINJA>



# openjdk is absent
"AF778B1F-36D9-4521-83A8-6D740A65B9B1":
  pkg.removed:
    - name: java-*-openjdk*



# install oracle jdk
"5CDB93B5-A660-478F-A57C-2E879ECA3BBD":
  cmd.run:
    - name: yum install -y {{ uri_oracle_java_installmedia }}
    - unless: rpm -qa {{ uri_oracle_java_installmedia_file_lst[0] ~ uri_oracle_java_installmedia_file_lst[1] ~ "1." ~ uri_oracle_java_installmedia_file_lst[2] ~ ".0_" ~ uri_oracle_java_installmedia_file_lst[3] }}



# service ntpd should be installed, enabled and running
"F61F0B0B-CCDB-4438-A241-E2DA3916F996":
  pkg.installed:
    - name: ntp
  service.running:
    - name: ntpd
    - enable: True


    
# deactivate selinux (requires subsequent reboot)
"438A39BE-4B79-4AE4-AFF4-81D765078DC4":
  selinux.mode:
    - name: disabled



# finally, promprt for reboot if the selinux status changed
"64F4CEC4-2587-43CA-83A2-763487519BC6":
  module.run:
    - name: system.reboot
    - test: True
    - onchanges:
      - selinux: "438A39BE-4B79-4AE4-AFF4-81D765078DC4"
    - order: last



#
#"1F33E223-6B7A-4454-ACF4-B5E404E2881D":
  



## EOF

