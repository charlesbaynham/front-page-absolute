# Front Page Absolute

A single-page website built with Jekyll and Bootstrap, configured for deployment with GitHub Pages.

## Features

- Single-page responsive website
- Bootstrap 5 default template
- Nix flake for reproducible builds
- GitHub Pages deployment via GitHub Actions
- Live reload development server

## Development

### Prerequisites

- [Nix](https://nixos.org/download.html) with flakes enabled, OR
- Ruby 3.2+ with Bundler

### Using Nix (Recommended)

```bash
# Build the site
nix run .#build

# Serve the site with live reload on http://localhost:4000
nix run .#serve

# Enter development shell
nix develop
```

### Using Ruby/Bundler

```bash
# Install dependencies
bundle install

# Build the site
bundle exec jekyll build

# Serve the site with live reload
bundle exec jekyll serve
```

The site will be available at `http://localhost:4000`.

## Deployment

The site automatically deploys to GitHub Pages when changes are pushed to the `main` branch. The GitHub Actions workflow handles the build and deployment process.

To enable GitHub Pages:
1. Go to your repository settings
2. Navigate to Pages
3. Set Source to "GitHub Actions"

## Project Structure

```
.
├── _config.yml              # Jekyll configuration
├── _layouts/
│   └── default.html         # Bootstrap-based layout
├── index.md                 # Main page content
├── Gemfile                  # Ruby dependencies
├── flake.nix                # Nix flake configuration
└── .github/
    ├── workflows/
    │   └── jekyll-gh-pages.yml  # GitHub Pages deployment
    └── copilot-instructions.md   # Copilot guidelines
```

## License

MIT