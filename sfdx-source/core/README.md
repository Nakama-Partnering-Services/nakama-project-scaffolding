# sfdx-source/core

This folder is to contain metadata files that provide the main functionality of the project and their tests. They do not have dependencies anywhere else expect from scaffolding frameworks.

If decided, `core_` prefix can be used for metadata files in this folder since it is useful to easily identify package dependencies in files (as suggested [here](https://youtu.be/MY2_AfjtBp8?t=893)).

In case this folder corresponds to a package which uses a namespace, `core_` prefix will not be used since it would be redundant. If that is the case, rename this folder from `core` to `{your_ns_prefix}`. This way of working requires leveraging more dependency injection principles for managing extension packages, for example, with [at4dx](https://github.com/apex-enterprise-patterns/at4dx) or [force-di](https://github.com/apex-enterprise-patterns/force-di).
