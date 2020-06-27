##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
"098DFD8E-AAD8-40C5-8D0C-6EC0ACFB64A8":
  pkg.installed:
    - name: python2-pip



#
"220B0395-5351-49AD-BF25-C86F26C5B45C":
  pip.installed:
    - name: docker-py
    - require:
      - pkg: "098DFD8E-AAD8-40C5-8D0C-6EC0ACFB64A8"




#
"6FE6E7D0-3C6B-49AB-8EA0-DA72B3A6E410":
  pkg.installed:
    - name: docker



## EOF
