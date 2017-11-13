##
##
##



##_META:
##  Purpose: apply hypervisor integration states
##  Description:
##    - the 'virtual' detection appears to be unreliable during some stages of the packer image build process
##    - as a workaround, the virtual grain is also set in the minion.conf file passed to Packer for provisioning
##    - configs are derived from the grains in the minion.conf file provided to Packer, not from the roster files, which are used by vagrant
##    - 'minion.conf__v00' is for virtualbox, 'minion.conf__v01' is for VMware
##    - this file is seperated from the top_GEMA.sls to ease inclusion of non-idempotent PROVISION-time configuration changes
##    - organized around:
##      - hypervisor
##      - deploy pipeline
##      - provision_states
##      - machine_role
##



#
base:
  # hypervisor integration
  "virtual:{{ salt['grains.get']('virtual', 'physical') | lower() }}":
    - match: grain
    - state.machine.sysint.hypervisor-guest.hypervisor-integration-{{ salt['grains.get']('virtual', 'physical') | lower() }}



  # apply provision states
  {%- for element in salt['grains.get']('provision_states') %}
  'provision_states:{{ element }}':
    - match: grain
    - {{ element }}
  {% endfor %}



  # apply deploy pipeline integration
  {%- for element in salt['grains.get']('deploy_pipeline') %}
  'deploy_pipeline:{{ element }}':
    - match: grain
    - state.machine.sysint.deploy-pipeline.{{ element }}
  {% endfor %}



  # clean up a/ uninstall provisioning tooling
  '* and not G@machine_role:salt_minion':
    - match: compound
    #- state.machine._spec.destroy-all-unique-state-ao-data
    - state.machine.software.salt-minion.purge-masterless-salt



## EOF
