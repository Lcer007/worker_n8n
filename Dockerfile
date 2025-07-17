FROM docker.n8n.io/n8nio/n8n:1.102.3

USER root

# Install Python for tdlib dependencies
RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

# Install Telepilot Community Nodes
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
      @telepilotco/tdl \
      @telepilotco/tdlib-binaries-prebuilt \
      @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes

# Set custom node path env variable
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules

# Switch to node user (important for n8n to run properly)
USER node

# ✅ Final: Use CMD for Railway compatibility
CMD ["n8n", "worker"]

RUN echo "n8n path:" $(which n8n)

