{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    output = "DP-3";

    modules-left = [ "clock" "idle_inhibitor" "niri/workspaces" "wlr/taskbar" "tray" ];
    modules-center = [ "niri/window" ];
    modules-right = [ "network" "custom/vpn" "group/media" "group/hardware" "group/audio" "custom/power" ];

    "group/media" = {
      orientation = "inherit";
      modules = [ "custom/media-prev" "custom/media-play" "custom/media-next" ];
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
      on-click-right = "tidal-hifi";
    };

    "custom/media-next" = {
      format = "󰒭";
      tooltip = false;
      on-click = "playerctl next -p chromium";
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

    "network" = {
      interval = 2;
      interface = "enp8s0";
      format = "{ifname}";
      format-wifi = " {bandwidthDownBytes}  {bandwidthUpBytes} ";
      format-ethernet = " {bandwidthDownBytes}  {bandwidthUpBytes} 󰈁";
      format-disconnected = "󰖪 Disconnected";
      tooltip-format-wifi = "{essid} ({signalStrength}%)";
      tooltip-format-ethernet = "{ifname} {ipaddr}/{cidr}";
    };

    "wlr/taskbar" = {
      format = "{icon}";
      icon-size = 20;
      icon-theme = "WhiteSur-dark";
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      ignore-list = [ "Alacritty" ];
    };
  };
}
