# modules/user/swaylock.nix
{ config, lib, pkgs, ... }:

let
  cfg = config.dawgora.swaylock;

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
        # clock (matches your current look)
        clock = true;
        timestr = "%H:%M:%S";
        datestr = "%a, %d/%m/%Y";
        font = "JetBrainsMono Nerd Font";
        font-size = 28;
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 8;

        # effects
        effect-blur = "10x3";
        fade-in = "0.2";

        # catppuccin mocha — your exact paste
        color = "1e1e2e";
        bs-hl-color = "f5e0dc";
        caps-lock-bs-hl-color = "f5e0dc";
        caps-lock-key-hl-color = "a6e3a1";
        inside-color = "1e1e2e";
        inside-clear-color = "1e1e2e";
        inside-caps-lock-color = "1e1e2e";
        inside-ver-color = "1e1e2e";
        inside-wrong-color = "1e1e2e";
        key-hl-color = "a6e3a1";
        layout-bg-color = "00000000";
        layout-border-color = "00000000";
        layout-text-color = "cdd6f4";
        line-color = "00000000";
        line-clear-color = "00000000";
        line-caps-lock-color = "00000000";
        line-ver-color = "00000000";
        line-wrong-color = "00000000";
        ring-color = "313244";
        ring-clear-color = "f5e0dc";
        ring-caps-lock-color = "fab387";
        ring-ver-color = "89b4fa";
        ring-wrong-color = "eba0ac";
        separator-color = "00000000";
        text-color = "cdd6f4";
        text-clear-color = "f5e0dc";
        text-caps-lock-color = "fab387";
        text-ver-color = "89b4fa";
        text-wrong-color = "eba0ac";
      };
    };

    home.packages = [ lockScreen ];
  };
}
