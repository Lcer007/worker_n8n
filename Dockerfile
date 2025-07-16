FROM node:18

# Install n8n and Telepilot nodes globally
RUN npm install -g n8n @telepilotco/n8n-nodes-telepilot

RUN apt-get update && apt-get install -y libtdjson-dev

WORKDIR /data

# Start n8n in worker mode
CMD ["n8n", "worker"]
