# Clean up
---

You must clean up provisioned resources to avoid charges in your AWS account.

## Step 1: Revoke GitHub Personal Access Token

GitHub PATs are configured with an expiration value. If you want to ensure that your PAT cannot be used for programmatic access to your internal private GitHub repository before it reaches its expiry, you can revoke the PAT by following [GitHub's instructions](https://docs.github.com/en/organizations/managing-programmatic-access-to-your-organization/reviewing-and-revoking-personal-access-tokens-in-your-organization).

## Step 2: Clean Up SageMaker Studio MLOps Projects

SageMaker Studio projects and corresponding S3 buckets with project and pipeline artifacts will incur a cost in your AWS account. To delete your SageMaker Studio Domain and corresponding applications, notebooks, and data, please following the instructions in the [SageMaker Developer Guide](https://docs.aws.amazon.com/sagemaker/latest/dg/gs-studio-delete-domain.html).

## Step 3: Delete `external-repo-codeartifact.yaml` CloudFormation Stack
If you used CodeArtifact as your private internal package repository, use ```./delete-codeartifact-stack.sh``` to delete your solution stack.
If you used GitHub as your private internal package repository, use ```./delete-github-stack.sh``` to delete your solution stack.

The above shell command needs to be executed from the same working directory in which you deployed the solution stack so that it can reference the appropriate environment variables that were set as part of the deployment automation script. 
The shell command executes the following AWS CLI commands to delete the solution stack:

#### Clean-Up Automation Script
```sh
# cd sagemaker-external-repository-security/shell/
# chmod u+x delete-codeartifact-stack.sh
# ./delete-codeartifact-stack.sh

echo $STACK_NAME
echo $GITHUB_TOKEN_SECRET_NAME
echo $S3_ARTIFACT_BUCKET_NAME

aws s3 rm s3://${S3_ARTIFACT_BUCKET_NAME} --recursive
aws s3 rb s3://${S3_ARTIFACT_BUCKET_NAME}

aws cloudformation delete-stack --stack-name $STACK_NAME
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

aws secretsmanager delete-secret --secret-id $GITHUB_TOKEN_SECRET_NAME
```

---

[Back to README](../README.md)

---

Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: MIT-0
