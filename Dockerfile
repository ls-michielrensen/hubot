FROM ubuntu
RUN apt-get update && \
    apt-get -y install curl apt-transport-https python python-pip supervisor && \
    curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install awscli && \
	useradd -ms /bin/bash hubot && \
	npm -g install yo generator-hubot && \
	mkdir -p /var/log/supervisor

USER hubot
RUN cd /home/hubot && mkdir hubot
WORKDIR /home/hubot/hubot

# Supervisor
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Generate our Hubot -- configure this as needed
RUN yo hubot --owner "Michiel Rensen <info@michielrensen.nl>" --name hubot --adapter slack --defaults

# Add our run script to make it easier to run through ECS
ADD hubot/run.sh /home/hubot/hubot/run.sh

# Add package.json and external-scripts.json so we can customize them at build time
ADD package.json /home/hubot/hubot/package.json
ADD hubot/external-scripts.json /home/hubot/hubot/external-scripts.json
ADD hubot/hubot-scripts.json /home/hubot/hubot/hubot-scripts.json
ADD hubot/scripts /home/hubot/hubot/scripts

RUN npm install && npm cache clean
