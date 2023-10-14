#!/bin/bash

# Jira API URL
JIRA_URL="https://devops-admin.atlassian.net/browse/DEV-2"

# Jira project key
PROJECT_KEY="DEV"

# Jira username and API token (or password)
JIRA_USERNAME="Abhishek"
JIRA_API_TOKEN="ATATT3xFfGF0TCogvynsNIUX5DkaSlwdMFNNd73gCIM6tAC6kpFROG-bGy9s_d3OAyXEJrslOnKXicisJr3vTVOWB9YFSbczH_sHhoN_tCjP3yMYWm_9SoPjB93rWRgughum7t2s_7YgE5dNDuPzC_7qWWMF7Rr8MDaK8GjpFMgxaBF0CtL25rE=96DC3FF2"

# Label to add
LABEL_TO_ADD="Automate_1"

# Issue key for which you want to add the label
ISSUE_KEY="DEV-1"

# Authenticate with Jira using Basic Authentication
AUTH_HEADER=$(echo -n "$JIRA_USERNAME:$JIRA_API_TOKEN" | base64)
AUTH_HEADER="Basic $AUTH_HEADER"

# Add label to the issue
add_label() {
    local issue_key="$1"
    local label="$2"

    local API_ENDPOINT="${JIRA_URL}/rest/api/3/issue/${issue_key}"

    # JSON payload to add the label
    JSON_DATA="{\"update\": {\"labels\": [{\"add\": \"$label\"}]}}"

    # Make the API request to add the label
    curl -s -X PUT -H "Authorization: $AUTH_HEADER" -H "Content-Type: application/json" -d "$JSON_DATA" "$API_ENDPOINT"
}

# Call the function to add the label to the issue
add_label "$ISSUE_KEY" "$LABEL_TO_ADD"

echo "Label '$LABEL_TO_ADD' added to issue $ISSUE_KEY."



# Call the function to add the label to the issue
response=$(add_label "$ISSUE_KEY" "$LABEL_TO_ADD")

# Check for errors in the API response
error=$(echo "$response" | jq -r '.errorMessages[0]')

if [ -n "$error" ]; then
  echo "Error: $error"
  exit 1
else
  echo "Label '$LABEL_TO_ADD' added to issue $ISSUE_KEY."
fi

