##
## "minset" general purpose configuration



# 
"3F52AA18-A93D-4FA6-AE38-0E2F658C67D6":
  pkg.installed:
    - pkgs:
      - bind-utils
      - net-tools
      - nfs-utils
      - curl
      - wget
      - openssh-clients
      - bzip2
      - epel-release
      


#
"1D042400-963A-4B9D-A2C7-9290F28CD0AB":
  file.directory:
    - name: /etc/sudoers.d
    - dir_mode: '0750'
    - user: "root"
    - group: "root"
    - makedirs: True
"0A1A9E68-998D-4FB3-95EC-0817DE65B2AF":
  file.append:
    - name: /etc/sudoers
    - text: '#includedir /etc/sudoers.d'
"6D897100-E1FA-41C6-B7F9-21AF6E2614A2":
  file.managed:
    - name: /etc/sudoers.d/root
    - mode: '0440'
    - contents:
      - "Defaults:root !requiretty"



