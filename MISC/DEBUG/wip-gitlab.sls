##
##
##



##_META:
##



## <JINJA>
{%- set var = {'uri_installmedia_cent7': 'https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/7/gitlab-ce-8.16.2-ce.0.el7.x86_64.rpm/download'} %}
## </JINJA>



#
"395BA8BE-37B8-4558-BF9E-8D6CDFB38682":
  pkg.installed:
    - pkgs:
      - curl
      - policycoreutils
      - postfix
      - openssh-server
      - openssh-clients



#
"E27CE450-7DC0-446F-9D01-DCBBCB08E0D8":
  service.running:
    - name: sshd
    - enable: true



#
"13DA3EF7-180B-4821-915A-4728385F1CA0":
  service.running:
    - name: postfix
    - enable: true



# #
# "EB78C150-C1D0-4005-A616-AE9BCECBFE9B":
#   firewalld.present:
#     - name: gitlab
#     - services:
#       - http
#       - https
#     - sources:
#       - 172.16.0.0/16



#
"C1290DCA-2719-4AC8-A5B2-3913BC09BB94":
  cmd.run:
    - unless: which gitlab-ctl
    - name: |
        cd $(mktemp -d) \
        && curl -LJO {{ var['uri_installmedia_cent7'] }} \
        && rpm -i gitlab-ce-*.el7.x86_64.rpm



# config gitlab via primary config file
"703085F5-8E76-42BD-85C0-81B2C5CD3AED":
  cmd.run:
    # place-holder for expanded config customization
    - name: test -e /etc/gitlab/gitlab.rb



# run config setup
"060CD345-746A-4047-ADDE-6D909D1A7DBE":
  cmd.run:
    - name: gitlab-ctl reconfigure



# gitlab daemon wraps w/i the Runit supervisor w/i a systemd service
"9F183056-DA38-4F86-87F9-DBE2EF1494C4":
  service.running:
    - name: gitlab-runsvdir
    - enable: true



## EOF
