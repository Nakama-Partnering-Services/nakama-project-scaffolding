#!/bin/bash
echo 'y' | sfdx plugins:install sfdx-git-delta
mkdir deltas
sfdx sgd:source:delta --source sfdx-source --from $2 --to HEAD --output deltas --ignore .forceignore --generate-delta
TEST_LEVEL=$4
TEST_CLASSES=$5
if [ ! $TEST_LEVEL ]; then
	TEST_CLASSES=$( (egrep -wrli @IsTest deltas || echo "") | xargs -rL 1 basename | sed 's/.cls//g' | paste -sd "," -)
	RUN_TEST_PARAMETER=$(if [ $TEST_CLASSES ]; then echo "--testlevel RunSpecifiedTests --runtests $TEST_CLASSES"; else echo ""; fi)
elif [ ! $TEST_CLASSES ]; then
	RUN_TEST_PARAMETER=$(echo "--testlevel $TEST_LEVEL")
else
	# TEST_LEVEL has to be RunSpecifiedTests
	# merge test classes from pull request with specified
	TEST_CLASSES_PR=$( (egrep -wrli @IsTest deltas || echo "") | xargs -rL 1 basename | sed 's/.cls//g' | paste -sd "," -)
	RUN_TEST_PARAMETER=$(echo "--testlevel RunSpecifiedTests --runtests ${TEST_CLASSES}${TEST_CLASSES_PR:+,$TEST_CLASSES_PR}")
fi
npm install fast-xml-parser
node scripts/node/environment-replacements/main.js || true
FOLDER=$(echo $1 | tr '[:upper:]' '[:lower:]') # workaround since ${1,,} does not work
cp --recursive specific-environments/$FOLDER/. sfdx-source/ || true
# sfdx shane:source:replace as well may be helpful
# checking if org is already authenticated, like in github
auth_orgs=$(sfdx auth:list --json)
number_of_orgs=$(jq '.result | length' <<< $auth_orgs)
if [ "$number_of_orgs" = 0 ]; then
	TARGET_SFDX_AUTH_URL=$(eval echo \${${1}_SFDX_AUTH_URL})
	echo $TARGET_SFDX_AUTH_URL > ./TARGET_SFDX_AUTH_URL.txt
	sfdx auth:sfdxurl:store --sfdxurlfile ./TARGET_SFDX_AUTH_URL.txt --setdefaultusername
fi
echo 'y' | sfdx plugins:install nakama-plugin-sfdx
sfdx nps:package:destructive:versionobsoleteflows --path deltas/destructiveChanges/destructiveChanges.xml
# if problems with any experience .json file, try using this -> sfdx shane:communities:json:modify
# parameters.VALIDATION comes as "True" if checked in Azure manual deployment
# ${{ github.event.inputs.checkonly } comes as "true" if checked in Github manual deployment
# $checkonly comes as "true" if checked in Bitbucket manual deployment
VALIDATION_ONLY=$(echo $checkonly | tr '[:upper:]' '[:lower:]') # workaround since ${3,,} does not work
if [ "$3" = "true" ]; then
	sfdx force:source:deploy --wait 60 --checkonly --manifest deltas/package/package.xml --postdestructivechanges deltas/destructiveChanges/destructiveChanges.xml --verbose $RUN_TEST_PARAMETER --ignorewarnings --junit --coverageformatters cobertura --resultsdir test-results --json > results.json
else
	sfdx force:source:deploy --wait 60 --manifest deltas/package/package.xml --postdestructivechanges deltas/destructiveChanges/destructiveChanges.xml --verbose $RUN_TEST_PARAMETER --ignorewarnings
	# if there is a new experience bundle, then run -> sfdx shane:communities:activate
	# if anything changes within experience/folders, then run -> sfdx shane:communities:publish
fi