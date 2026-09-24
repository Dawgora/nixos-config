{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];

  # Import the theme
  imports = [ ./style.nix ];
}
