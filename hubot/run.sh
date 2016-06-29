#!/bin/bash
echo "$AWS_ACCESS_KEY_ID, $AWS_SECRET_ACCESS_KEY, $HUBOT_BUCKET"
aws s3 cp --region us-east-1 "s3://${HUBOT_BUCKET}/env.sh" .
. ./env.sh;
bin/hubot --adapter slack
