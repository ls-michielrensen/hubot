FROM ubuntu

RUN apt-get update && \
    apt-get -y install expect redis-server nodejs npm python-pip && \
    pip install awscli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/nodejs /usr/bin/node

# Create hubot user
RUN	useradd -d /hubot -m -s /bin/bash -U hubot

# Log in as hubot user and change directory
USER	hubot
WORKDIR /hubot

# Install hubot
RUN npm install -g coffee-script yo generator-hubot
RUN yo hubot --owner="Michiel <michiel.rensen@lightspeedh>" --name="Michielrensen" --description="Roll, roll, rollercoaster" --defaults

# Some adapters / scripts
ADD package.json /hubot/package.json
RUN npm install 

# Activate some built-in scripts
ADD hubot/hubot-scripts.json /hubot/
ADD hubot/external-scripts.json /hubot/

# And go
CMD ["/bin/sh", "-c", "bin/hubot --adapter slack"]
#CMD ["/bin/sh", "-c", "aws s3 cp --region eu-west-1 s3://pgarbe-secrets/env.sh .; . ./env.sh; bin/hubot --adapter slack"]
