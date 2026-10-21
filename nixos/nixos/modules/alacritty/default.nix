{ pkgs, config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
  mono = config.stylix.fonts.monospace.name;
  size = config.stylix.fonts.sizes.terminal;
in
{
  home.packages = with pkgs; [
    alacritty
  ];

  # theme.toml holds window/cursor/mouse settings; fonts and colours come from Stylix
  xdg.configFile."alacritty/alacritty.toml".text = builtins.readFile ./theme.toml + ''

    [font]
    normal      = { family = "${mono}", style = "Regular" }
    bold        = { family = "${mono}", style = "Bold" }
    italic      = { family = "${mono}", style = "Italic" }
    bold_italic = { family = "${mono}", style = "Bold Italic" }
    size = ${toString size}

    [colors.primary]
    background = "${c.base00}"
    foreground = "${c.base05}"
    dim_foreground = "${c.base04}"
    bright_foreground = "${c.base07}"

    [colors.cursor]
    cursor = "${c.base05}"
    text = "${c.base00}"

    [colors.selection]
    background = "${c.base02}"
    text = "CellForeground"

    [colors.normal]
    black = "${c.base01}"
    red = "${c.base08}"
    green = "${c.base0B}"
    yellow = "${c.base0A}"
    blue = "${c.base0D}"
    magenta = "${c.base0E}"
    cyan = "${c.base0C}"
    white = "${c.base05}"

    [colors.bright]
    black = "${c.base03}"
    red = "${c.base08}"
    green = "${c.base0B}"
    yellow = "${c.base0A}"
    blue = "${c.base0D}"
    magenta = "${c.base0E}"
    cyan = "${c.base0C}"
    white = "${c.base07}"

    [[colors.indexed_colors]]
    index = 16
    color = "${c.base09}"

    [[colors.indexed_colors]]
    index = 17
    color = "${c.base0F}"
  '';
}
