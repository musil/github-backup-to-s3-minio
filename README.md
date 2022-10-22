# Script to backup all github repositories to S3 Minio server

## install github CLI

```
sudo apt install gh

```

## install S3 client
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

## inittialize GitHub authentication

```
gh auth login
```

## configure s3

```
aws configure
```
