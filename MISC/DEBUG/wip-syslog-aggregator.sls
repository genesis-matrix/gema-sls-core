##
##
##



##_META:
##  todo:
##    - [ ] add service restart watch on /etc/rsyslog.d/*.conf files
##    - [ ] high fidelity time resoltuion
##



## <JINJA>
## </JINJA>



#
include:
  - state.machine.service.systemd-journald
  - MISC.DEBUG.wip-splunk-uf



#
"1EDA8586-14AD-45DF-AE35-B0F6448BA9EF":
  pkg.installed:
    - name: rsyslog



#
"F3A5CCC1-739D-4679-91E5-0D1A840950F7":
  file.append:
    - name: /etc/rsyslog.conf
    - text: '$IncludeConfig /etc/rsyslog.d/*.conf'



# forward all received messages on tcp port 10514 to the Journal
"763F7DB7-1083-4B02-AA62-33DA6FFAB320":
  file.managed:
    - name: /etc/rsyslog.d/network-syslog-into-journald.conf
    - contents: |
        # forward all received messages on tcp port 10514 to the Journal
        $ModLoad imtcp
        $ModLoad omjournal
        
        $RuleSet remote
        *.* :omjournal:

        $InputTCPServerBindRuleset remote
        $InputTCPServerRun 10514



#
"E385657A-6F1E-4914-B6EC-E68DBF0A810D":
  service.running:
    - name: rsyslog
    - full_restart: True
    - watch:
      - file: "763F7DB7-1083-4B02-AA62-33DA6FFAB320"



## EOF
