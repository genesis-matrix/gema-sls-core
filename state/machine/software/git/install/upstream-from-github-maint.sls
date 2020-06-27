##
##

##+TODO: add 'date' parameter to install path for versioning

"5C0EF6D2-475D-4DF7-A428-479D2D1EB2F7":
  cmd.run:
    - name: 'yum -y --enablerepo=epel install autoconf gcc curl-devel zlib-devel && cd $(mktemp -d) && wget https://github.com/git/git/archive/maint.zip && unzip maint.zip && cd git-maint && make configure && ./configure --prefix=/opt/install-git && make all && make install && echo "OK build git"'
    # || rm -rf ${HOME}/tmp/maint.zip ${HOME}/tmp/git-maint*'
    - unless: test -f /opt/install-git/bin/git


"D7175801-E512-4066-9197-24E9BCCA752E":
  cmd.run:
    - name: 'for i in /opt/install-git/bin/* ;do alternatives --install /usr/bin/$(basename ${i}) $(basename ${i}) ${i} $(date --rfc-3339=date | tr -d - ) ;done'
