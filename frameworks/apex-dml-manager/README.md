To investigate: - Check if a record can be updated when user has no row level access because of with sharing.

Considerations:

-   ESAPI usage is discarded because of limitations when using StripInnaccessible:
    -   Not resolving relationships when using fflib_SObjectUnitOfWork.
    -   Limitation when the record contains a field which is not updateable, such as formulas. Even if the field has not been modified nor changed, but is contained in the record because it was first retrieved with such field, when trying to insert the record because another field was updated, the insert fails when it should not.
    -   Limitation when the record contains a field which the user has read but not edit access on a it. Even if the field has not been modified nor changed, but is contained in the record because it was first retrieved with such field, when trying to insert the record because another field was updated, the insert fails when it should not.
-   fflib_SecurityUtils is not enough.
-   https://github.com/trailheadapps/apex-recipes/tree/main/force-app/main/default/classes/Security%20Recipes is not enough.
-   Standard Salesforce methods such as StripInnaccessible, and SObjectDescribe methods, are not enough and User Mode Database Operations is in Pilot.

Original repository: https://github.com/patronmanager/apex-dml-manager
