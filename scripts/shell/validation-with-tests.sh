#!/bin/bash
DESTINATION_SFDX_AUTH_URL=$(eval echo \${${1}_SFDX_AUTH_URL})
echo $DESTINATION_SFDX_AUTH_URL > ./DESTINATION_SFDX_AUTH_URL.txt
sfdx auth:sfdxurl:store --sfdxurlfile ./DESTINATION_SFDX_AUTH_URL.txt --setdefaultusername
sfdx force:source:deploy --wait 60 --checkonly -m LightningComponentBundle:showToastUtility --testlevel RunLocalTests
