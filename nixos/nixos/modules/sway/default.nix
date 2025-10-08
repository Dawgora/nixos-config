{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let 
  start-script = ./start.sh;
  sleep-script = ./sleep.sh;
in
  {
    wayland.windowManager.sway = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";

        startup = [];
      };
    };
  }
