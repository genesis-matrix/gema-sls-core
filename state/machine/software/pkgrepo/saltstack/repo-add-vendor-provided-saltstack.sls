##
##

## Jinja
{% set osmajor = salt['grains.get']('osmajorrelease') %}
##

#
## Add Repo, for RHEL Family by Release Major Version
{% if salt['grains.get']('os_family') == 'RedHat' and osmajor in [5, 6, 7] %}
#+HINT: Add the Saltstack repo config.
"40db8356-4e9b-43b4-83f3-2a1532a5e4da":
  cmd.run:
    - name: yum-config-manager --add-repo https://repo.saltstack.com/yum/rhel{{ osmajor }}/saltstack-rhel{{ osmajor }}.repo
#+HINT: Update packages using 'default = yes' in order to acquire and mark the repo keys trusted.
"144be4c2-3136-4270-bfc1-d626ae77c932":
  pkg.uptodate


{% endif %}