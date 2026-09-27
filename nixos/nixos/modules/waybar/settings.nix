{ lib, specialArgs, ... }:
let
  systemType = specialArgs.systemType or "default";

  systemConfig =
    if systemType == "main" then [ ./home-bars/main.nix ./home-bars/left.nix ./home-bars/right.nix ]
    else if systemType == "work" then [ ./work-pc.nix ]
    else [ ./home-bars/main.nix ./home-bars/left.nix ./home-bars/right.nix ];

in
{
  imports = systemConfig ++ [ ../rofi ./common.nix ];

  assertions = [{
    assertion = systemType == "main" || systemType == "work";
    message = "waybar/settings.nix: unrecognized systemType '${systemType}'";
  }];
}
