[![Create Frameworks Package Version](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/actions/workflows/create-frameworks-package-version.yml/badge.svg)](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/actions/workflows/create-frameworks-package-version.yml) [![Daily run local tests](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/actions/workflows/scheduled-tests.yml/badge.svg)](https://github.com/Nakama-Partnering-Services/nakama-project-scaffolding/actions/workflows/scheduled-tests.yml) [![pipeline](https://gitlab.com/jdkgabri/nakama-project-scaffolding/badges/main/pipeline.svg)](https://gitlab.com/jdkgabri/nakama-project-scaffolding/-/commits/main)

# nakama-project-scaffolding

This repository aims to contain the resources and frameworks used for the scaffolding of new sfdx projects. It also has a modular project structure with guidelines on how to use it, the purpose of each folder, and some naming conventions and best practices.

## Latest package version installation links

-   [Frameworks](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t7Q000000cntxQAA)

## Table of contents

-   [Credits](#credits)
-   [Contributing](#contributing)
-   [License](#license)
-   [Roadmap](#roadmap)

## Credits

-   [**Nakama Partnering Services**](https://github.com/Nakama-Partnering-Services)

## Contributing

Contributions are what make the trailblazer community such an amazing place. I regard this project as a way to inspire and learn from others. Any contributions you make are greatly appreciated.

## License

This project is licensed under the MIT license - see the [LICENSE](/LICENSE) file for details.

## Roadmap

-   Add staging PR validation for release branches in GitHub workflow validate.yml.
-   Implement vlocity deployment in Github workflows deploy.yml and manual-deployment.yml.
-   Consider user friendly reporting of PMD and ESLINT issues in GitLab, similar to GitHub approach.
-   Add proper badges for pipeline, including RunLocalTests.
-   Consider to automate listing/update Jira tickets for User Stories deployed into testing. Integration GiHub/GitLab - Jira - MS Teams
-   Consider reorganizing jobs and stages to make pipelines faster.
-   Code quality report to analyse Apex.
-   Consider [Codacy](https://docs.codacy.com/coverage-reporter/) and [CodeCov](https://about.codecov.io/tool/gitlab-ci/).
-   (Requires cobertura xml file) Leverage [Test coverage visualization](https://docs.gitlab.com/ee/user/project/merge_requests/test_coverage_visualization.html) for Apex.
-   Consider ideas from [here](https://github.com/dxatscale/dxatscale-template/blob/main/.gitlab-ci.yml) and [here](https://gitlab.com/sfdx/sfdx-cicd-template/-/blob/master/Salesforce.gitlab-ci.yml).
