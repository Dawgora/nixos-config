{pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];

  xdg.configFile."alacritty/alacritty.toml".text = builtins.readFile ./theme.toml;
}
