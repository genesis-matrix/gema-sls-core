##
##
##



##_META:
##  refs:
##    - http://orientdb.com/download/
##    - orientdb software install media url: http://mkt.orientdb.com/CE-2217-linux
##    - command to launch docker container: |
##      docker run -d --name orientdb -p 2424:2424 -p 2480:2480 -e ORIENTDB_ROOT_PASSWORD=root orientdb:latest
##



## <JINJA>
{#- note: password created using, openssl rand -base64 32 #}
{%- set db_root_pass = "aV82QpqFzy1qrAPcIidWzYG4wdMi6sFO8rJh/vm9cEQ" %}
## </JINJA>



#
include:
  - state.machine.service.docker



#
"E75D246B-4DDD-4A9E-B4E6-6ED3B616A2DB":
  pkg.installed:
    - name: python2-pip



#
"317964C4-4079-47E7-8FF9-DFA7661D41C1":
  pip.installed:
    - name: pyorient



#
"A79A6996-A3D7-4E97-92A8-03EFEB0778A8":
  firewalld.service:
    - name: orientdb
    - ports:
      - 2424/tcp



#
"8FC29C34-A8EF-4F05-A97E-B1EDEEE45487":
  firewalld.service:
    - name: orientdb-web-mgmt
    - ports:
      - 2480/tcp



#
"4EA0FACA-3C5B-4C4B-AD3A-38BAF5F0153B":
  firewalld.present:
    - name: public
    - services:
      - ssh
      - orientdb
      - orientdb-web-mgmt
      


#
"3259EB09-5393-41D1-B7DB-9B313E39DAE8":
  dockerng.running:
    {#- nb, where a tag is omitted, latest is assumed #}
    - name: orientdb
    - image: orientdb
    - environment:
      - ORIENTDB_ROOT_PASSWORD: "{{ db_root_pass }}"
    - ports:
      - 2424
      - 2480
    - port_bindings:
      - 2424:2424
      - 2480:2480



## EOF

