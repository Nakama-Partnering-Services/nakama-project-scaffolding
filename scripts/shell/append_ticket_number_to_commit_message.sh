#!/usr/bin/env sh

commit_message_file="$1"
commit_message=$(cat "$commit_message_file")

# Get the current branch name
current_branch=$(git symbolic-ref --short HEAD)

# Extract the Jira ticket number from the branch name (assuming it follows the pattern "(feature|bugfix|hotfix|chore)/<project-key>-<ticket number>")
ticket_number=$(echo "$current_branch" | sed -n -E 's/^(feature|bugfix|hotfix|chore)\/([A-Z]+[0-9]*+-[0-9]+).*/\2/p')

# Check if a Jira ticket number was found
if [ -n "$ticket_number" ]; then
  # Append the Jira ticket number in parentheses to the commit message
  new_commit_message="$commit_message ($ticket_number)"

  # Replace the original commit message with the new one
  echo "$new_commit_message" > "$commit_message_file"
fi

