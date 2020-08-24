##
##
##



##_META:
##



## <JINJA>
{%- set var_dct = {} %}
{%- set _discard = var_dct.update({"uri_pip": "/usr/bin/pip3", }) %}
## </JINJA>



# notes on Implementation Status
{#-
--- #  on CentOS 7
pygit2:
  cli_install: yum install -y python36{,-devel} libgit2 gcc && pip3 install -U pip && pip3 install pygit2
GitPython:
  cli_install: yum install -y python36-GitPython
#}



#
"3c6ad6d8-8017-4142-a09d-728d342cdb08":
  pkg.installed:
    - names:
      - python36-GitPython
      # needed by pip to build/install pygit2
      - libgit2
      - gcc




#
"7bef8208-0b3d-46f9-a9aa-08d79c7ab380":
  pip.installed:
    - name: pip
    - bin_env: {{ var_dct.uri_pip }}
    - upgrade: True



#
"3d9cb091-b5ce-42d3-869e-428e1a663967":
  pip.installed:
    - name: pygit2
    - bin_env: {{ var_dct.uri_pip }}



## EOF
