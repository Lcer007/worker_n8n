FROM docker.n8n.io/n8nio/n8n:latest

CMD ["n8n", "worker"]

USER root

RUN apk update && apk add --no-cache python3 py3-pip && ln -sf python3 /usr/bin/python

RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/tdl && \
    npm install @telepilotco/tdlib-binaries-prebuilt && \
    npm install @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes

USER node
