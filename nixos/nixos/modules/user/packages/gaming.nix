{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    gamescope
    heroic
    prismlauncher
    razergenie
    bazecor
    winbox
  ];
}
