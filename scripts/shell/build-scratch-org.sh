echo "Preparing scratch org..."
sh scripts/shell/prepare-scratch-org.sh

echo "Replacing environment specific metadata..."
cp --recursive specific-environments/scratch-org/. sfdx-source/

# echo "Deploying packages..."
# sh scripts/shell/deploy-packages.sh

echo "Push metadata to org..."
sfdx force:source:push
