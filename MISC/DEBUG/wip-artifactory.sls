##
##
##



##_META:
##  refs:
##    - https://www.jfrog.com/confluence/display/RTF/Installing+on+Linux+Solaris+or+Mac+OS
##



## <JINJA>
{%- set lookup = salt["pillar.get"]("lookup:sls_path:" ~ sls) %}
## </JINJA>



#
"6E7F9F62-AB37-4561-A036-C24ED1DC5964":
  pkgrepo.managed:
    - name: "bintray--jfrog-artifactory-rpms"
    - baseurl: "http://jfrog.bintray.com/artifactory-rpms"
    - gpgcheck: 0
    - repo_gpgcheck: 0
    - enabled: 1



#
"6A51E5FB-3D53-4E27-B2A9-8ABA8A98B16B":
  pkg.installed:
    - name: jfrog-artifactory-oss



#
"DA95CD03-6EAD-4AEE-B2F6-54E4C37B0E5D":
  pkg.installed:
    - name: java-1.8.0-openjdk-headless



#
{#
JVM parameters
Make sure to modify your JVM parameters by modifying JAVA_OPTIONS in /etc/opt/jfrog/artifactory/default as appropriate for your installation.
#}



#
{#
Checking the status of the Artifactory service
Once Artifactory is correctly installed, you can check if it is running with:
service artifactory check

If Artifactory is running, you should see its pid.
If Artifactory is not running you will see a list of environment variables used by the service.
#}



#
{#
You can also check the Artifactory log with:
tail -f $ARTIFACTORY_HOME/logs/artifactory.log
#}



#
"8CCBE8A4-7DC2-4691-AC10-729DA123838F":
  service.running:
    - name: artifactory



## EOF
