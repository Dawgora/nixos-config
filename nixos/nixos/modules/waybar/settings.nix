{ lib, config, specialArgs, ... }:
let
  systemType = specialArgs.systemType or "default";

  systemConfig = if systemType == "main" then [ ./home.nix ]
                 else if systemType == "work" then [ ./work-pc.nix ]
                 else [ ./home.nix ];   # fallback to home config

in
{
  imports = systemConfig;

  # Optional: assert loudly on mismatches
  assertions = [{
    assertion = systemType == "main" || systemType == "work";
    message = "waybar/settings.nix: unrecognized systemType '${systemType}'";
  }];
}
