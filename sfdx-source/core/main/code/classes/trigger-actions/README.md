# sfdx-source/core/main/code/classes/trigger-actions

This folder is to organize apex classes for trigger actions in folders by SObject.

Considerations:

-   The name of these classes should correspond to the action they execute. They should never need to start by `core_` prefix since they are not referenced anywhere except Trigger Action custom metadata records in their own package, so it will not help to identify package dependancies. E.g.: `CapitalizeNames.cls`.
-   These classes should usually be `inherited (without) sharing`, since trigger context should act regardless of record level access of the current user. The `inherited sharing` will apply `without sharing` since it is executed in trigger context.
