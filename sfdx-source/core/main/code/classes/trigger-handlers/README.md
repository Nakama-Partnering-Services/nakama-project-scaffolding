# sfdx-source/core/main/code/classes/trigger-handlers
Trigger names should always correspond to the name of the SObject they act upon, ending with `TriggerHandler`. They do not require `core_` prefix since they are not referenced anywhere except from triggers, so it will not help to identify package dependancies. E.g.: `AccountTriggerHandler.cls`.