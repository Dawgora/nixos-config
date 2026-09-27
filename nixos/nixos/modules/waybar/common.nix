{ ... }:
{
  programs.waybar.settings.mainBar = {
    "niri/workspaces" = {
      format = "{name}";
      on-click = "activate";
    };

    "niri/window" = {
      format = "{}";
      max-length = 40;
    };

    "tray" = {
      icon-size = 20;
      spacing = 8;
    };

    "custom/power" = {
      format = "⏻";
      tooltip-format = "Power menu";
      on-click = "wlogout";
    };

    "custom/vpn" = {
      format = "󰖂 {}";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/vpn-status.sh";
      return-type = "json";
      interval = 10;
      on-click = "protonvpn-app";
      tooltip = true;
    };

    "idle_inhibitor" = {
      format = "{icon}";
      format-icons = {
        activated = "󰾆";
        deactivated = "󰾅";
      };
    };

    "group/hardware" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "hardware";
        transition-left-to-right = true;
      };
      modules = [ "custom/cpu" "custom/memory" "custom/disk-root" "custom/disk-ssd" "custom/disk-hdd" "custom/disk-win" ];
    };

    "custom/cpu" = {
      interval = 5;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/cpu-info.sh";
    };

    "custom/memory" = {
      interval = 5;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/memory-info.sh";
    };

    "custom/disk-root" = {
      interval = 60;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/disk-info.sh /";
      tooltip = true;
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

    "group/audio" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "not-power";
        transition-left-to-right = false;
      };
      modules = [ "pulseaudio" "pulseaudio#microphone" ];
    };

    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "󰝟 Muted";
      format-icons = {
        headphone = "󰋋";
        default = [ "󰕿" "󰖀" "󰕾" ];
      };
      scroll-step = 5;
      on-click = "pamixer -t";
      on-click-right = "pavucontrol";
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = " {volume}%";
      format-source-muted = " 󰍭";
      on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    };
  };
}
