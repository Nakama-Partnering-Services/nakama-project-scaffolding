# sfdx-source/core/main/code/classes/services

This folder is to organize apex classes in the service layer.

Considerations:

-   These classes should always be `with sharing`, especially when having the global modifier, unless strictly justified and explained in a `// Note: ` comment at the top of the class.
-   If Apex logic must access records outside of the user’s visibility, the code must explicitly elevate the execution context as briefly as possible. E.g.: with a private inner `without sharing` class.
-   These classes should throw exceptions, or provide partial database handling. E.g.: with `Database.SaveResult`.
-   The methods of these classes should be bulkified.
-   These classes will just be used by clients.
-   Having compound services is better than having clients calling one service after another. Especially good for optimizing SOQL and DML usage.
-   Database operations and service state should be encapsulated within the method call to the service layer.
-   These classes are the ones that should call `uow.commitWork()`.
-   The services should be stateless to give calling contexts the flexibility to employ their own state management solutions.
-   Consider leveraging Custom Metadata and the Callable interface in the service classes so that they can be called dynamically from clients in the core package even if they are in a different extension package.
-   For more information about the service layer, refer to [Learn Service Layer Principles](https://trailhead.salesforce.com/content/learn/modules/apex_patterns_sl/apex_patterns_sl_learn_sl_principles) in trailhead.
