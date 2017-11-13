##
##
##



##_META:
##



## <JINJA>
## </JINJA>



#
"83168DBB-EC1E-466E-9A16-E8ED88F7DB78":
  pkg.installed:
    - name: openscap-scanner



# NOTES
{#
see https://static.open-scap.org/openscap-1.0/oscap_user_manual.html#_practical_examples for additional content options

http://people.redhat.com/swells/scap-security-guide/RHEL/7/output/

https://docs.saltstack.com/en/develop/ref/modules/all/salt.modules.openscap.html

$> salt-call openscap.xccdf 'eval --profile standard /usr/share/xml/'
#}



#
"9FBE699D-F501-493F-809F-578AC3FC4FFA":
  pkg.installed:
    - name: scap-security-guide



#
"4DB17D4B-B7F8-4CE2-80C7-76A5D30A4FB1":
  file.managed:
    - name: /usr/share/xml/scap/ssg/content/ssg-rhel7-ocil.xml
    - source: http://people.redhat.com/swells/scap-security-guide/RHEL/7/output/ssg-rhel7-ocil.xml
    - source_hash: sha256=8989586a6ce763ec14c38fdc928e4eba803e1cab4dfd1284b17efc66afa313f3



## EOF
