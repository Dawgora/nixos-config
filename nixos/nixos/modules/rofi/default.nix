{ lib, config, specialArgs, ... }:
let
  systemType = specialArgs.systemType or "default";
  rofiConfig = if systemType == "main" || systemType == "work" then [ ./home.nix ]
               else [];
in
{
  imports = rofiConfig;
}
