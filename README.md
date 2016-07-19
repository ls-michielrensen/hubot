# Hubot

Run your own Hubot in a Docker container on Slack. This container comes prepackaged with a run script that is kicked off by supervisor to keep it running. It uses a S3-bucket to get environment variables from on runtime (not required). 
In order to use S3, 3 environment variables are required: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, HUBOT_BUCKET. 
Have a look at `env.sh.dist` to see what environment variables are used.

## How to use
`docker run -it michielrensen/hubot -e AWS_ACCESS_KEY_ID=<YOURKEYID> -e AWS_SECRET_ACCESS_KEY=<YOURACCESSKEY> -e HUBOT_BUCKET=<S3BUCKET>`

This will run supervisor that kicks off the run script that will download the env-file form S3 and run hubot.


