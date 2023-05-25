# Update AWS User Credential Script

This bash script is used to update the AWS user credential by assuming a specific role. The updated credential will be valid for 1 hour.

## Prerequisites

- AWS CLI v2
- `jq` command line JSON processor

## Setup

1. Create a `.env` file in the same directory as the script with the following environment variables:

```
AWS_ACCOUNT_ID=<your_aws_account_id>
AWS_ROLE_NAME=<your_role_name>
AWS_SSO_CACHE_JSON_PATH=<path_to_your_sso_cache_json>
```

2. Make sure the script has execute permissions:

```bash
chmod +x update_credential.sh
```

## Usage

To execute the script, source it:

```bash
source update_credential.sh
```

The script will:

1. Read the environment variables from the `.env` file.
2. Read the SAML assertion from the SSO cache JSON, and save it in a temporary file.
3. Call AWS CLI to get temporary role credentials.
4. Set the temporary credentials as environment variables.
5. Clean up the temporary files.

After running the script, your current shell will have the updated AWS credential.
