{ lib, config, specialArgs, ... }:
let
  systemType = specialArgs.systemType or "default";

  systemConfig = if systemType == "home" then [ ./home.nix ]
  else if systemType == "work-pc" then [ ./work-pc.nix ]
  else [];
in
{
    imports = systemConfig;
}
