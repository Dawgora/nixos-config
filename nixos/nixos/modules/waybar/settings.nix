{ lib, config, specialArgs, ... }:
let
  systemType = specialArgs.systemType or "default";
  systemConfig = if systemType == "main" then [ ./home.nix ]
                 else if systemType == "work" then [ ./work-pc.nix ]
                 else [ ./home.nix ];

in
{
  imports = systemConfig ++ [ ../rofi ./common.nix ];

  assertions = [{
    assertion = systemType == "main" || systemType == "work";
    message = "waybar/settings.nix: unrecognized systemType '${systemType}'";
  }];
}
