{ lib, config, specialArgs, ... }:
let
  systemType = specialArgs.systemType or "default";
  rofiConfig = if systemType == "main" then [ ./home.nix ]
               else if systemType == "work" then [ ./work.nix ]
               else [];
in
{
  imports = rofiConfig;
}
