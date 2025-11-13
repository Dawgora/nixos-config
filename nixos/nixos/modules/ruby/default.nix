{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
let
  elixir = beam.packages.erlang_27.elixir_1_18;
in

  mkShell {
  description = "Ruby 3.4 development environment with Bundler 2.7.2";

    buildInputs = [
      pkgs.ruby_3_4
    ];

    shellHook = ''
    export GEM_HOME=$PWD/.gem
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH

    # Install specific bundler version
    gem install bundler -v 2.7.2
    gem install rails

    ruby -v
    bundler -v
    rails -v
    '';
    }

