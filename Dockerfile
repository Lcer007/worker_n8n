FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

# Устанавливаем библиотеки Telepilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm i @telepilotco/tdl && \
    npm i @telepilotco/tdlib-binaries-prebuilt && \
    npm i @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes 

USER node

