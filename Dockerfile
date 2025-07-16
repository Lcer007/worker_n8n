FROM node:18

# Install n8n CLI globally
RUN npm install -g n8n

# Create folder for custom nodes
RUN mkdir -p /data/custom-nodes
WORKDIR /data/custom-nodes

# Install Telepilot + TDLib nodes
RUN npm install \
    @telepilotco/tdl \
    @telepilotco/tdlib-binaries-prebuilt \
    @telepilotco/n8n-nodes-telepilot

# Set custom extension path
ENV N8N_CUSTOM_EXTENSIONS=/data/custom-nodes/node_modules

# Use a working directory for workflows
WORKDIR /data

# Start worker
CMD ["n8n", "worker"]
