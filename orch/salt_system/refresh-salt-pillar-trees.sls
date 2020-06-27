##
##
##



# refresh pillar tree
"69298F9C-94B1-4D33-8566-73C816830B6A":
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: 'machine_role:salt-master'
    - tgt_type: pillar
