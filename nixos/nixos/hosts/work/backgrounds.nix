# hosts/work/backgrounds.nix
{ pkgs, ... }:

{
  home.file.".local/share/backgrounds".source = ./backgrounds;

  home.packages = [
    (pkgs.writeShellScriptBin "set-backgrounds" ''
      # no -o: every connected screen; awww remembers it per screen name
      ${pkgs.awww}/bin/awww img \
        ~/.local/share/backgrounds/middle-screen.png --resize fit
    '')
  ];
}
