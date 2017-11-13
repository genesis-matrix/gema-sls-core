##
##
##



##_META:
##  caveats:
##    - inconsistent default registry
##      - salt expects upstream container repos to be defined in advance
##      - where undefined, it seems, the underlying docker tooling selects https://hub.docker.com
##      - this is a (partially) fixed by:
##        - https://github.com/saltstack/salt/issues/38010
##        - https://github.com/saltstack/salt/issues/28004
##      - so now, the Docker hub is used where no registry is specified
##      - credentials are required to pull when using dockerng.image_present
##      - credentials are not required to pull when using dockerng.running
##  refs:
##    - https://docs.docker.com/engine/reference/commandline/pull/
##



## <JINJA>
{%- set var = {
        'dkr_image_repo': 'hub.docker.com/_'
        }
%}
## </JINJA>



#
include:
  - state.machine.software.docker
  - state.machine.software.docker.installed-aux
  - state.machine.service.docker



#
"81EEF375-D02D-49BC-92A5-6EEC4248378F":
  dockerng.image_present:
    #- name: https://hub.docker.com/_/consul/
    - name: debian
    - insecure_registry: True



#
"41B01F3B-5492-45EE-A247-5C33E302F192":
  dockerng.running:
    #- image: elecnix/ikiwiki
    - name: test_123
    - image: debian
    # <NB tag="20170205_NGa">
    #  - dockerng.running's "user" paramter defaults to the executing user, "sudo_vagrant" in my present case.
    #  - This causes an error, so pre-emptively setting "user" may be prudent to prevent this.
    #  - Perhaps consider "user" as a soft requirement.
    #  - "root" is Docker's default "user" when unspecified. So should be sane in most, (though assuredly not all), cases.
    #  - ref: https://docs.docker.com/engine/reference/run/#/user
    # </NB>
    - user: root



#
"2421F73C-D45A-480B-A29E-B49C2B541E5C":
  module.run:
    - name: dockerng.run
    - m_name: test_321
    - cmd: apt install -y python



#
"617FB0FE-AE2C-4E89-A630-AFE7DDB0A519":
  module.run:
    - name: dockerng.sls_build
    # m_name is name for the newley created image
    - m_name: test_543
    - base: debian
    - mods:
      - state.machine.service.etcd



## EOF
