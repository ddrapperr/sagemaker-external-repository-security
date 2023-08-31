# If not already cloned, clone remote repository and change working directory to shell folder
# git clone  https://github.com/aws-samples/sagemaker-external-repo-access.git
# cd sagemaker-external-repo-access/shell/
# chmod u+x create-stack.sh 

# Use defaults or provide your own parameter values for CloudFormation stack and CodePipeline pipeline names
STACK_NAME=<Your Stack Name>
CODEPIPELINE_NAME=<Your CodePipeline Name>

# Below parameter values acquired from 'Establish VPC Networking Configuration' pre-deployment section
CODEBUILD_VPC_ID=<Your VPC ID>
CODEBUILD_SUBNET_ID1=<Your Private Subnet ID 1>
CODEBUILD_SUBNET_ID2=<Your Private Subnet ID 2>

# Below parameter values acquired from 'Gather Third-Party Repository Configuration Settings' and 'Create GitHub Personal Access Token' pre-deployment sections
GITHUB_BRANCH=<Your External Package Repository Branch>
GITHUB_OWNER=<Your Private Package Repository Owner>
GITHUB_REPO=<Your Private Repository Repo>
GITHUB_USER=<Your Private Repository User>
GITHUB_TOKEN_SECRET_NAME=<Your Private Repository PAT Secret Name>
GITHUB_EMAIL_SECRET_NAME=<Your Private Repository Email Secret Name>
PUBLIC_GITHUB_URL=<Your External Package Repository URL>
PRIVATE_GITHUB_URL=<Your Private Package Repository URL>

# Use defaults or provide your own parameter values for CodeBuild custom build actions
REPO_CLONE_ACTION_PROVIDER=<Your External Repository Clone CodeBuild Provider Name>
REPO_CLONE_ACTION_VERSION=<Your External Repository Clone CodeBuild Provider Version>
SECURITY_SCAN_ACTION_PROVIDER=<Your Security Scans CodeBuild Provider Name>
SECURITY_SCAN_ACTION_VERSION=<Your Security Scans CodeBuild Provider Version>
REPO_PUSH_ACTION_PROVIDER=<Your Private Repository Push CodeBuild Provider Version>
REPO_PUSH_ACTION_VERSION=<Your Private Repository Push CodeBuild Provider Version>

# Below parameter values acquired from 'Create S3 and Upload Lambda Function' pre-deployment section
LAMBDA_S3_BUCKET=<Your CodeBuild Custom Action Lambda S3 Bucket>
LAMBDA_S3_KEY=<Your CodeBuild Custom Action Lambda S3 Object Key>

aws cloudformation create-stack \
--stack-name ${STACK_NAME} \
--template-body file://../cfn/external-repo-access.yaml \
--parameters \
ParameterKey=CodePipelineName,ParameterValue=${CODEPIPELINE_NAME} \
ParameterKey=CodeBuildLambdaVpc,ParameterValue=${CODEBUILD_VPC_ID} \
ParameterKey=CodeBuildLambdaSubnet,ParameterValue=${CODEBUILD_SUBNET_ID1}\\,${CODEBUILD_SUBNET_ID2} \
ParameterKey=GitHubBranch,ParameterValue=${GITHUB_BRANCH} \
ParameterKey=GitHubOwner,ParameterValue=${GITHUB_OWNER} \
ParameterKey=GitHubRepo,ParameterValue=${GITHUB_REPO} \
ParameterKey=GitHubUser,ParameterValue=${GITHUB_USER} \
ParameterKey=GitHubTokenSecretName,ParameterValue=${GITHUB_TOKEN_SECRET_NAME} \
ParameterKey=GitHubEmailSecretName,ParameterValue=${GITHUB_EMAIL_SECRET_NAME} \
ParameterKey=PublicGitHubUrl,ParameterValue=${PUBLIC_GITHUB_URL} \
ParameterKey=PrivateGitHubUrl,ParameterValue=${PRIVATE_GITHUB_URL} \
ParameterKey=RepoCloneActionProvider,ParameterValue=${REPO_CLONE_ACTION_PROVIDER} \
ParameterKey=RepoCloneActionVersion,ParameterValue=${REPO_CLONE_ACTION_VERSION} \
ParameterKey=SecurityScanActionProvider,ParameterValue=${SECURITY_SCAN_ACTION_PROVIDER} \
ParameterKey=SecurityScanActionVersion,ParameterValue=${SECURITY_SCAN_ACTION_VERSION} \
ParameterKey=RepoPushActionProvider,ParameterValue=${REPO_PUSH_ACTION_PROVIDER} \
ParameterKey=RepoPushActionVersion,ParameterValue=${REPO_PUSH_ACTION_VERSION} \
ParameterKey=LambdaCodeS3Bucket,ParameterValue=${LAMBDA_S3_BUCKET} \
ParameterKey=LambdaCodeS3Key,ParameterValue=${LAMBDA_S3_KEY} \
--capabilities CAPABILITY_IAM
