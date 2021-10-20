# sfdx-source/core/main/code/clients/soap-apis

The name of these classes should end with `Soap`. E.g.: `core_OpportunitiesDiscountsSoap.cls`.

Soap APIs are exposed for off-platform callers, although with a GET rest request to the standard Tooling API, APIs that are just global can also be consumed like:

    `http://na1.salesforce.com/services/data/v53.0/tooling/executeAnonymous/?anonymousBody=System.debug('Test')%3B';`
