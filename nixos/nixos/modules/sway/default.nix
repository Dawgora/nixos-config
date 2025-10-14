{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let 
  mod = "Mod4";
in
  {
    wayland.windowManager.sway = {
      enable = true;

      config = {
        modifier = mod;
        keybindings = lib.attrsets.mergeAttrsList [
          (lib.attrsets.mergeAttrsList (map (num: let
            ws = toString num;
          in {
            "${mod}+${ws}" = "workspace ${ws}";
            "${mod}+Shift+${ws}" = "move container to workspace ${ws}";
          }) [1 2 3 4 5 6 7 8 9 0]))

          (lib.attrsets.concatMapAttrs (key: direction: {
            "${mod}+${key}" = "focus ${direction}";
            "${mod}+Shift+${key}" = "move ${direction}";
          }) {
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            Left = "left";
            Down = "down";
            Up = "up";
            Right = "right";
          })

          {
            "${mod}+Return" = "exec --no-startup-id alacritty";
            "${mod}+d" = "exec --no-startup-id rofi -show drun -show-icon";

            "${mod}+Shift+q" = "kill";

            "${mod}+a" = "focus parent";
            "${mod}+e" = "layout toggle split";
            "${mod}+f" = "fullscreen toggle";
            "${mod}+g" = "split h";
            "${mod}+s" = "layout stacking";
            "${mod}+v" = "split v";
            "${mod}+w" = "layout tabbed";
            "${mod}+space" = "focus mode_toggle";

            "${mod}+Shift+r" = "exec swaymsg reload";
            "--release Print" = "exec --no-startup-id hyprshot -m region -o ~/Documents/Screenshots";
          "${mod}+Ctrl+l" = "exec swaylock -f -c 000000";
          "${mod}+Ctrl+q" = "exit";
        }
      ];
      #default_border = "none";
      #bar = {};
      focus.followMouse = true;
      startup = [
        {command = "shikane";}
        #{command = "pkill kanshi; exec kanshi"; always = true;}
        #{command = "systemctl --user restart kanshi"; always = true;}
        {command = "--no-startup-id /home/dawgora/.local/bin/start.sh";}
        {command = "--no-startup-id /home/dawgora/.local/bin/sleep.sh";}
      ];
      bars = [];
      window.titlebar = false;
      input = {
        "*" = {
          xkb_layout = "lv";
        };
      };
      workspaceAutoBackAndForth = true;
    };
  };
}
