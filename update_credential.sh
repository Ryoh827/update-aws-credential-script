#/bin/bash

# This script is used to update the credential of the user
# It will assume the role and update the credential in the current shell
# The credential will be expired in 1 hour
# 
# Usage: source update_credential.sh

# Get environment variables
# AWS_ACCOUNT_ID
# AWS_ROLE_NAME
# AWS_SSO_CACHE_JSON_PATH
source ./.env

# Get the SAML assertion
cat $AWS_SSO_CACHE_JSON_PATH | jq -r '.accessToken' > /tmp/aws_access_token

# Get aws-role-credentials
aws sso get-role-credentials --role-name $AWS_ROLE_NAME --account-id $AWS_ACCOUNT_ID --access-token $(cat /tmp/aws_access_token) > /tmp/assume-role-output.json

# Get the temporary credentials
export AWS_ACCESS_KEY_ID=$(cat /tmp/assume-role-output.json | jq -r '.roleCredentials.accessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat /tmp/assume-role-output.json | jq -r '.roleCredentials.secretAccessKey')
export AWS_SESSION_TOKEN=$(cat /tmp/assume-role-output.json | jq -r '.roleCredentials.sessionToken')

# Clean up
rm /tmp/aws_access_token
rm /tmp/assume-role-output.json

