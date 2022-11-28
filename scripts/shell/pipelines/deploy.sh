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
	RUN_TEST_PARAMETER=$(echo "--testlevel RunSpecifiedTests --runtests $TEST_CLASSES")
fi
npm install fast-xml-parser
node scripts/node/environment-replacements/main.js || true
FOLDER=$(echo $1 | tr '[:upper:]' '[:lower:]') # workaround since ${1,,} does not work
cp --recursive specific-environments/$FOLDER/. sfdx-source/ || true
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
if [ "$3" = "validation" ]; then
	sfdx force:source:deploy --wait 60 --checkonly --manifest deltas/package/package.xml --postdestructivechanges deltas/destructiveChanges/destructiveChanges.xml --verbose $RUN_TEST_PARAMETER --ignorewarnings --json > results.json
else
	sfdx force:source:deploy --wait 60 --manifest deltas/package/package.xml --postdestructivechanges deltas/destructiveChanges/destructiveChanges.xml --verbose --ignorewarnings
fi