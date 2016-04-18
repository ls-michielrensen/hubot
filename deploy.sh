#! /bin/bash

VERSION=v$1

# Create new Elastic Beanstalk version
EB_BUCKET=hello-bucket
DOCKERRUN_FILE=Dockerrun.aws.json
sed -i'' -e "s;%BUILD_NUM%;$VERSION;g" ./Dockerrun.aws.json
aws elasticbeanstalk create-application-version --application-name hubot \
  --version-label $VERSION --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name ls-hubot \
    --version-label $VERSION
