##
##
##


base:
  # apply basics states



  # apply hypervisor integration states
  "virtual:{{ salt['grains.get']('virtual') }}":
    - match: grain
    ##+NB: the 'virtual' detection appears to be unreliable during some stages of the packer image build process
    #+ORIG: - MISC.PROVISION.hypervisor-integration-{{ salt['grains.get']('virtual') | lower() }}
    - MISC.PROVISION.hypervisor-integration-vmware


  # apply provision states
  {% for element in salt['grains.get']('PROVISION') %}
  'PROVISION:{{ element }}':
    - match: grain
    - MISC.PROVISION.{{ element }}
  {% endfor %}



  # apply mahine role states
  {% for element in salt['grains.get']('machine_role') %}
  'machine_role:{{ element }}':
    - match: grain
    - discrete.machine_role.{{ element }}
  {% endfor %}



  # apply cleanup a/o hand-off prep states
  {% for element in salt['grains.get']('provision_target') %}
  'provision_target:{{ element }}':
    - match: grain
    - MISC.PROVISION.provision-target-{{ element }}
  {% endfor %}  



  # clean up a/ uninstall provisioning tooling
  '*':
    - MISC.PROVISION.purge-masterless-salt



