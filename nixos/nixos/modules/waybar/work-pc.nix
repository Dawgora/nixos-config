{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    height = 40;
    output = "eDP-1";

    modules-left = [
      "niri/workspaces"
      "niri/window"
    ];

    modules-center = [
      "clock"
    ];

    modules-right = [
      "group/hardware"
      "group/audio"
      "battery"
      "backlight"
      "bluetooth"
      "network"
      "tray"
      "custom/power"
    ];

    "niri/workspaces" = {
      "format" = "{name}";
      "on-click" = "activate";
    };

    "niri/window" = {
      "format" = "{}";
      "max-length" = 40;
    };

    "clock" = {
      "format" = "{:%H:%M  %m-%d}";
      "tooltip" = false;
      "interval" = 60;
    };

    "group/hardware" = {
      orientation = "inherit";
      drawer = {
        "transition-duration" = 300;
        "transition-left-to-right" = false;
      };
      modules = [
        "cpu"
        "memory"
        "disk"
      ];
    };

    "cpu" = {
      "interval" = 5;
      "format" = "CPU {usage:2}%";
    };

    "memory" = {
      "interval" = 5;
      "format" = "Mem {}%";
    };

    "disk" = {
      "interval" = 30;
      "format" = "Disk {percentage_used:2}%";
      "path" = "/";
    };

    "group/audio" = {
      orientation = "inherit";
      drawer = {
        "transition-duration" = 300;
        "transition-left-to-right" = false;
      };
      modules = [
        "pulseaudio"
      ];
    };

    "pulseaudio" = {
      "format" = "{icon} {volume:2}%";
      "format-muted" = "MUTE";
      "format-icons" = {
        "headphones" = "";
        "default" = [ "" "" ];
      };
      "scroll-step" = 5;
      "on-click" = "pamixer -t";
      "on-click-right" = "pavucontrol";
    };

    # ---- laptop modules ----

    "battery" = {
      "states" = {
        "good" = 80;
        "warning" = 30;
        "critical" = 15;
      };
      "format" = "{icon} {capacity:2}%";
      "format-charging" = " {capacity:2}%";
      "format-plugged" = " {capacity:2}%";
      "format-icons" = [ "" "" "" "" "" ];
      "interval" = 30;
      "tooltip" = false;
    };

    "backlight" = {
      "device" = "intel_backlight";
      "format" = "{icon} {percent:2}%";
      "format-icons" = [ "" "" "" "" "" "" "" "" ];
      "on-scroll-up" = "brightnessctl set +5%";
      "on-scroll-down" = "brightnessctl set 5%-";
    };

    "bluetooth" = {
      "format" = " {status}";
      "format-connected" = " {num_connections}";
      "tooltip-format" = "{device_alias}";
      "on-click" = "overskride";
    };

    "network" = {
      "format-wifi" = " {essid}";
      "format-ethernet" = " Wired";
      "format-disconnected" = "⚠ Offline";
      "tooltip" = false;
    };

    "tray" = {
      "icon-size" = 20;
      "spacing" = 8;
    };

    "custom/power" = {
      "format" = "";
      "tooltip" = false;
      "on-click" = "wlogout";
    };
  };
}
