# modules/user/swaylock.nix
{ config, lib, pkgs, ... }:

let
  cfg = config.dawgora.swaylock;
  c = config.lib.stylix.colors; # hex without '#', which is what swaylock wants

  imageArgs = builtins.concatStringsSep " "
    (map (img: "-i ${lib.escapeShellArg img}") cfg.images);

  lockScreen = pkgs.writeShellScriptBin "lock-screen" ''
    exec ${pkgs.swaylock-effects}/bin/swaylock ${imageArgs} -f
  '';
in
{
  options.dawgora.swaylock.images = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Lock background images as output:/absolute/path pairs.";
  };

  config = {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;

      settings = {
        # clock
        clock = true;
        timestr = "%H:%M:%S";
        datestr = "%a, %d/%m/%Y";
        font = config.stylix.fonts.monospace.name;
        font-size = 28;
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 8;

        # effects
        effect-blur = "10x3";
        fade-in = "0.2";

        # palette from Stylix (modules/user/theme.nix)
        color = c.base00;
        inside-color = c.base00;
        inside-clear-color = c.base00;
        inside-caps-lock-color = c.base00;
        inside-ver-color = c.base00;
        inside-wrong-color = c.base00;

        ring-color = c.base02;
        ring-clear-color = c.base09;
        ring-caps-lock-color = c.base0A;
        ring-ver-color = c.base0D;
        ring-wrong-color = c.base08;

        key-hl-color = c.base0B;
        bs-hl-color = c.base09;
        caps-lock-key-hl-color = c.base0B;
        caps-lock-bs-hl-color = c.base09;

        text-color = c.base05;
        text-clear-color = c.base09;
        text-caps-lock-color = c.base0A;
        text-ver-color = c.base0D;
        text-wrong-color = c.base08;
        layout-text-color = c.base05;

        # no lines, separators or layout box
        line-color = "00000000";
        line-clear-color = "00000000";
        line-caps-lock-color = "00000000";
        line-ver-color = "00000000";
        line-wrong-color = "00000000";
        separator-color = "00000000";
        layout-bg-color = "00000000";
        layout-border-color = "00000000";
      };
    };

    home.packages = [ lockScreen ];
  };
}
