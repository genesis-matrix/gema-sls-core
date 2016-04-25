##
##

#+TODO: create service management formula in salt, include "shuttered" for disabled and deactivated services

"3db7fde1-c73f-46cc-8ca0-f05da62844d5":
  service.dead:
    - name: named

"e27bb94d-4b79-40e5-8854-64a0d4c2b9d2":
  service.disabled:
    - name: named

