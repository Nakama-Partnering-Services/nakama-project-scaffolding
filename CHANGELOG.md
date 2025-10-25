# Release notes


## [2.0.0](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/compare/v1.4.0...v2.0.0) (2025-10-25)


### Features

* improve bitbucket pipelines with docker image ([2972070](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/2972070c254e4c506aa6ed09b90d9b43d086ec7d))
* update azure validate  pipelines with new plugin version without testing ([d9077bf](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/d9077bf3b37d7c6cd14d5e608c6cd5489f936053))
* update bitbucket pipelines with new plugin version without testing ([e1e8ed8](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/e1e8ed8154227c927c3e6ae97d779427144451cf))
* update gitlab validate  pipelines with new plugin version without testing ([e0a5109](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/e0a51095ac9e3570bac7b00d0d9752bed377ab89))


### Bug Fixes

* change pmd threshold to 2 instead of 3 ([3083d7f](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/3083d7fad4cc1ff2ad1ce2b911a067827f4ba5fd))
* exclude nakama settings from being ignored in case the default folder is ignored ([4fa693a](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/4fa693aac3ab2a56edfbb621d44876a533507f81))
* issue with readme files being ignored ([9dc3e88](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/9dc3e88a2170a1e49f98f39644a7339836a78c6b))
* set UAT as direct environment for rc push deployments in Azure ([c07af17](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/c07af176abb37ee8f1a8fc481dc895f8e6b9941b))
* target org references in azure jobs and frameworks readmes ([123736d](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/123736df22904b2abeca1a4e82d3e389a068c3e6))

## [1.4.0](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/compare/v1.3.1...v1.4.0) (2024-01-07)

### Features

-   create Deployment Information namespaced unlocked package ([9deab6d](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/9deab6d393649d93217c888051b5e428167a47ed))
-   usage of docker image to improve privacy and speed ([#21](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/issues/21)) ([034bf50](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/034bf500ebf2783a5fe1bf71383df8a3d830125b))

### Bug Fixes

-   branch reference ([be370d1](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/be370d1087953235a816a8cacbdf0222e433f597))
-   lintstagedrc.js ([1837bc3](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/1837bc3d8f1ea2982d3fbc4551c93e403e69c69f))
-   remove unsused variable ([9173e32](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/9173e322ca4263f95a1e546fcfd4c210ac1009f5))

## [1.3.0](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/compare/v1.2.1...v1.3.0) (2023-05-20)

### Bug Fixes

-   missing character ([484c122](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/484c1226f233ef316b6885a346d574621bf9d620))
-   specific environments uppercase and fixe validation check in deploy.sh ([08961e5](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/08961e51b4ef8435fe71d57782f1da445aa9b8a0))
-   typos ([617170b](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/617170ba05177d1c2af27b2816d17d4532590039))

### [1.2.1](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/compare/v1.2.0...v1.2.1) (2023-02-09)

### Features

-   add PR description specified tests in bitbucket-pipelines.yml ([4f8b55d](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/4f8b55ddf368225718a2b8ec97788223a08dc3be))
-   alignments and improvements with all providers, use sfdx instead of sf ([0511e76](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/0511e76262463c554fb8c6c188fbcd57b031fdd7))
-   changes to include lintstaged with some additional validations ([6be7050](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/6be7050280ff0670376eae5bb01787f3afc5dbfc))
-   testlevel can be specified on PR description for GitLab ([24ae313](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/24ae313accb525cfc2c004c7aab306bf291ba5fe))
-   update apex-trigger-actions framework ([52b9a4a](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/52b9a4a9744a47b3cd0347f18c08899716fd1c2a))

### Bug Fixes

-   ignore experiences .json prettier ([fdad13c](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/fdad13cb38bf112df72362459f32a4cf853a5ecd))
-   include missing silent jests script ([4ff079c](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/4ff079c171c9eac54664944759fb56f313680569))
-   nps:package:destructive:versionobsoleteflows not working in deploy.sh ([ab3d178](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/ab3d17813d18089bb98b6dfe99010188628a3c68))
-   update printing validation results on bitbucket ([b0b8f15](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/b0b8f158d5ecb59f05ee05aa22444c85521873f0))
-   verify linting changes files ([2b0e5a8](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/2b0e5a84f5f6bf08c2f19d03d5d10a0293b561dc))

## [1.2.0](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/compare/v1.1.1...v1.2.0) (2022-09-02)

### Features

-   add azure pipelines ([f254e74](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/f254e745ef7a1246b2a1c2a90bb26182c2e9b712))
-   add staging and production pipelines for rc/_ and patch/_ branches ([8ce4ba0](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/8ce4ba0aab8472b07115486459c942bddca02a69))
-   add versionobseleteflows command before deploying deltas ([29b3d7c](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/29b3d7c5dcf9838b4132e58edfe9d5371d1395dc))

### [1.1.1](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/compare/v1.1.0...v1.1.1) (2022-08-16)

### Features

-   added commitlint and standard-version ([c269952](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/c269952df2e413beb826c0a9d8a303fcef6c0b24))

### Bug Fixes

-   fixed release version on package-lock.json ([bb3e80e](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/commit/bb3e80e96f90e22276b3a7a984a4abcb04cf0db5))
