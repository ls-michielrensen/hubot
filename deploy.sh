#! /bin/bash

VERSION=$1
PROFILE=$2

# Create new Elastic Beanstalk version
EB_BUCKET=cml-ls-hubot
DOCKERRUN_FILE=$VERSION-Dockerrun.aws.json

sed "s/<TAG>/$VERSION/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE
aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE $( if [ -n "${PROFILE}" ]; then echo "--profile $PROFILE"; fi )

aws elasticbeanstalk create-application-version \
  --application-name ls-hubot \
  --version-label $VERSION \
  --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE \
  $( if [ -n "${PROFILE}" ]; then echo "--profile $PROFILE"; fi )

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name ls-hubot-env \
    --version-label $VERSION \
    $( if [ -n "${PROFILE}" ]; then echo "--profile $PROFILE"; fi )
