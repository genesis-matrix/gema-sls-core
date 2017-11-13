##
##
##



##_META:
##  Desc:
##    - ikiwiki packages are updated for debian first
##



## <JINJA>
## <JINJA>



#
include:
  - state.machine.service.docker



#
"8159F175-487B-4CB4-8574-BEF471FF61B4":
  pkg.installed:
    - pkgs:
      - docker
      - cockpit



#
"D056AADD-C6EB-417C-9EFE-65E607E0CD43":
  service.running:
    # nb, cockpit listens on port 9090 by default
    - name: cockpit



#
"B26F3DFE-6F06-4A28-A77E-7962EFE2E1DC":
  service.running:
    - name: docker



# notes
{#
 - ikiwiki is most native on debian.
 - We will use salt to collect and configure a debian docker container.
#}



#
"9CF17B99-6446-432F-89A2-C454F57A6B47":
  dockerng.image_present:
    - name: debian
    - public: True




{#
  module.run:
    - name: dockerng.sls_build
    - m_name: ikiwiki
    - base: debian
#}



## EOF
