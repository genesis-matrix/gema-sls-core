##
##
##



#+TODO:
{% if grains['os_family'] == 'RedHat' %}
# pkgrepo-install-epel:
"71FAD835-C681-41D1-B681-EAC58C0A444C":
  pkg.installed:
    - name: epel-release
#  pkgrepo.managed::
#    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch
#    - humanname: epel
#    - enabled: 1
#    - consolidate: true
{% endif %}
