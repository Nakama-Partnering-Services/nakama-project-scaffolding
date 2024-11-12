# Pull Request Quality Gates

- [Why quality gates](#why-quality-gates)
- [Quality gates](#quality-gates-list)

## Why quality gates

The purpose of the quality gates is ensuring Clean Coding and Best practices by checking:

- Reduce cost of maintenance - 40% - 80% of the lifetime of a piece of Software goes into maintenance.
- Maintainability.
- Code readability.
- Consistency.
- Code-re-usability.
- Avoid technical debts.

## Quality gates list

In order to perform the above checks, we have configure the following automatic validations as part of our pull request build in our CI (continuous integration) process. These validations are required to succeed before the pull request can be merged in the target branch:

- Validate Jest: uses Jest to execute Frontend JavaScript Lightning Web Components automated unit tests and ensure they succeed and have enough coverage.
- Validate Prettier: uses Prettier to ensure that all the new changes are following the agreed formatting rules consistently with the rest of our codebase.
- Validate ESLint LWC: uses ESLint to ensure that all the new changes in Frontend JavaScript Lightning Web Components are properly linted according Salesforce recommendations and best practices.
- Validate ESLint Aura: uses ESLint to ensure that all the new changes in Frontend JavaScript Aura Components are properly linted according Salesforce recommendations and best practices.
- Validate PMD: uses PMD to ensure that all the new changes in Backend Apex code and other Salesforce metadata, such as profiles or custom fields, are following Salesforce best practices and conventions.
- Validate Flows: uses sf cli commands to ensure that all the new changes in Flows are following Salesforce best practices and conventions.
- Validate Deployment: uses sf cli commands to ensure that all the new changes are properly deployable to the next Salesforce environments in the pipeline, as well as execute Apex automated tests.
- Validate test coverage: uses sf cli commands to ensure that all the new changes in Backend Apex code are having their relevant tests and a coverage above 85% for each Apex class.