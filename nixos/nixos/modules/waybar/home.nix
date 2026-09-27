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
      "group/media"
      "group/hardware"
      "group/audio"
      "custom/power"
    ];

    # Drawer groups remain the same
    "group/hardware" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "hardware";
        transition-left-to-right = true;
      };
      modules = [ "custom/cpu" "custom/memory" "custom/disk-root" "custom/disk-ssd" "custom/disk-hdd" "custom/disk-win" ];
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

    "group/media" = {
      orientation = "inherit";
      modules = ["custom/media-prev" "custom/media-play" "custom/media-next"];
    };


    "custom/media-prev" = {
      format = "󰒮";
      tooltip = false;
      on-click = "playerctl previous -p chromium";
    };

    "custom/media-play" = {
      format = " {} ";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/media-status.sh";
      return-type = "json";
      interval = 2;
      on-click = "playerctl play-pause -p chromium 2>/dev/null || tidal-hifi";
      on-click-right = "tidal-hifi";  # Right-click launches Tidal if idle
    };

    "custom/media-next" = {
      format = "󰒭";
      tooltip = false;
      on-click = "playerctl next -p chromium";
    };

    "custom/vpn" = {
      format = "󰖂 {}";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/vpn-status.sh";
      return-type = "json";
      interval = 10;
      on-click = "protonvpn-app";
      tooltip = true;
    };

    "clock" = {
      format = " {:%H:%M:%S}";
      tooltip-format = "<tt><big>{calendar}</big></tt>";
      interval = 1;
      locale = "en_GB.UTF-8";
      calendar = {
        mode = "month";
        mode-mon-col = true;
        weeks-pos = "right";
        on-scroll = 1;
        format = {
          today = "<span weight='bold' foreground='#268bd2'>{}</span>";
        };
      };
    };

    "niri/workspaces" = {
      "disable-scroll" = true;
      "all-outputs" = false;
      "format" = "{name}";
      "on-click" = "activate";
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
      interface = "enp8s0";   # ← pin it to your wired NIC
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

    "custom/cpu" = {
      interval = 5;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/cpu-info.sh";
      tooltip = true;
    };

    "custom/memory" = {
      interval = 5;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/memory-info.sh";
      tooltip = true;
    };

    "custom/disk-root" = {
      interval = 60;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/disk-info.sh /";
      tooltip = true;  # Info in tooltip already
    };

    "custom/disk-ssd" = {
      interval = 60;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/disk-info.sh /mnt/old_ssd";
      tooltip = true;
    };

    "custom/disk-hdd" = {
      interval = 60;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/disk-info.sh /mnt/hdd";
      tooltip = true;
    };

    "custom/disk-win" = {
      interval = 60;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/disk-info.sh /mnt/windows_game_dir";
      tooltip = true;
    };

    "tray" = {
      icon-size = 18;
      spacing = 8;
    };
  };
}
