{ ... }:
{
  # Right sidebar - HDMI-A-1
  programs.waybar.settings.rightSidebar = {
    layer = "top";
    position = "top";
    output = "HDMI-A-2";
    modules-left = [ "niri/workspaces" "clock#2" "clock#3" ];
    modules-right = [ "wlr/taskbar" ];

    "niri/workspaces" = {
      "disable-scroll" = true;
      "all-outputs" = false;
      "format" = "{name}";
      "on-click" = "activate";  # ← add this to leftSidebar/mainBar too for consistency
    };

    "clock#2" = { "format" = " {:%H:%M}"; "tooltip" = false; };
    "clock#3" = { "format" = " {:%m-%d}"; "tooltip" = false; };
  };

  # Left sidebar - HDMI-A-2
  programs.waybar.settings.leftSidebar = {
    layer = "top";
    position = "top";
    output = "DP-4";
    modules-left = [ "niri/workspaces" "clock#2" "clock#3" ];
    modules-right = [ "wlr/taskbar" ];

    "niri/workspaces" = {
      "disable-scroll" = true;
      "all-outputs" = false;
      "format" = "{name}";
      "on-click" = "activate";  # ← add this to leftSidebar/mainBar too for consistency
    };

    "clock#2" = { "format" = " {:%H:%M}"; "tooltip" = false; };
    "clock#3" = { "format" = " {:%m-%d}"; "tooltip" = false; };
  };


  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    output = "DP-3";

    modules-left = [
      "clock"
      "idle_inhibitor"
      "niri/workspaces"
      "wlr/taskbar"
      "tray"
    ];

    modules-center = [
      "niri/window"  # Changed from "wlr/taskbar"
    ];

    modules-right = [
      "network"
      "custom/vpn"
      "group/hardware"
      "group/audio"
      "custom/power"
    ];


    # Drawer groups remain the same
    "group/hardware" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "not-power";
        transition-left-to-right = true;
      };
      modules = [ "cpu" "memory" "disk" ];
    };

    "custom/power" = {
      format = "⏻";
      tooltip = true;
      tooltip-format = "Power menu";
      on-click = "wlogout";
    };

    "group/audio" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "not-power";
        transition-left-to-right = false;
      };
      modules = [ "pulseaudio" "pulseaudio#microphone" ];
    };


    "custom/vpn" = {
      format = "󰖂 {}";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/vpn-status.sh";
      return-type = "json";
      interval = 10;
      on-click = "protonvpn-app";
      tooltip = true;
    };

    # Module configs (same as before, swapping niri/*)
    "clock" = {
      "format" = " {:%H:%M:%S}";
      "tooltip-format" = "<tt>{calendar}</tt>";
      "interval" = 1;
    };

    "niri/workspaces" = {
      "disable-scroll" = true;
      "all-outputs" = false;
      "format" = "{name}";
      "on-click" = "activate";  # ← add this to leftSidebar/mainBar too for consistency
    };

    "niri/window" = {
      "format" = "{title}";
      "max-length" = 50;
      "tooltip-format" = "{title}";
    };

    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = "󰾆";  # sun/inhibited state
        deactivated = "󰾅";  # moon/normal state
      };
    };

    "wlr/taskbar" = {
      format = "{icon}";
      icon-size = 20;          # pair with the bigger bar we just set
      icon-theme = "WhiteSur-dark";  # match your GTK theme
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      ignore-list = [ "Alacritty" ];  # apps you don't want pinned in the bar
    };

    "network" = {
      interval = 2;
      format = "{ifname}";
      format-wifi = " {bandwidthDownBytes}  {bandwidthUpBytes} ";
      format-ethernet = " {bandwidthDownBytes}  {bandwidthUpBytes} 󰈁";
      format-disconnected = "󰖪 Disconnected";
      tooltip-format-wifi = "{essid} ({signalStrength}%)";
      tooltip-format-ethernet = "{ifname} {ipaddr}/{cidr}";
    };

    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "󰝟 Muted";
      format-icons = {
        headphone = "󰋋";
        default = [ "󰕿" "󰖀" "󰕾" ];
      };
      on-click = "pamixer -t";
      on-click-right = "pavucontrol";
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = " {volume}%";
      format-source-muted = " 󰍭";
      on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    };

    "cpu" = {
      interval = 5;
      format = " {usage}%";
      tooltip = false;
    };

    "memory" = {
      interval = 5;
      format = " {percentage}%";
      tooltip = false;
    };

    "disk" = {
      interval = 30;
      format = " {percentage_used}%";
      path = "/";
      tooltip = false;
    };

    "tray" = {
      icon-size = 18;
      spacing = 8;
    };
  };
}
