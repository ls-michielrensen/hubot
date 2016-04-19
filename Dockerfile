FROM ubuntu
RUN apt-get update && \
    apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get install -y nodejs
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add a user to run Hubot
RUN useradd -ms /bin/bash hubot

# Fetch the packages required to generate our Hubot
RUN npm -g install yo generator-hubot

USER hubot
RUN cd /home/hubot && mkdir hubot
WORKDIR /home/hubot/hubot

# Generate our Hubot -- configure this as needed
RUN yo hubot --owner "Michiel Rensen <info@michielrensen.nl>" --name hubot --adapter slack --defaults

# Add our run script to make it easier to run through ECS
ADD hubot/run.sh /home/hubot/hubot/run.sh

# Add package.json and external-scripts.json so we can customize them at build time
ADD package.json /home/hubot/hubot/package.json
ADD hubot/external-scripts.json /home/hubot/hubot/external-scripts.json
ADD hubot/hubot-scripts.json /home/hubot/hubot/hubot-scripts.json

RUN npm install

# Cleanup
RUN npm cache clean
