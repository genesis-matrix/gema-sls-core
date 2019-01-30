##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
"00154127-CC4E-4105-BF61-372536E2F31A":
  pkg.installed:
    - name: python2-pip
    - require_in:
      - pip: "5D4E9790-491D-419C-8AFB-290EDB001403"



#
"05DFF055-B6D6-4D74-ABE4-5944B6CC8E1B":
  pip.installed:
    - name: setuptools
    - upgrade: True



#
"5D4E9790-491D-419C-8AFB-290EDB001403":
  pip.installed:
    - name: testinfra



## EOF
