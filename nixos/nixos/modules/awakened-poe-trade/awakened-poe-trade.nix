{
  lib,
  appimageTools,
  fetchurl,
  pkgs
}:

let
  version = "3.26.101";
  pname = "AwakenedPoeTrade";

  src = fetchurl {
    url = "https://github.com/SnosMe/awakened-poe-trade/releases/download/v${version}/Awakened-PoE-Trade-${version}.AppImage";
    hash = "sha256-n7xweAHNYQSDQMxZpHEf60PZk62ydwMsW9a7k3QeU1E=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
  appimageTools.wrapType2 rec {
    inherit pname version src;

    meta = {
      homepage = "https://github.com/SnosMe/awakened-poe-trade";
      description = "Path of Exile trading app for price checking";
      platforms = [ "x86_64-linux" ];
    };

    desktopItem = pkgs.makeDesktopItem {
      name = "AwakenedPoETrade";
      exec = appimageContents.pname;
      icon = "awakened-poe-trade";
      desktopName = "Awakened PoE Trade";
      comment = appimageContents.meta.description;
    };
  }
