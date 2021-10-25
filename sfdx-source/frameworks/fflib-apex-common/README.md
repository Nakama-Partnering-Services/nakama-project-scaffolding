This folder only includes the relevant files in the respository that are actually used in this project.

fflib_SObjectDomain is excluded since trigger logic is better handled in trigger actions frameworks, and fflib_Application approach is too cumbersome with dependancy injection and reflection, required for mocks in testing.

Despite of the previous consideration, Domain Layer concept will still be respected with fflib_SObjects.

Original repository: https://github.com/apex-enterprise-patterns/fflib-apex-common
