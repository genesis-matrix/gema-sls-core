##
##
##



##_META:
##  Purpose: apply config for automated snapshots using snapper tool
##  Applicability:
##    - Linux: CentOSv7
##    - part-fs w/ either btrfs or LVM thin provisioned volumes w/ ext4 (preferred) or xfs
##  Prospectus:
##    - (todo) test for validity of target for snapper actions
##    - install requisite softwares
##    - create snapper template config
##    - use template to create live snapper config
##    - enable state.apply triggered snapshots in minion config
##  Refs:
##    - https://docs.saltstack.com/en/develop/ref/states/all/salt.states.snapper.html
##    - https://docs.saltstack.com/en/develop/ref/modules/all/salt.modules.snapper.html
##    - https://duncan.codes/2016/06/09/config-drift-salt-snapper.html
##



## <JINJA>
{%- set var = {
        'snapper_config': '3063809D-825A-476A-9D0B-B55C92387DEA',
        'snapper_baseline_num': '10',
        'fstype': 'lvm(ext4)'
        }
%}
## </JINJA>



# comment: Introduction to Snapper
{#-
Overview:
  - automated snapshot creation uses cron at /etc/cron.hourly/snapper, controlled by the 'TIMELINE_CREATE' boolean config value.
Configuration:
  '':
    - when the filesystem type is unspecified autodetection is attempted based on the mount-point 
    - any other unspecified values are set based on the default configuration
    - base default snapper configs are in /etc/snapper/config-templates/default
    - useable configs are created and store at /etc/snapper/configs/{config_name}
    - if a config is unspecified, "root" is used, if it doesnt exist or is innappropriate, this could be problematic
Sub-Commands:
  'create-config':
    - (ex.) snapper -f {config_name} create-config [-f (btrfs|lvm({fstype}))] [-t {name_of_config_template}]
  'list-configs':
    - (ex.) snapper list-configs
    - outputs a table showing the config names and their corresponding subvolume mount points
  'delete-config': []
  'get-config': []
  'set-config': []

Snapshot Mgmt:
  'single':
    - these snapshots record a point-in-time (PIT) state
  'command':
    - can be thought of an auto-pre-post
    - (ex.) snapper
  'pre-post':
    - these snapshots record a before and after change
    - this creates a snapshot composed of any changes between the pre and post invocations of snapper
  'undochanges':
    - apply the reverse diff between the two specified snapshots to the current system
    - (ex.) snapper -c config_name undochange 1..2
    - use with extreme care, this is file level revert, not a volume level revert and offers not end-result consistency garuntee
    - the
  'modify': []
  'delete':
    - delete a snapshot
    - (ex.) snapper -c yourconf delete {snapshot_num}
  'diff':
    - display the difference in file contents
    - (ex.) snapper -c yourconf diff {initial_num}..{concluding_num}
    - the order that the snapshot numbers are listed is significant in the produced diff
  'xadiff':
    - as w/ the diff command, but display changes in extended attributes
    - (ex.) snapper -c yourconf diff {initial_num}..{concluding_num}
  'mount': []
  'umount': []
  'rollback': []
  'cleanup': []
#}



# install pre-requisite software
"7E1FB1F0-6E2E-4917-AB66-CA93F3BF2474":
  pkg.installed:
    - pkgs:
      - snapper



# create custom snapper config template
"F88386B8-1962-4658-8237-B009FFE79EDB":
  file.managed:
    - name: /etc/snapper/config-templates/F88386B8-1962-4658-8237-B009FFE79EDB
    - contents: |
        # subvolume to snapshot
        SUBVOLUME="/"
        
        # filesystem type
        FSTYPE="{{ var['fstype'] }}"
        
        
        # users and groups allowed to work with config
        ALLOW_USERS=""
        ALLOW_GROUPS=""
        
        # sync users and groups from ALLOW_USERS and ALLOW_GROUPS to .snapshots
        # directory
        SYNC_ACL="no"
        
        
        # start comparing pre- and post-snapshot in background after creating
        # post-snapshot
        BACKGROUND_COMPARISON="yes"
        
        
        # run daily number cleanup
        #NUMBER_CLEANUP="yes"
        NUMBER_CLEANUP="no"
        
        # limit for number cleanup
        NUMBER_MIN_AGE="1800"
        NUMBER_LIMIT="50"
        NUMBER_LIMIT_IMPORTANT="10"
        
        
        # create hourly snapshots
        #TIMELINE_CREATE="yes"
        TIMELINE_CREATE="no"
        
        # cleanup hourly snapshots after some time
        TIMELINE_CLEANUP="yes"
        
        # limits for timeline cleanup
        TIMELINE_MIN_AGE="1800"
        TIMELINE_LIMIT_HOURLY="10"
        TIMELINE_LIMIT_DAILY="10"
        TIMELINE_LIMIT_WEEKLY="0"
        TIMELINE_LIMIT_MONTHLY="10"
        TIMELINE_LIMIT_YEARLY="10"
        
        
        # cleanup empty pre-post-pairs
        EMPTY_PRE_POST_CLEANUP="yes"
        
        # limits for empty pre-post-pair cleanup
        EMPTY_PRE_POST_MIN_AGE="1800"



# create active snapper config from custom template
"3063809D-825A-476A-9D0B-B55C92387DEA":
  cmd.run:
    - name: 'snapper -c {{ var['snapper_config'] }} create-config -f "{{ var['fstype'] }}" -t F88386B8-1962-4658-8237-B009FFE79EDB /'
    - creates: /etc/snapper/configs/{{ var['snapper_config'] }}
    - require:
      - file: "F88386B8-1962-4658-8237-B009FFE79EDB"




# set minion configs to use snapper on state runs (1/2): snapper_states
"F68668EE-563B-43E8-A7BD-4AFC13FC0EC7":
  file.append:
    - name: /etc/salt/minion.d/conf.minion.snapper_states..true.conf
    - text: "snapper_states: True"



# set minion configs to use snapper on state runs (2/2): snapper_states_config
"CF4ED7FB-F2F8-4722-A40B-B91C717ACE6C":
  file.append:
    - name: /etc/salt/minion.d/conf.minion.snapper_states_config..{{ var['snapper_config'] }}.conf
    - text: "snapper_states_config: {{ var['snapper_config'] }}"



# diff a/o revert to named "baseline" snapshot
"7DDEFD5C-29F5-4BBD-891A-54FA2A68D617":
  snapper.baseline_snapshot:
    - number: {{ var['snapper_baseline_num'] }}
    - config: {{ var['snapper_config'] }}
    - include_diff: True

  

## EOF