{ ... }:
{
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      icon-theme: "WhiteSur-dark";
      font: "JetBrainsMono Nerd Font 20";
      display-drun: "󰀻 Apps";
      display-run: "󰘳 Run";
      display-window: "󰎔 Window";
      drun-display-format: "{name}";
      hover-select: true;
    }

    * {
      bg: #1a1a1a;
      bg-alt: #073642;
      fg: #ffffff;
      fg-dim: #586e75;
      accent: #268bd2;
      background-color: transparent;
      text-color: @fg;
    }

    window {
      width: 720px;
      border: 2px;
      border-color: #268bd2;
      border-radius: 14px;
      background-color: @bg;
      padding: 18px;
    }

    inputbar {
      spacing: 8px;
      padding: 12px;
      border-radius: 12px;
      background-color: #002b36;
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

    element selected {
      background-color: @accent;
      text-color: #ffffff;
    }

    element selected.normal {
      background-color: @accent;
      text-color: #ffffff;
    }

    element selected.active {
      background-color: @accent;
      text-color: #ffffff;
    }

    element normal.normal {
      background-color: @bg;
      text-color: @fg;
    }

    element alternate.normal {
      background-color: @bg;
      text-color: @fg;
    }

    element normal.odd {
      background-color: @bg;
      text-color: @fg;
    }

    element normal.even {
      background-color: @bg;
      text-color: @fg;
    }


    element urgent.normal {
      background-color: @bg;
      text-color: @fg;
    }

    element selected.urgent {
      background-color: #dc322f;
      text-color: #ffffff;
    }

    mode-switcher {
      spacing: 6px;
    }

    button {
      padding: 8px 14px;
      border-radius: 10px;
      background-color: @bg-alt;
      text-color: @fg;
    }

    element active.normal {
      background-color: @bg;
      text-color: @fg;
    }

    button selected {
      background-color: @accent;
      text-color: #ffffff;
    }
  '';
}
