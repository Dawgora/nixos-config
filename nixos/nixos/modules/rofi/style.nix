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
      fg: #fdf6e3;
      fg-dim: #93a1a1;
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
      background-color: @bg-alt;
      children: [ "prompt", "entry" ];
    }

    prompt {
      text-color: @accent;
    }

    entry {
      placeholder: "Search...";
      placeholder-color: @fg-dim;
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
    }

    element-icon {
      size: 32px;
    }

    element-text {
      vertical-align: 0.5;
    }

    element selected.normal {
      background-color: @accent;
      text-color: #fdf6e3;
    }

    element selected.active {
      background-color: @accent;
    }

    mode-switcher {
      spacing: 6px;
    }

    button {
      padding: 8px 14px;
      border-radius: 10px;
      background-color: @bg-alt;
    }

    button selected {
      background-color: @accent;
    }
  '';
}
