##
##
##



# deploy genesis-paradigm salt-master
#  - Q: http://stackoverflow.com/questions/29081453/what-happens-if-orchestration-triggers-a-salt-master-service-restart
include:
  - config.service.salt-minion.running
  - config.service.salt-master.restart
  #
  - orch.refresh-salt-state-trees
  - orch.refresh-salt-pillar-trees
  - formula.salt.master



