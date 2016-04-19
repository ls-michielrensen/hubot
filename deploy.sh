#! /bin/bash

VERSION=$1
PROFILE=$2

# Create new Elastic Beanstalk version
sed -i'' "s;%BUILD_NUM%;$VERSION;g" ./Dockerrun.aws.json
aws elasticbeanstalk create-application-version --application-name ls-hubot \
  --version-label $VERSION --profile $PROFILE

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name ls-hubot-env \
    --version-label $VERSION --profile $PROFILE
