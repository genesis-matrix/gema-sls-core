##
##
##

  

#
"031A2C45-08E5-4C1B-A6E4-22499BF05A7E":
  group.present:
    - name: vagrant
  user.present:
    - name: vagrant
    - gid_from_name: True
    {# password: "vagrant" #}
    - password: "$1$damlkd,f$UC/u5pUts5QiU3ow.CSso/"
  ssh_auth.present:
    - user: vagrant
    - source: salt://MISC/PROVISION/assets/keymat/sshkey_hashicorp-vagrant-pubkey
  file.managed:
    - name: /etc/sudoers.d/vagrant
    - mode: '0440'
    - contents:
      - "vagrant ALL=(ALL) NOPASSWD: ALL"
      - "Defaults:vagrant !requiretty"



#
"D1C5E451-E10F-41B9-B9C4-DA988551BEBF":
  pkg.removed:
    - pkgs:
      - linux-firmware
      - fprintd-pam
      - intltool
      - mariadb-libs
      - postfix
      - linux-firmware
      - aic94xx-firmware
      - atmel-firmware
      - b43-openfwwf
      - bfa-firmware
      - ipw2100-firmware
      - ipw2200-firmware
      - ivtv-firmware
      - iwl100-firmware
      - iwl105-firmware
      - iwl135-firmware
      - iwl1000-firmware
      - iwl2030-firmware
      - iwl2000-firmware
      - iwl3060-firmware
      - iwl3160-firmware
      - iwl3945-firmware
      - iwl4965-firmware
      - iwl5000-firmware
      - iwl5150-firmware
      - iwl6000-firmware
      - iwl6000g2a-firmware
      - iwl6000g2b-firmware
      - iwl6050-firmware
      - iwl7260-firmware
      - libertas-sd8686-firmware
      - libertas-sd8787-firmware
      - libertas-usb8388-firmware
      - ql2100-firmware
      - ql2200-firmware
      - ql23xx-firmware
      - ql2400-firmware
      - ql2500-firmware
      - rt61pci-firmware
      - rt73usb-firmware
      - xorg-x11-drv-ati-firmware
      - zd1211-firmware



# https://github.com/mitchellh/vagrant/issues/2614
"1ECB61A8-E8AE-428D-A4FC-B8C0FF66EF3F":
  file.absent:
    - name: /etc/udev/rules.d/70-persistent-net.rules



#
"E0A70C05-4D62-4106-938C-50E0BCA602E7":
  cmd.run:
    - name: find /etc/sysconfig/network-scripts/ -iname 'ifcfg-eth*' |xargs -r -n1  sed -i '/HWADDR/d'



#
"78EE09F3-4ADE-4DE5-ABD2-EB4C1BC6F440":
  cmd.run:
    - name: find /etc/sysconfig/network-scripts/ -iname 'ifcfg-ens*' -delete



