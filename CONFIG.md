# pipeline-development

## General

-   Merge method: fast-forward merge (achieve it by applying rebase locally).
-   Enabled merged result pipelines and merge trains. (Optional, not needed since we force rebasing)
-   Squash commits when merging are required.
-   Pipelines must succeed before merging.
-   All discussions must be resolved before merging.
-   2 approvals are required for a merge request. (Optional, sometimes just 1 is enough for little projects)
-   1 maintainer approval is required if the merge request decreases code coverage. (Optional, code coverage is not always calculated)
-   Approvals from author or users who add commits are prevented.
-   Approvals are removed when new commits are pushed to the branch.

## Repository

-   Protected default (main) and release branches.
-   Branch names should match this regular expression: `(feature|bugfix|hotfix|release|chore)\/*`
-   Only mantainers are allowed to merge and (force) push to protected branches.
