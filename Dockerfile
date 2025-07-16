FROM docker.n8n.io/n8nio/n8n:1.102.3

USER root

RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
      @telepilotco/tdl \
      @telepilotco/tdlib-binaries-prebuilt \
      @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes

ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules
RUN echo 'console.log("🧪 Checking if Telepilot node exists:", require("@telepilotco/n8n-nodes-telepilot"));' >> /usr/local/lib/node_modules/n8n/packages/cli/src/cli.ts

USER node

# Force entrypoint for Railway
ENTRYPOINT ["node", "/usr/local/lib/node_modules/n8n/bin/n8n", "worker"]
