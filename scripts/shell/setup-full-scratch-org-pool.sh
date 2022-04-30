echo "Installing frameworks package..."
sfdx force:package:install -p 04t7Q000000cifCQAQ -w 10 --noprompt -u $1

echo "Replacing environment specific metadata..."
cp --recursive specific-environments/scratch-org/. sfdx-source/

# echo "Deploying salesforce core package..."
# sfdx force:source:deploy -p sfdx-source/core -u $1

echo "Push metadata to org..."
sfdx force:source:push -u $1
