{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  mono = config.stylix.fonts.monospace.name;
in
{
  programs.waybar.style = ''
    /* Palette from Stylix (modules/user/theme.nix) */
    @define-color bg      ${c.base00};
    @define-color surface ${c.base02};
    @define-color fg      ${c.base05};
    @define-color dim     ${c.base04};
    @define-color red     ${c.base08};
    @define-color orange  ${c.base09};
    @define-color yellow  ${c.base0A};
    @define-color green   ${c.base0B};
    @define-color cyan    ${c.base0C};
    @define-color blue    ${c.base0D};
    @define-color purple  ${c.base0E};

    * {
      font-family: "${mono}", "FontAwesome", monospace;
      font-size: 14px;
      min-height: 0;
    }

    window#waybar {
      background-color: rgba(0, 0, 0, 0);
      color: @fg;
      transition-property: background-color;
      transition-duration: 0.5s;
    }

    window#waybar.hidden { opacity: 0.1; }

    /* =============================================
       UNIVERSAL PILL — every module, every bar.
       ============================================= */
    #window, #niri-window,
    #workspaces, #niri-workspaces,
    #network, #language,
    #clock, #clock.2, #clock.3,
    #cpu, #memory, #disk, #battery,
    #pulseaudio, #pulseaudio.microphone,
    #idle_inhibitor, #tray, #taskbar, #mode, #custom-power, #media,
    #custom-disk-root, #custom-disk-ssd, #custom-disk-hdd, #custom-disk-win,
    #custom-memory, #custom-cpu,
    #custom-vpn {
      color: @fg;
      padding: 0px 12px;
      background-color: @bg;
      border-radius: 12px;
      margin: 4px 3px 0 3px;
    }

    #custom-cpu { color: @purple; }

    #custom-memory { color: @orange; }
    #custom-memory.used.warning { color: @yellow; }
    #custom-memory.used.critical { color: @red; }

    #custom-power {
      font-size: 16px;
    }

    #custom-media-prev, #custom-media-play, #custom-media-next {
      padding: 0 8px;
      border-radius: 12px;
    }

    #custom-media-prev:hover,
    #custom-media-next:hover,
    #custom-media-play:hover {
      background-color: alpha(@purple, 0.2);
    }

    #custom-disk-root { color: @blue; }    /* system */
    #custom-disk-ssd  { color: @green; }   /* oldssd */
    #custom-disk-hdd  { color: @yellow; }  /* hdd */
    #custom-disk-win  { color: @purple; }  /* windows */

    #custom-disk-root.offline,
    #custom-disk-ssd.offline,
    #custom-disk-hdd.offline,
    #custom-disk-win.offline { color: @dim; }

    /* =============================================
       ACCENT COLORS
       ============================================= */
    #clock, #clock.2, #clock.3 {
      color: @blue;
      font-weight: bold;
    }

    #network          { color: @red; }
    #pulseaudio       { color: @cyan; }
    #memory           { color: @orange; }
    #cpu              { color: @purple; }
    #disk             { color: @yellow; }
    #battery          { color: @green; }
    #battery.warning,
    #battery.critical { color: @red; }

    #idle_inhibitor.activated { color: @cyan; }

    #custom-vpn.connected    { color: @green; }
    #custom-vpn.disconnected { color: @red; }

    /* =============================================
       WORKSPACES
       ============================================= */
    #workspaces button, #niri-workspaces button {
      padding: 0 4px;
      margin: 0;
      color: @fg;
      background: transparent;
      border-radius: 8px;
      transition: all 0.3s;
    }
    #workspaces button.focused, #niri-workspaces button.focused {
      color: @blue;
    }
    #workspaces button:hover, #niri-workspaces button:hover {
      background: @surface;
    }

    /* =============================================
       TRAY
       ============================================= */
    #tray > .passive {
      -gtk-icon-effect: dim;
    }
    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: @red;
      border-radius: 8px;
    }

    /* =============================================
       ANIMATION + TOOLTIP
       ============================================= */
    @keyframes blink {
      to { background-color: alpha(@red, 0.3); color: @fg; }
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
      background: @surface;
    }

    /* active window's icon gets a highlighted underline */
    #taskbar button.active {
      box-shadow: inset 0 -3px @blue;
    }

    tooltip {
      border-radius: 12px;
      padding: 15px;
      background-color: @bg;
      color: @fg;
      border: 1px solid @blue;
    }
  '';
}
