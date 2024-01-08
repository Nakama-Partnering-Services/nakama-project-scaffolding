# specific-environments

This folder is to organize metadata files tied to specific environments, such as certain configurations of custom metadata records or named credentials.

To deploy this metadata to the different organizations, the metadata needs to exists as well in the force-app root folder. Currently the versions stored there are the sames as for the CICD environment.

In order to deploy modifications of these files, they need to be detected as deltas. In order to achieve that, a change needs to be applied to the version existing in the force-app folder as well.

Files within this folders are added to .forceignore file.
