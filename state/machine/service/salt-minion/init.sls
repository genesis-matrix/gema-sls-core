##
##
##



##
include:
  - state.machine.software.salt-minion
  - state.machine.software.python.infratest-module



#
"E140AB9A-D7AF-4270-9FAC-BA801AC5B9B4":
  service.running:
    - name: salt-minion
    - enable: True
    - full_restart: True
    - init_delay: 5
    - watch:
      - pkg: "95808417-20D9-43EF-8923-CB70CDA5AF22"
    - order: last


