##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
include:
  - state.machine.software.docker



#
"9046D718-917D-4E75-845C-200B3F8B173F":
  service.running:
    - name: docker
    - enable: True



## EOF
