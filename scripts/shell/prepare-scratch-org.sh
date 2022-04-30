echo "Creating scratch org..."
sfdx force:org:create --definitionfile config/project-scratch-def.json --setdefaultusername --durationdays 30 --setalias scratch-org

echo "Installing frameworks package..."
sh scripts/shell/install-packages/unlocked/Frameworks.sh
