{
  description = "Ruby 3.2 development environment with Bundler 2.5.17";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/63158b9cbb6ec93d26255871c447b0f01da81619";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.ruby_3_4
          ];

          shellHook = ''
            export GEM_HOME=$PWD/.gem
            export GEM_PATH=$GEM_HOME
            export PATH=$GEM_HOME/bin:$PATH

            # Install specific bundler version
            gem install bundler -v 2.7.2

            ruby -v
            bundler -v
          '';
        };
      };
    };
}
