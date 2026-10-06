{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    output = "HDMI-A-1";

    modules-left = [ "clock" "idle_inhibitor" "niri/workspaces" "wlr/taskbar" "tray" ];
    modules-center = [ "niri/window" ];
    modules-right = [ "network" "custom/vpn" "group/media" "group/hardware" "group/audio" "custom/power" ];

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
