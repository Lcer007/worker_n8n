# n8n Worker with Telepilot (Telegram CoPilot) Support

This worker is designed to run n8n workflows that depend on `@telepilotco/n8n-nodes-telepilot` and TDLib.

## 🚀 Usage (Railway)

1. Fork this repo
2. Deploy it as a **New Service** on Railway
3. Link your existing Redis and Postgres
4. Set the environment variables matching your `main` instance
5. You're done 🎉

## 🧠 Requirements

- Redis connection (shared with main)
- Postgres DB (same as main)
- Encryption Key (same as main)
