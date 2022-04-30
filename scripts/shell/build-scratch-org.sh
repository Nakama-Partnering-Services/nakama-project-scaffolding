echo "Preparing scratch org..."
sh scripts/shell/prepare-scratch-org.sh

echo "Replacing environment specific metadata..."
sh scripts/shell/environment-replacements/scratch-org.sh

echo "Deploying packages..."
sh scripts/shell/deploy-packages.sh
