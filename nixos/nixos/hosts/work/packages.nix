{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xss-lock
    tigervnc
    udisks
  ];
}
