##
##
##



##_META:
##



## <JINJA>
{%- set lookup = salt['pillar.get']('lookup:sls_path:' ~ sls, {}) %}
{%- set install_version = "1.8.0" %}
## </JINJA>



# notes
{#-
 - on CentOSv7, the JDK v1.8.0 pkg is "java-1.8.0-openjdk-devel"
 - in the current instance JAVA_HOME is "/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.121-0.b13.el7_3.x86_64"
 - auto set JAVA_HOME env-var,
   salt atlas-bamboo-d1 cmd.run 'export JAVA_HOME=$(readlink -f /etc/alternatives/java_sdk)'

#}



#
"E10AD33D-53B9-47C0-92DF-EEECF9C15D7B":
  pkg.installed:
    - name: java-{{ install_version }}-openjdk-devel



# setup env-var JAVA_HOME
"DA6C252F-26AF-47F4-A9A9-21F8AA562E95":
  file.managed:
    - name: /etc/profile.d/system-envar-java-home.sh
    - contents: 'export JAVA_HOME=$(readlink -f /etc/alternatives/java_sdk)'



## EOF
