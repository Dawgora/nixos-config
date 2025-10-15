{ ... }:
let
in
  {
    programs.waybar.settings.rightSidebar = {
      layer = "top";
      position = "top";
      output = "HDMI-A-1";

      modules-left = [
        "hyprland/workspaces"
        "niri/workspaces"
        "sway/workspaces"
      ];

      modules-center = [
        "clock#2"
        "clock#3"
      ];

      "clock#2" = {
        "format" = "{:%H:%M}";
        "tooltip" = false;
      };

      "clock#3" = {
        "format" = "{:%m-%d}";
        "tooltip" = false;
      };
    };

    programs.waybar.settings.leftSidebar = {
      layer = "top";
      position = "top";
      output = "HDMI-A-2";

      modules-left = [
        "hyprland/workspaces"
        "sway/workspaces"
        "niri/workspaces"
      ];

      modules-center = [
        "clock#2"
        "clock#3"
      ];

      "clock#2" = {
        "format" = "{:%H:%M}";
        "tooltip" = false;
      };

      "clock#3" = {
        "format" = "{:%m-%d}";
        "tooltip" = false;
      };
    };

    programs.waybar.settings.mainBar = {
      layer = "top";
      position = "top";
      output = "DP-2";

      modules-left = [
        "hyprland/workspaces"
        "sway/workspaces"
        "niri/workspaces"
      ]; 

      modules-center = [
        "clock#2"
        "clock#3"
      ];

      modules-right = [
        "pulseaudio"
        "memory"
        "cpu"
        "disk"
        "tray"
      ];

      "hyprland/workspaces" = {
        "disable-scroll" = true;
        "format" = "{name}";
      };

      "clock#2" = {
        "format" = "{:%H:%M:%S}";
        "tooltip" = false;
        "interval" = 1;
      };

      "clock#3" = {
        "format" = "{:%m-%d}";
        "tooltip" = false;
      };

      "pulseaudio" = {
        "format" = "{icon} {volume:2}%";
        "format-bluetooth" = "{icon}  {volume}%";
        "format-muted" = "MUTE";
        "format-icons" = {
          "headphones" = "";
          "default" = [
            ""
            ""
          ];
        };
        "scroll-step" = 5;
        "on-click" = "pamixer -t";
        "on-click-right" = "pavucontrol";
      }; 

      "memory" = {
        "interval" = 5;
        "format" = "Mem {}%";
      };

      "cpu" = {
        "interval" = 5;
        "format" = "CPU {usage:2}%";
      };

      "disk" = {
        "interval" = 5;
        "format" = "Disk {percentage_used:2}%";
        "path" = "/";
      };

      "tray" = {
        "icon-size" = 20;
      };
    };
  }
