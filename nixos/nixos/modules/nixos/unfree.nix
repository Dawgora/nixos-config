{ config, lib, ... }:
{
  options.dawgora.unfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Names (lib.getName) of the unfree packages allowed on this host.";
  };

  config = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) config.dawgora.unfreePackages;

    # Used on both hosts
    dawgora.unfreePackages = [
      "steam"
      "steam-unwrapped"
      "discord"
      "discord-unwrapped"
      "obsidian"
      "winbox"
      "castlabs-electron" # tidal-hifi
      "zsh-autoenv"
    ];
  };
}
