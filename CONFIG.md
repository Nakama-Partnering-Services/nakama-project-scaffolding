# pipeline-development

## General

-   Merge method: fast-forward merge (achieve it by applying rebase locally).
-   Squash commits when merging are required.
-   Pipelines must succeed before merging. Skipped pipelines are considered successful.
-   All discussions must be resolved before merging.

## Repository

-   Protected default (main) and release branches.
-   Only mantainers are allowed to merge and push to protected branches.
