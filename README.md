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

- [Nix](https://nixos.org/download.html) with flakes enabled

### Commands

```bash
# Start development server with live reload on http://localhost:4000
nix run

# Build the static site to ./result
nix build

# Enter development shell (optional)
nix develop
```

The site will be available at `http://localhost:4000` when running the development server.

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
├── flake.nix                # Nix flake configuration
└── .github/
    ├── workflows/
    │   └── jekyll-gh-pages.yml  # GitHub Pages deployment
    └── copilot-instructions.md   # Copilot guidelines
```

## License

MIT