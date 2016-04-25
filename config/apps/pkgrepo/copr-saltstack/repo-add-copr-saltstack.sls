##
## 
## NB: suitable for CentOS versions 5,

## Cent5
## - https://copr.fedoraproject.org/coprs/saltstack/salt-el5/
{% if grains['os'] in ('RedHat', 'CentOS') and salt['grains.get']('osmajorrelease', 'unknown') == '5' %}
saltstack-copr-el5:
  pkgrepo.managed:
    - humanname: Copr repo for salt owned by saltstack
    - baseurl: https://copr-be.cloud.fedoraproject.org/results/saltstack/salt-el5/epel-5-$basearch/
    - gpgkey: https://copr-be.cloud.fedoraproject.org/results/saltstack/salt-el5/pubkey.gpg
    - gpgcheck: 1
    - skip_if_unavailable: True
    - enabled: 1
{% endif %}

## Cent 6 & 7
## - https://copr.fedoraproject.org/coprs/saltstack/salt/
{% if grains['os'] in ('RedHat', 'CentOS', 'Fedora') %}
  {% if grains['os'] == 'Fedora' %}
    {% set repotype = 'fedora' %}
  {% else %}
    {% set repotype = 'epel' %}
  {% endif %}
saltstack-copr:
  pkgrepo.managed:
    - humanname: Copr repo for salt owned by saltstack
    - baseurl: http://copr-be.cloud.fedoraproject.org/results/saltstack/salt/{{ repotype }}-{{ salt['grains.get']('osmajorrelease', 'unknown') }}-$basearch/
    - gpgkey: https://copr-be.cloud.fedoraproject.org/results/saltstack/salt/pubkey.gpg
    - gpgcheck: 1
    - skip_if_unavailable: True
    - enabled: 1
{% endif %}