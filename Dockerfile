FROM node:18

# Install n8n CLI and Telepilot globally
RUN npm install -g n8n \
    @telepilotco/n8n-nodes-telepilot \
    @telepilotco/tdl \
    @telepilotco/tdlib-binaries-prebuilt

# Use the global node_modules path for loading custom nodes
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules

# Working directory for n8n
WORKDIR /data

# Start the worker
CMD ["n8n", "worker"]
