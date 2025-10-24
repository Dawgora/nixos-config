{ pkgs, config, lib, cfg, ... }:
let
  awakened-poe-trade = pkgs.callPackage ./awakened-poe-trade.nix { };
in rec {
  home.packages = [
    awakened-poe-trade
  ];

}
