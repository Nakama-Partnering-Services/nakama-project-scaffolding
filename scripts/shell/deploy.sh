#!/bin/bash
echo 'y' | sfdx plugins:install sfdx-git-delta
mkdir deltas
sfdx sgd:source:delta --source sfdx-source --from $2 --to HEAD --output deltas --ignore .forceignore --generate-delta
npm install fast-xml-parser
node scripts/node/environment-replacements/main.js || true
FOLDER=$(echo $1 | tr '[:upper:]' '[:lower:]') # workaround since ${1,,} does not work
cp --recursive specific-environments/$FOLDER/. sfdx-source/ || true
echo 'y' | sfdx plugins:install nakama-plugin-sfdx
sfdx nps:package:destructive:versionobsoleteflows --path deltas/destructiveChanges/destructiveChanges.xml
TARGET_SFDX_AUTH_URL=$(eval echo \${${1}_SFDX_AUTH_URL})
echo $TARGET_SFDX_AUTH_URL > ./TARGET_SFDX_AUTH_URL.txt
sfdx auth:sfdxurl:store --sfdxurlfile ./TARGET_SFDX_AUTH_URL.txt --setdefaultusername
if [ "$3" = "validation" ]; then
	sfdx force:source:deploy --wait 60 --checkonly --manifest deltas/package/package.xml --postdestructivechanges deltas/destructiveChanges/destructiveChanges.xml --verbose --testlevel RunLocalTests --json > results.json
else
	sfdx force:source:deploy --wait 60 --manifest deltas/package/package.xml --postdestructivechanges deltas/destructiveChanges/destructiveChanges.xml --verbose
fi