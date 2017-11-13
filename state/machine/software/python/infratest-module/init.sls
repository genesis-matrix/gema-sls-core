##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
"5D4E9790-491D-419C-8AFB-290EDB001403":
  pip.installed:
    - name: testinfra



#
"00154127-CC4E-4105-BF61-372536E2F31A":
  pkg.installed:
    - name: python-pip
    - require_in:
      - pip: "5D4E9790-491D-419C-8AFB-290EDB001403"



## EOF