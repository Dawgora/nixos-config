{ lib, specialArgs, ... }:
let
  systemType = specialArgs.systemType or "default";
  isMain = systemType == "main";

  diskModules =
    if isMain
    then [ "custom/disk-root" "custom/disk-ssd" "custom/disk-hdd" "custom/disk-win" ]
    else [ "custom/disk-root" ];
in
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

    "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "hardware";
            transition-left-to-right = true;
          };
          modules = [ "custom/cpu" "custom/memory" ] ++ diskModules;
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

    "custom/disk-ssd" = lib.mkIf isMain {
      interval = 60;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/disk-info.sh /mnt/old_ssd";
      tooltip = true;
    };

    "custom/disk-hdd" = lib.mkIf isMain {
      interval = 60;
      return-type = "json";
      exec = "/home/dawgora/flakes/nixos/nixos/scripts/disk-info.sh /mnt/hdd";
      tooltip = true;
    };

    "custom/disk-win" = lib.mkIf isMain {
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
