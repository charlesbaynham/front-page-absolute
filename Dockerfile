# Multi-stage build: First build the site with Nix, then serve with nginx
FROM nixos/nix:latest AS builder

# Copy the source files
COPY . /src
WORKDIR /src

# Enable flakes and build the site
RUN nix --extra-experimental-features "nix-command flakes" build

# Final stage: nginx to serve the static site
FROM nginx:alpine

# Copy the built site from the Nix build
COPY --from=builder /src/result /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# nginx will run in the foreground by default
CMD ["nginx", "-g", "daemon off;"]
