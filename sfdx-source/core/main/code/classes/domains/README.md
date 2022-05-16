# sfdx-source/core/main/code/classes/domains

This folder is to organize apex classes in the domain (SObject) layer.

Considerations:

-   The name of these classes should correspond to the plural name of the SObject they act upon. E.g.: `Accounts.cls`.

-   These classes should usually be `inherited sharing`, and services or trigger handlers/actions should specify `with sharing` or `inherited (without) sharing` respectively.

-   These classes should extend from `fflib_SObjects`.

-   These classes will just be used by trigger handlers/actions and service classes, so, by clients, they are always invoked indirectly.

-   Operations in these classes include:

    -   Complex validations
    -   Field values defaulting
    -   Other logic relating to complex calculation and manipulation.

-   For more information about the domain layer, refer to [Learm Domain Layer Principles](https://trailhead.salesforce.com/en/content/learn/modules/apex_patterns_dsl/apex_patterns_dsl_learn_dl_principles) in trailhead.
