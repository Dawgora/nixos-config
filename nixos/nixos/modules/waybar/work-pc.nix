{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    output = "eDP-1";

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
