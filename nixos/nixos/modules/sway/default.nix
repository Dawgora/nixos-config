{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let 
in
  {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
      };
    };


#        settings = {
#          "$terminal" = "alacritty";
#          "$fileManager" = "thunar";
#          "$menu" = "wofi --show drun";
#          "$mod" = "SUPER";
#
#          monitor = [
#            "HDMI-A-2, 1920x1080@60, 0x0, 1, transform, 1"
#            "HDMI-A-1, 1920x1080@60, 3640x0, 1, transform, 1"
#            "DP-2, 2560x1440@120, 1080x0, 1"
#          ];
#
#          workspace = [
#            "1,monitor:HDMI-A-2"
#            "2,monitor:DP-2"
#            "3,monitor:HDMI-A-1"
#          ];
#        };
  }
