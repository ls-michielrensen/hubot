#!/bin/bash
aws s3 cp --region eu-east-1 s3://cml-ls-hubot/env.sh .
. ./env.sh;
bin/hubot --adapter slack
