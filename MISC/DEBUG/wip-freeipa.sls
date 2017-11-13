##
##
##



##_META:
##  purpose:
##    - setup FreeIPA for integration testing, learning, and discovery
##  refs:
##    - https://www.freeipa.org/page/Main_Page
##    - https://www.freeipa.org/page/Quick_Start_Guide
##



# <JINJA>
{%- set var = {
        'domain_suffix': salt['pillar.get']('', 'vagrant.test')
        }
%}
# </JINAJ>



#
{#
Prerequisites:
  - The hostname cannot be localhost or localhost6.
  - The hostname must be fully-qualified (ipa.example.com)
  - The hostname must be resolvable.
  - The reverse of address that it resolves to must match the hostname.
#}



#
"C4A3D7D9-99D0-4923-8BE8-EAF16036EE45":
  cmd.run:
    - name: 'cd $(mktemp -d) && tac /etc/hosts > hosts && echo "127.0.0.1    $(hostname --short)  $(hostname --short).{{ var.domain_suffix }}" >> hosts && tac hosts | tee /etc/hosts'
    - unless: 'grep -m1 "127.0.0.1" /etc/hosts | grep -i "$(hostname --short)" | grep -i "$(hostname --short).{{ var.domain_suffix }}"'



## EOF
