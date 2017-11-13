##
##
##



## NOTES
##  - reactors are best used as event handlers, performing triage and returning quickly
##  - this reactor invokes an orchestration sls w/ event data included in the context



#
"4D294501-C9C1-4352-850D-33BD877B7649":
  runner.state.orchestrate:
    - mods: orch.git-push-minion-pki-changes
    - pillar:
        event_tag: {{ data['tag'] }}
        event_data: {{ data['data'] }}
        event_stamp: {{ data['_stamp'] }}
        event_origin: {{ sls }}



