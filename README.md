# Traefik Hello World Project

A simple Docker Compose project that serves a "Hello World" page through an external Traefik reverse proxy.

## Prerequisites

This project requires a running Traefik instance on the external `traefik` network. See the `traefik/` directory for setting up the shared Traefik instance.

1. Create the external network (if not already created):
   ```bash
   docker network create traefik
   ```

2. Start the Traefik instance (from the `traefik/` directory):
   ```bash
   cd ../traefik
   docker compose up -d
   ```

## Services

- **Hello World**: Simple nginx container serving a static HTML page

## Domain Configuration

Configure the domain in `.env` file (copy from `.env.example`):
- `TRAFIK_HOST`: The domain name for the hello-world service (e.g., `houseabsolute.co.uk`)

## Getting Started

1. Copy the example environment file and configure your domain:
   ```bash
   cp .env.example .env
   # Edit .env to set TRAFIK_HOST
   ```

2. Start the service:
   ```bash
   docker-compose up -d
   ```

3. Access the service:
   - Hello World: https://houseabsolute.co.uk (or your configured domain)

4. For local testing, add your domain to your `/etc/hosts` file:
   ```
   127.0.0.1 houseabsolute.co.uk
   ```

## Stopping the Services

```bash
docker-compose down
```

## Project Structure

```
.
├── docker-compose.yml    # Docker Compose configuration
├── html/
│   └── index.html       # Hello World HTML page
├── .env.example         # Environment variables example
└── README.md           # This file
```

## Notes

- This project uses an external Traefik instance for SSL/TLS termination and reverse proxying
- SSL certificates are managed by the Traefik instance using Let's Encrypt
- The hello-world service is connected to both the default network and the external `traefik` network

- The Traefik dashboard is accessible at port 8080 (insecure mode for development)
- For production, configure SSL/TLS certificates using Let's Encrypt
- The hello-world service uses nginx:alpine for a lightweight container
