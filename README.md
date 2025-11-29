# Traefik Hello World Project

A simple Docker Compose project that serves a "Hello World" page through Traefik reverse proxy.

## Services

- **Traefik**: Reverse proxy and load balancer
- **Hello World**: Simple nginx container serving a static HTML page

## Domain Configuration

The hello-world service responds to:
- `houseabsolute.co.uk`
- `www.houseabsolute.co.uk`

## Getting Started

1. Start the services:
   ```bash
   docker-compose up -d
   ```

2. Access the services:
   - Hello World: http://houseabsolute.co.uk or http://www.houseabsolute.co.uk
   - Traefik Dashboard: http://localhost:8080

3. For local testing, add the following to your `/etc/hosts` file:
   ```
   127.0.0.1 houseabsolute.co.uk
   127.0.0.1 www.houseabsolute.co.uk
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

- The Traefik dashboard is accessible at port 8080 (insecure mode for development)
- For production, configure SSL/TLS certificates using Let's Encrypt
- The hello-world service uses nginx:alpine for a lightweight container
