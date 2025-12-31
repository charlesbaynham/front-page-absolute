{
  description = "Jekyll wedding website development environment";

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
          buildInputs = [ rubyEnv pkgs.git ];

          shellHook = ''
            echo "Jekyll website development environment"
            echo ""
            echo "Available commands:"
            echo "  nix run .#serve    - Start local development server"
            echo "  nix run .#build    - Build static site"
            echo "  jekyll serve       - Start local development server"
            echo "  jekyll build       - Build static site"
            echo ""
            echo "Get started: nix run .#serve"
          '';
        };

        # Serve app for running the development server
        apps.serve = {
          type = "app";
          program = toString (pkgs.writeShellScript "serve" ''
            ${rubyEnv}/bin/jekyll serve
          '');
        };

        # Build app for building the site
        apps.build = {
          type = "app";
          program = toString (pkgs.writeShellScript "build" ''
            ${rubyEnv}/bin/jekyll build
          '');
        };

        apps.default = self.outputs.apps.${system}.serve;

        # Default package builds the site
        packages.default = pkgs.stdenv.mkDerivation {
          name = "jekyll-site";
          src = ./.;

          buildInputs = [ rubyEnv ];

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
