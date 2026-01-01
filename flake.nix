{
  description = "A Jekyll-based single-page website with Bootstrap";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Ruby environment with Jekyll and theme
        rubyEnv = pkgs.ruby_3_3.withPackages
          (ps: with ps; [ jekyll jekyll-sitemap jekyll-theme-minimal webrick ]);

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ rubyEnv pkgs.git pkgs.imagemagick ];

          shellHook = ''
            echo "Jekyll website development environment"
            echo ""
            echo "Available commands:"
            echo "  nix run            - Start local development server"
            echo "  nix build          - Build static site"
            echo "  jekyll serve       - Start local development server"
            echo "  jekyll build       - Build static site"
            echo ""
            echo "Get started: nix run"
          '';
        };

        # Serve app for running the development server
        apps.serve = {
          type = "app";
          program = toString (pkgs.writeShellScript "serve" ''
            ${rubyEnv}/bin/jekyll serve
          '');
        };

        apps.default = self.outputs.apps.${system}.serve;

        # Default package builds the site
        packages.default = pkgs.stdenv.mkDerivation {
          name = "houseabsolute-site";
          src = ./.;

          buildInputs = [ rubyEnv pkgs.imagemagick ];

          buildPhase = ''
            echo "Building Jekyll site..."
            ${rubyEnv}/bin/jekyll build
          '';

          installPhase = ''
            mkdir -p $out
            cp -r _site/* $out/
          '';
        };
      });
}
