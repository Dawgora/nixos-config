# Used by shells/elixir.nix (dev shell) and modules/nvim/default.nix (elixir-ls).
pkgs: rec {
  beamPackages = pkgs.beam.packages.erlang_27;
  elixir = beamPackages.elixir_1_18;
  elixir-ls = beamPackages.elixir-ls.override { inherit elixir; };
}
