FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

# Install custom nodes
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
        @telepilotco/tdl \
        @telepilotco/tdlib-binaries-prebuilt \
        @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes


USER node

# ✅ Use this so Railway doesn't mess up the entrypoint
ENTRYPOINT ["node", "/usr/local/lib/node_modules/n8n/bin/n8n", "worker"]
