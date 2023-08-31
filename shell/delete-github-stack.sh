# cd sagemaker-external-repository-security/shell/
# chmod u+x delete-github-stack.sh
# ./delete-github-stack.sh

echo $STACK_NAME
echo $GITHUB_TOKEN_SECRET_NAME
echo $S3_ARTIFACT_BUCKET_NAME

aws s3 rm s3://${S3_ARTIFACT_BUCKET_NAME} --recursive
aws s3 rb s3://${S3_ARTIFACT_BUCKET_NAME}

aws cloudformation delete-stack --stack-name $STACK_NAME
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

aws secretsmanager delete-secret --secret-id $GITHUB_TOKEN_SECRET_NAME
aws secretsmanager delete-secret --secret-id $GITHUB_EMAIL_SECRET_NAME