#!/bin/bash
aws s3 cp --region us-east-1 "s3://${HUBOT_BUCKET}/env.sh" .
. ./env.sh;
bin/hubot --adapter slack
