FROM docker.n8n.io/n8nio/n8n:1.102.3

USER root

# Install required dependencies
RUN apk add --no-cache python3 py3-pip && ln -sf python3 /usr/bin/python

# Install Telepilot custom nodes
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
        @telepilotco/tdl \
        @telepilotco/tdlib-binaries-prebuilt \
        @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n

ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules

# Set PATH just in case Railway resets it
ENV PATH="/usr/local/bin:$PATH"

USER node

# Final CMD (worker mode)
CMD ["n8n", "worker"]
RUN echo "DEBUG: $(which n8n)" && ls -la /usr/local/bin/n8n
