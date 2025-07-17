# ✅ Use official n8n image — NOT `latest` (can be unstable)
FROM docker.n8n.io/n8nio/n8n:1.102.3

USER root

# ✅ Optional: Install python if needed by Telepilot
RUN apk add --no-cache python3 py3-pip && ln -sf python3 /usr/bin/python

# ✅ Install Telepilot and dependencies
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
      @telepilotco/tdl \
      @telepilotco/tdlib-binaries-prebuilt \
      @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes

# ✅ Let n8n know where to find the community nodes
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules

USER node

# ✅ Set proper entrypoint — this is the main fix!
CMD ["n8n", "worker"]
