{ pkgs, lib, ... }:
let
  myPlex = pkgs.plex.overrideAttrs (_: rec {
    version = "1.25.2.5319-c43dc0277";
    src = pkgs.fetchurl {
      url = "https://downloads.plex.tv/plex-media-server-new/${version}/redhat/plexmediaserver-${version}.x86_64.rpm";
      sha256 = "sha256:1x4ph6m519y0xj2x153b4svqqsnrvhq9n2cxjl50b9h8dny2v0is";
    };
  });
in
{
  services.plex = {
    enable = true;
    openFirewall = true;
    package = myPlex;
  };
}
