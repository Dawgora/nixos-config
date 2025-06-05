{
  config,
  lib,
  pkgs,
  ...
}: let
in {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false; # disable it,autostart it in hyprland conf
      target = "graphical-session.target";
    };
    style = ''
          * {
      font-family: "Lekton Nerd Font";
      font-size: 16;
      border-radius: 0px;
      transition-property: background-color;
      transition-duration: 0.5s;
      }
      @keyframes blink_red {
      to {
      background-color: #CDB3C1;
      color: rgb(26, 24, 38);
      }
      }
      .warning, .critical, .urgent {
      animation-name: blink_red;
      animation-duration: 1s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
      }
      window#waybar {
      background-color: transparent;
      }
      window > box {
      background-color: transparent;
      border-bottom: 1px solid black;
      }
      #workspaces {
      padding-left: 0px;
      padding-right: 4px;
      }
      #workspaces button {
      padding-top: 4px;
      padding-bottom: 3px;
      padding-left: 6px;
      padding-right: 6px;
      color:#ffffff; /* pallete base00 */
    }
    
      #workspaces button.active {
      background: radial-gradient( 40px circle at top left, rgba(255, 255, 255, 0.7), rgba(255,255,255, 0) ), transparent;
      border: 1px solid black;
      color: #ffffff; /* pallete base00 */
      padding-top: 3px;
      padding-bottom: 2px;
      padding-left: 5px;
      padding-right: 5px;
      }
      #workspaces button.urgent {
      color: rgb(26, 24, 38);
      }
      #workspaces button:hover {
      background-color:#000000; /* palette base0B */
      color: #00ff00; /* palette Base0A*/
      }
      tooltip {
      background: white;
      border: 1px solid black;
      border-radius: 0px;
      }
      tooltip label {
      color: #000000; /* base00 */
      }
      #custom-rofi {
      font-size: 20px;
      padding-left: 8px;
      padding-right: 8px;
      color: #000000; /* base00 */
      }
      #mode, #clock, #backlight, #wireplumber, #network, #battery, #custom-powermenu {
      padding-left: 5px;
      padding-right: 8px;
      }
      #mpris {
      padding-left: 5px;
      padding-right: 0px;
      }
      #memory {
      color: #000000; /* base0B */
      }
      #cpu {
      color: #00ff00; /* base0C */
      }
      #clock {
      color: black;
      font-weight: 600;
      }
      #window {
        color: white;
        font-weight: 600;
        text-shadow:
         -1px -1px 0 black,
          1px -1px 0 black,
         -1px  1px 0 black,
          1px  1px 0 black;
      }
      #custom-wall {
      color: #B38DAC;
      }
      #temperature {
      color: #00ff00; /* base09 */
      }
      #backlight {
      color: #ff0fff; /* base08 */
      }
      #mpris {
      color: black;
      }
      #wireplumber {
      color: black;
      }
      #network {
      color: black;
      }

      #network.disconnected {
      color: #CCCCCC;
      }
      #battery.charging, #battery.full, #battery.discharging {
      color: black;
      }
      #battery.critical:not(.charging) {
      color: #D6DCE7;
      }
      #custom-powermenu {
      color: white;
      font-size: 20px;
      padding-left: 8px;
      padding-right: 8px;
      text-shadow:
        1px 1px 0 black,
        -1px -1px 0 black,
        -1px  1px 0 black,
        1px  -1px 0 black;
      }
      #tray {
      padding-right: 8;
      padding-left: 2;
      }
      #tray menu {
      background: white;
      border: 1px solid black;
      border-radius: 0px;
      color: black;
      }
    '';
    settings =
    [{
	layer = "top";
	position = "top";

	modules-left = [
		"sway/workspaces"
		"custom/right-arrow-dark"
	]; 

	modules-center = [
		"custom/left-arrow-dark"
		"clock#1"
		"custom/left-arrow-light"
		"custom/left-arrow-dark"
		"clock#2"
		"custom/right-arrow-dark"
		"custom/right-arrow-light"
		"clock#3"
		"custom/right-arrow-dark"
      ];

	modules-right = [
		"custom/left-arrow-dark"
		"pulseaudio"
		"custom/left-arrow-light"
		"custom/left-arrow-dark"
		"memory"
		"custom/left-arrow-light"
		"custom/left-arrow-dark"
		"cpu"
		"custom/left-arrow-light"
		"custom/left-arrow-dark"
		"custom/left-arrow-light"
		"custom/left-arrow-dark"
		"disk"
		"custom/left-arrow-light"
		"custom/left-arrow-dark"
		"tray"
	];

	"custom/left-arrow-dark" = {
		format = "";
		tooltip = false;
      };

	"custom/left-arrow-light" = {
		format = "";
		tooltip = false;
	};
    
    "custom/right-arrow-dark" = {
		format = "";
		tooltip = false;
	};
    
    "custom/right-arrow-light" = {
		format = "";
		tooltip = false;
	};

	"sway/workspaces" = {
		"disable-scroll" = true;
		"format" = "{name}";
	};

	"clock#1" = {
		"format" = "{:%a}";
		"tooltip" = false;
	};
    
    "clock#2" = {
		"format" = "{:%H:%M}";
		"tooltip" = false;
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
    
  }];
  };
}
