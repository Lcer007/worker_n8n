FROM node:18

# Install n8n CLI globally
RUN npm install -g n8n

# Create a folder for custom extensions
RUN mkdir -p /data/custom-nodes
WORKDIR /data/custom-nodes

# Install Telepilot and dependencies
RUN npm install \
    @telepilotco/n8n-nodes-telepilot \
    @telepilotco/tdlib-binaries-prebuilt \
    @telepilotco/tdl

# Set custom extensions path
ENV N8N_CUSTOM_EXTENSIONS=/data/custom-nodes/node_modules

# Switch to working directory for n8n
WORKDIR /data

# Start the n8n worker
CMD ["n8n", "worker"]
