##
##
##



##_META
##



## <JINJA>
## </JINJA>



# notes on Implementation Status
{#
references:
  - https://docs.fluentbit.io/manual/installation/redhat_centos:
    - pkg: td-agent-bit
    - pkgrepo: |
       [td-agent-bit]
       name = TD Agent Bit
       baseurl = http://packages.fluentbit.io/centos/7
       gpgcheck=1
       gpgkey=http://packages.fluentbit.io/fluentbit.key
       enabled=1
#}



#
"345bce3e-8c86-4cf8-909c-cfa521f8ad1b":
  pkgrepo.managed:
    - name: td-agent-bit
    - humanname: TD Agent Bit
    - baseurl: http://packages.fluentbit.io/centos/7
    - gpgkey: http://packages.fluentbit.io/fluentbit.key
    - gpgcheck: 1



## EOF
