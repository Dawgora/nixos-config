{ pkgs, ... }:
{
  home.packages = with pkgs; [
    heroic
    prismlauncher
    rusty-path-of-building # PoB 1 + 2; downloads and updates PoB itself (~/.local/share/RustyPathOfBuilding{1,2})
    razergenie
    bazecor
    winbox
  ];
}
