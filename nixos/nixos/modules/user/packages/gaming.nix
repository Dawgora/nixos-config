{ pkgs, ... }:
{
  home.packages = with pkgs; [
    heroic
    prismlauncher
    razergenie
    bazecor
    winbox
  ];
}
