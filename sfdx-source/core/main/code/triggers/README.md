# sfdx-source/core/main/code/triggers

Trigger names should always correspond to the name of the SObject they act upon. They should never need to start by `core_` prefix since they are not referenced anywhere, so it will not help to identify package dependancies. E.g.: `Account.trigger`.
