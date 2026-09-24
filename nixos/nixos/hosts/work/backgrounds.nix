# hosts/work/backgrounds.nix
{ pkgs, ... }:

{
  home.file.".local/share/backgrounds".source = ./backgrounds;

  home.packages = [
    (pkgs.writeShellScriptBin "set-backgrounds" ''
      ${pkgs.awww}/bin/awww img -o eDP-1 \
        ~/.local/share/backgrounds/middle-screen.png --resize fit
    '')
  ];
}
