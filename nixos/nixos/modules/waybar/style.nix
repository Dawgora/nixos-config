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

    /* =============================================
       UNIVERSAL PILL — every module, every bar.
       No merge rules; each module is a standalone
       rounded pill with a small gap between them.
       ============================================= */
    #window, #niri-window,
    #workspaces, #niri-workspaces,
    #network, #language,
    #clock, #clock.2, #clock.3,
    #cpu, #memory, #disk, #battery,
    #pulseaudio, #pulseaudio.microphone,
    #idle_inhibitor, #tray, #taskbar, #mode, #custom-power,
    #custom-vpn {
      color: #fdf6e3;
      padding: 0px 12px;
      background-color: #1a1a1a;
      border-radius: 12px;
      margin: 4px 3px 0 3px;
    }

    #custom-power {
      font-size: 16px;  /* slightly smaller than the 20px global, fits the bar height */
    }

    /* =============================================
       ACCENT COLORS
       ============================================= */
    #clock, #clock.2, #clock.3 {
      color: #268bd2;
      font-weight: bold;
    }

    #network          { color: #d33682; }
    #pulseaudio       { color: #2aa198; }
    #memory           { color: #cb4b16; }
    #cpu              { color: #6c71c4; }
    #disk             { color: #b58900; }
    #battery          { color: #859900; }
    #battery.warning  { color: #b58900; }
    #battery.critical { color: #dc322f; }

    #idle_inhibitor.activated { color: #2aa198; }

    #battery.warning, #battery.critical { color: #dc322f; }

    #custom-vpn.connected    { color: #859900; }  /* green — VPN on  */
    #custom-vpn.disconnected { color: #dc322f; }  /* red — VPN off */

    /* =============================================
       WORKSPACES
       ============================================= */
    #workspaces button, #niri-workspaces button {
      padding: 0 4px;
      margin: 0;
      color: #fdf6e3;
      background: transparent;
      border-radius: 8px;
      transition: all 0.3s;
    }
    #workspaces button.focused, #niri-workspaces button.focused {
      color: #268bd2;
    }
    #workspaces button:hover, #niri-workspaces button:hover {
      background: #002b36;
    }

    /* =============================================
       TRAY
       ============================================= */
    #tray > .passive {
      -gtk-icon-effect: dim;
    }
    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: #dc322f;
      border-radius: 8px;
    }

    /* =============================================
       ANIMATION + TOOLTIP
       ============================================= */
    @keyframes blink {
      to { background-color: rgba(220, 50, 47, 0.3); color: #fdf6e3; }
    }

    #battery.critical:not(.charging) {
      animation: blink 1s linear infinite alternate;
    }

    #taskbar {
      padding: 0px 8px;
    }

    #taskbar button {
      padding: 2px 4px;
      margin: 2px 0;
      border-radius: 8px;
      transition: all 0.3s;
    }

    #taskbar button:hover {
      background: #002b36;
    }

    /* active window's icon gets a highlighted underline */
    #taskbar button.active {
      box-shadow: inset 0 -3px #268bd2;
    }

    tooltip {
      border-radius: 12px;
      padding: 15px;
      background-color: #1a1a1a;
      color: #fdf6e3;
      border: 1px solid #268bd2;
    }
  '';
}
