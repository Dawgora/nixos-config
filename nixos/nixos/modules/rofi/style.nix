{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  mono = config.stylix.fonts.monospace.name;
  icons = config.stylix.icons.dark;
in
{
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      icon-theme: "${icons}";
      font: "${mono} 20";
      display-drun: "󰀻 Apps";
      display-run: "󰘳 Run";
      display-window: "󰎔 Window";
      drun-display-format: "{name}";
      hover-select: true;
    }

    * {
      bg: ${c.base00};
      bg-alt: ${c.base01};
      surface: ${c.base02};
      fg: ${c.base05};
      fg-dim: ${c.base04};
      accent: ${c.base0D};
      urgent: ${c.base08};
      background-color: transparent;
      text-color: @fg;
    }

    window {
      width: 720px;
      border: 2px;
      border-color: @accent;
      border-radius: 14px;
      background-color: @bg;
      padding: 18px;
    }

    inputbar {
      spacing: 8px;
      padding: 12px;
      border-radius: 12px;
      background-color: @bg-alt;
      children: [ "prompt", "entry" ];
    }

    prompt {
      text-color: @accent;
    }

    entry {
      placeholder: "Search...";
      placeholder-color: @fg-dim;
      text-color: @fg;
      cursor-color: @accent;
    }

    mainbox {
      spacing: 12px;
      children: [ "inputbar", "listview" ];
    }

    listview {
      lines: 8;
      scrollbar: false;
      spacing: 6px;
    }

    element {
      padding: 10px;
      border-radius: 10px;
      spacing: 10px;
      background-color: @bg;
      text-color: @fg;
    }

    element-icon {
      size: 32px;
    }

    element-text {
      vertical-align: 0.5;
      text-color: inherit;
    }

    element normal.normal,
    element alternate.normal,
    element normal.urgent,
    element normal.active,
    element alternate.active {
      background-color: @bg;
      text-color: @fg;
    }

    element selected,
    element selected.normal,
    element selected.active {
      background-color: @accent;
      text-color: @bg;
    }

    element selected.urgent {
      background-color: @urgent;
      text-color: @bg;
    }

    mode-switcher {
      spacing: 6px;
    }

    button {
      padding: 8px 14px;
      border-radius: 10px;
      background-color: @surface;
      text-color: @fg;
    }

    button selected {
      background-color: @accent;
      text-color: @bg;
    }
  '';
}
