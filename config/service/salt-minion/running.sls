##
##
##



##
##
##



#
"299CF095-F27F-4E6C-B19B-7E5ED86C5F0A":
  pkg.installed:
    - pkgs:
      - epel-release



#
"95808417-20D9-43EF-8923-CB70CDA5AF22":
  pkg.installed:
    - name: salt-minion
    - prereq:
      - pkg: "299CF095-F27F-4E6C-B19B-7E5ED86C5F0A"



#
"E140AB9A-D7AF-4270-9FAC-BA801AC5B9B4":
  service.running:
    - name: salt-minion
    - enable: True
    - prereq:
      - pkg: "95808417-20D9-43EF-8923-CB70CDA5AF22"



