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
        
        # Ruby environment with Jekyll
        rubyEnv = pkgs.ruby_3_2.withPackages (ps: with ps; [
          jekyll
        ]);
        
        # Build the site
        site = pkgs.stdenv.mkDerivation {
          name = "front-page-absolute";
          src = ./.;
          
          buildInputs = [ rubyEnv pkgs.bundler ];
          
          buildPhase = ''
            export HOME=$TMPDIR
            export GEM_HOME=$TMPDIR/.gem
            export PATH=$GEM_HOME/bin:$PATH
            
            # Install dependencies
            bundle config set --local path 'vendor/bundle'
            bundle install
            
            # Build the site
            bundle exec jekyll build
          '';
          
          installPhase = ''
            mkdir -p $out
            cp -r _site/* $out/
          '';
        };
        
      in
      {
        packages = {
          default = site;
          website = site;
        };
        
        apps = {
          # Serve the site in development mode
          serve = {
            type = "app";
            program = toString (pkgs.writeShellScript "serve" ''
              export HOME=$TMPDIR
              export GEM_HOME=$HOME/.gem
              export PATH=$GEM_HOME/bin:$PATH
              
              cd ${./.}
              
              # Install dependencies if needed
              if [ ! -d "vendor/bundle" ]; then
                ${pkgs.bundler}/bin/bundle config set --local path 'vendor/bundle'
                ${pkgs.bundler}/bin/bundle install
              fi
              
              # Serve the site
              ${pkgs.bundler}/bin/bundle exec ${rubyEnv}/bin/jekyll serve --watch --livereload --host 0.0.0.0
            '');
          };
          
          # Build the site
          build = {
            type = "app";
            program = toString (pkgs.writeShellScript "build" ''
              export HOME=$TMPDIR
              export GEM_HOME=$HOME/.gem
              export PATH=$GEM_HOME/bin:$PATH
              
              cd ${./.}
              
              # Install dependencies if needed
              if [ ! -d "vendor/bundle" ]; then
                ${pkgs.bundler}/bin/bundle config set --local path 'vendor/bundle'
                ${pkgs.bundler}/bin/bundle install
              fi
              
              # Build the site
              ${pkgs.bundler}/bin/bundle exec ${rubyEnv}/bin/jekyll build
              
              echo "Site built successfully in _site/"
            '');
          };
        };
        
        devShells.default = pkgs.mkShell {
          buildInputs = [
            rubyEnv
            pkgs.bundler
          ];
          
          shellHook = ''
            export GEM_HOME=$PWD/.gem
            export PATH=$GEM_HOME/bin:$PATH
            
            echo "Jekyll development environment"
            echo "Commands:"
            echo "  nix run .#build  - Build the site"
            echo "  nix run .#serve  - Serve the site with live reload"
          '';
        };
      }
    );
}
