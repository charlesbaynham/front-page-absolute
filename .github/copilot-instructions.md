# GitHub Copilot Instructions

This repository contains a single-page website built with Jekyll and Bootstrap.

## Project Structure

- `_config.yml` - Jekyll configuration
- `_layouts/default.html` - Bootstrap-based layout template
- `index.md` - Main page content
- `Gemfile` - Ruby dependencies
- `flake.nix` - Nix flake for building and serving the site

## Development

### Using Nix (recommended)

```bash
# Build the site
nix run .#build

# Serve the site with live reload (for development)
nix run .#serve

# Enter development shell
nix develop
```

### Using Ruby/Bundler directly

```bash
# Install dependencies
bundle install

# Build the site
bundle exec jekyll build

# Serve the site
bundle exec jekyll serve
```

## Deployment

The site is configured to deploy automatically to GitHub Pages via GitHub Actions when changes are pushed to the `main` branch.

## Guidelines for Copilot

- This is a Jekyll-based static site using Bootstrap 5
- Keep the site simple and single-page focused
- Use Bootstrap classes for styling
- Maintain compatibility with GitHub Pages
- The Nix flake provides reproducible builds
- Follow Jekyll's templating conventions (Liquid templates)
