{ ... }:
{
  programs.waybar.style = ''
    * {
      font-family: "JetBrainsMono Nerd Font", "FontAwesome", monospace;
      font-size: 14px;
      min-height: 0;
    }

    window#waybar {
      background-color: rgba(0, 0, 0, 0);
      color: #fdf6e3;
      transition-property: background-color;
      transition-duration: 0.5s;
    }

    window#waybar.hidden { opacity: 0.1; }

    /* Pill styling - apply to ALL modules across all bars */
    #window, #network, #language, #pulseaudio, #pulseaudio.microphone,
    #taskbar, #clock, #clock.2, #clock.3, #cpu, #memory, #disk,
    #battery, #idle_inhibitor, #tray, #workspaces {
      color: #fdf6e3;
      padding: 0px 10px 0px 10px;
      background-color: #1a1a1a;
      border-radius: 10px;
      margin: 4px 2px 0 2px;
    }

    /* Merge adjacent pills in group/hardware (cpu/memory/disk) */
    #cpu, #memory, #disk {
      margin-right: 0;
      margin-left: 0;
      border-radius: 0;
    }

    /* Merge taskbar → tray chain */
    #workspaces, #taskbar, #pulseaudio {
      margin-left: 0;
      border-top-left-radius: 0;
      border-bottom-left-radius: 0;
    }

    #network, #clock, #clock.2, #clock.3 {
      margin-right: 0;
      border-top-right-radius: 0;
      border-bottom-right-radius: 0;
    }

    /* Accent colors per module */
    #clock, #clock.2, #clock.3 {
      color: #268bd2;
      font-weight: bold;
    }

    #pulseaudio { color: #2aa198; }
    #memory { color: #cb4b16; }
    #cpu { color: #6c71c4; }
    #battery { color: #859900; }
    #disk { color: #b58900; }
    #network { color: #d33682; }
    #idle_inhibitor.activated { color: #2aa198; }
    #battery.warning, #battery.critical { color: #dc322f; }

    #workspaces button {
      padding: 0 4px;
      color: #fdf6e3;
      transition: all 0.3s;
    }
    #workspaces button.focused { color: #268bd2; }
    #workspaces button:hover { background: #002b36; }

    #taskbar button {
      box-shadow: inset 0 -3px transparent;
      padding: 4px;
      transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
    }
    #taskbar button.active { box-shadow: inset 0 -3px #268bd2; }

    @keyframes blink {
      to { background-color: rgba(220, 50, 47, 0.3); color: #fdf6e3; }
    }

    tooltip {
      border-radius: 10px;
      padding: 15px;
      background-color: #1a1a1a;
      color: #fdf6e3;
    }

    #custom-vpn {
      color: #fdf6e3;
      padding: 0px 10px 0px 10px;
      background-color: #1a1a1a;
      border-radius: 10px;
      margin: 4px 2px 0 2px;
    }

    #custom-vpn.connected {
      color: #859900;  /* solarized green — VPN on */
    }

    #custom-vpn.disconnected {
      color: #dc322f;  /* solarized red — VPN off */
    }

    #niri-window {
      padding: 0px 10px 0px 10px;
      background-color: #1a1a1a;
      border-radius: 10px;
      margin: 4px 2px 0 2px;
    }

    /* Truncate long titles gracefully */
    #niri-window > label {
      padding: 0 5px;
    }
  '';
}
