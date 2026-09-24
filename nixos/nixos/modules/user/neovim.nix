{ pkgs, ... }:
let
  customNeovim = import ../nvim;
in {
  programs.neovim = customNeovim pkgs;
  home.sessionVariables.EDITOR = "nvim";
}
