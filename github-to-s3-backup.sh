!/bin/bash
BACKUP_BUCKET_NAME="github-backup"
BACKUP_GITHUB_OWNER="USERNAME"
BACKUP_S3_REGION="us-east-1"
S3_SERVER="DNS__OR__IP"


mkdir -p /tmp/$BACKUP_BUCKET_NAME/

# echo "Logging in with your personal access token."
# export GITHUB_TOKEN=$BACKUP_GITHUB_PERSONAL_ACCESS_TOKEN

## manual setup:
# gh auth setup-git
## S3 config
# aws configure 

echo "Downloading repositories for" $BACKUP_GITHUB_OWNER
gh repo list $BACKUP_GITHUB_OWNER --json "name" --limit 1000 --template '{{range .}}{{ .name }}{{"\n"}}{{end}}' | xargs -L1 -I {} gh repo clone $BACKUP_GITHUB_OWNER/{} /tmp/$BACKUP_BUCKET_NAME/{}

echo "Downloaded repositories..."
find  . -maxdepth 1 -type d

echo "Uploading to MinIO S3 bucket" $BACKUP_BUCKET_NAME "in region" $BACKUP_S3_REGION
aws --endpoint-url https://$S3_SERVER s3 sync --region=$BACKUP_S3_REGION . s3://$BACKUP_BUCKET_NAME/github.com/$BACKUP_GITHUB_OWNER/`date "+%Y-%m-%d_%H:%m:%S"`/
echo "Complete."
