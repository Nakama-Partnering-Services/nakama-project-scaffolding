# sfdx-source/core/main/code/classes/selectors

This folder is to organize apex classes in the selector (queries) layer.

Considerations:

-   The name of these classes should correspond to the plural name of the SObject they act upon, ending with `Selector`. E.g.: `core_AccountsSelector.cls`.
-   Selector methods **should not** start by `select` to avoid redundancy with `Selector` in the class name. E.g.: `Map<Id, Account> byId(Set<> accountIds)`.
-   These classes should usually be `inherited sharing`, and services or trigger handlers should specify `with sharing` or `without sharing`. However, a class can leverage an inner class `without sharing` to perform a query with elevated permissions.
-   These classes should extend from `fflib_SObjectSelector`. However, consider leveraging an abstract version `core_SObjectSelector` which extends `fflib_SObjectSelector` in order to enforce OLS and FLS by default (FLS is not enforced by default), so these selector classes should extend `core_SObjectSelector` instead of `fflib_SObjectSelector`.
-   Consider using singleton pattern to avoid doing repeated queries in the same transaction. Important across trigger actions.
-   The selectors should use the compile time references to field names, even if dynamic queries are being constructed. Doing so ensures that when fields are deleted, the platform prevents the deletion if references exist in the code.
-   Trade-off: apex heap size versus how frequently fields are needed by the various callers of the selector methods.
-   Testing of selectors is covered in the domain and service layer, so it is not required to create `core_AccountsSelectorTest.cls`.
-   For more information about the selector layer, refer to [Learn Selector Layer Principles](https://trailhead.salesforce.com/content/learn/modules/apex_patterns_dsl/apex_patterns_dsl_learn_selector_l_principles) in trailhead.
