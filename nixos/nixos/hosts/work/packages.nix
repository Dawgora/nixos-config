{ pkgs, ... }:
{
  home.packages = with pkgs; [
    google-chrome
    xss-lock
    tigervnc
    udisks
  ];
}
