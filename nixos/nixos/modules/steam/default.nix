{pkgs, ...}: {

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      extraPackages = [pkgs.mangohud];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    gamemode.enable = true;
  };

  environment.systemPackages = [pkgs.mangohud];

  users.users.dawgora.extraGroups = ["gamemode"];
}
