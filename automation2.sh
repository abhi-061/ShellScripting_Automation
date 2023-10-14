#!/bin/bash
for line in $(cat jiraid.txt)
do
curl -X PUT -u "Abhishek:/Jira/token" --data '{"update":{"labels":[{"add":"Token123"}]}}' -H "Content-Type: application/json" https://devops-admin.atlassian.net/browse/KAN-1
done
