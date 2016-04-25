##
## from https://github.com/saltstack-formulas/remi-formula



# Completely ignore non-CentOS, non-RHEL systems
{% if grains['os_family'] == 'RedHat' %}

## A lookup table for remi GPG keys & RPM URLs for various RedHat releases
{% set pkg = salt['grains.filter_by']({
    '5': {
	'key': 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi',
        'key_hash': 'md5=3abb4e5a7b1408c888e19f718c012630',
	'rpm': 'http://mirrors.mediatemple.net/remi/enterprise/remi-release-5.rpm',
    },
    '6': {
	'key': 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi',
	'key_hash': 'md5=3abb4e5a7b1408c888e19f718c012630',
	'rpm': 'http://mirrors.mediatemple.net/remi/enterprise/remi-release-6.rpm',
    },
    '7': {
	'key': 'http://rpms.famillecollet.com/RPM-GPG-KEY-remi',
	'key_hash': 'md5=3abb4e5a7b1408c888e19f718c012630',
	'rpm': 'http://mirrors.mediatemple.net/remi/enterprise/remi-release-7.rpm',
    },
}, 'osmajorrelease') %}

#install_remi_pubkey:
"66f4354c-c452-402d-b58c-6104fb424934":
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-remi
    - source: {{ salt['pillar.get']('remi:pubkey', pkg.key) }}
    - source_hash:  {{ salt['pillar.get']('remi:pubkey_hash', pkg.key_hash) }}

include:
  - config.apps.pkgrepo.epel.repo-add-epel

#install_remi_rpm:
"c957c61a-743c-44c1-b89f-fa2ff63fc824":
  pkg.installed:
    - sources:
      - remi-release: {{ salt['pillar.get']('remi:rpm', pkg.rpm) }}
    - requires:
      ## install_remi_pubkey
      - file: "66f4354c-c452-402d-b58c-6104fb424934"
      ## for install epel-release
      - pkg: "ec6e332a-b834-4f65-a39b-91fb34fe9ed7"

{% endif %}
