echo "Installing frameworks package..."
sfdx force:package:install -p 04t4L000000YajmQAC -w 10 --noprompt -u $1

echo "Replacing environment specific metadata..."
sh scripts/shell/environment-replacements/scratch-org.sh

echo "Deploying salesforce core package..."
sfdx force:source:deploy -p sfdx-source/core -u $1
