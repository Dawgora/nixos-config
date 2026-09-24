# hosts/main/backgrounds.nix
{ pkgs, ... }:

{
  home.file.".local/share/backgrounds".source = ./backgrounds;

  home.packages = [
    (pkgs.writeShellScriptBin "set-backgrounds" ''
      ${pkgs.awww}/bin/awww img -o HDMI-A-2 \
        ~/.local/share/backgrounds/side-screens.png --resize fit
      ${pkgs.awww}/bin/awww img -o DP-3 \
        ~/.local/share/backgrounds/middle-screen-2.jpg --resize fit
      ${pkgs.awww}/bin/awww img -o DP-4 \
        ~/.local/share/backgrounds/side-screens.png --resize fit
    '')
  ];
}
