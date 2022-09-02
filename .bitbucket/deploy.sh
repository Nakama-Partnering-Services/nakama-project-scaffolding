#!/bin/bash
sf plugins install sfdx-git-delta
mkdir deltas
LAST_DEPLOYMENT_COMMIT_SHA=$(eval echo \${${1}_LAST_DEPLOYMENT_COMMIT_SHA})
DESTINATION_SFDX_AUTH_URL=$(eval echo \${${1}_SFDX_AUTH_URL})
echo $DESTINATION_SFDX_AUTH_URL > ./DESTINATION_SFDX_AUTH_URL.txt
sfdx auth:sfdxurl:store --sfdxurlfile ./DESTINATION_SFDX_AUTH_URL.txt --setdefaultusername
npm install fast-xml-parser
node scripts/node/environment-replacements/main.js || true
FOLDER=${1,,}
cp --recursive specific-environments/$FOLDER/. sfdx-source/ || true
sf plugins install nakama-plugin-sfdx
sf nps package destructive versionobsoleteflows --path deltas/destructiveChanges/destructiveChanges.xml
# RUN_TEST_PARAMETER can be uncommented to double also run tests on deployments to integration, however it is redundant with MR and will take longer.
# - RUN_TEST_PARAMETER=$(if [ $TEST_CLASSES ]; then echo "--testlevel RunSpecifiedTests --runtests $TEST_CLASSES"; else echo ""; fi)
sfdx force:source:deploy --manifest deltas/package/package.xml --postdestructivechanges deltas/destructiveChanges/destructiveChanges.xml
# curl --request PUT --header "PRIVATE-TOKEN: $PIPELINE_ACCESS_TOKEN" \
# 	"$CI_API_V4_URL/projects/$CI_PROJECT_ID/variables/${1}_LAST_DEPLOYMENT_COMMIT_SHA" --form "value=$CI_COMMIT_SHA"