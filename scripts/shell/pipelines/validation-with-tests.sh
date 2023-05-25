#!/bin/bash
# Checking if org is already authenticated, like in github
auth_orgs=$(sfdx auth:list --json)
number_of_orgs=$(jq '.result | length' <<< $auth_orgs)
if [ "$number_of_orgs" = 0 ]; then
	DESTINATION_SFDX_AUTH_URL=$(eval echo \${${1}_SFDX_AUTH_URL})
	echo $DESTINATION_SFDX_AUTH_URL > ./DESTINATION_SFDX_AUTH_URL.txt
	sfdx auth:sfdxurl:store --sfdxurlfile ./DESTINATION_SFDX_AUTH_URL.txt --setdefaultusername
fi
# Note: sfdx force:apex:test:run not used until this known issue is fixed https://trailblazer.salesforce.com/issues_view?id=a1p4V000002JRzNQAW
sfdx force:source:deploy --wait 60 --checkonly -m LightningComponentBundle:showToastUtility --testlevel RunLocalTests --verbose --junit --resultsdir test-results
