{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    mousepad
    obsidian
    signal-desktop
    telegram-desktop
    discord
    bitwarden-desktop
    bitwarden-menu
    remmina
    libreoffice-qt-stable
    dbeaver-bin
    zed-editor
    proton-vpn
    # system tools
    fastfetch
    btop
    tree
    jq
    p7zip
    unzip
    tig
    gnome-tweaks
    wlogout
    wlr-randr
    arandr
    shikane
    networkmanagerapplet
    overskride
    yubikey-personalization
    yubioath-flutter
  ];
}
