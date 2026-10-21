{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nemo-with-extensions  # nemo + nemo-fileroller, nemo-python, emblems (Mint defaults)
    file-roller           # archive backend for nemo-fileroller, and the archive default app
    ffmpegthumbnailer     # video thumbnails
    glycin-thumbnailer    # image thumbnails (what GNOME uses now)
  ];

  # Rofi: show as "Files (Nemo)", also matches "file manager".
  # Same desktop ID as Nemo's own entry, so it overrides it.
  xdg.dataFile."applications/nemo.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Files (Nemo)
    GenericName=File Manager
    Comment=Browse files and folders
    Exec=nemo %U
    Icon=system-file-manager
    Terminal=false
    Keywords=files;file manager;folders;filesystem;explorer;nemo;
    Categories=GTK;Utility;Core;FileManager;
    MimeType=inode/directory;application/x-gnome-saved-search;
  '';

  # Nemo's "Open in Terminal" reads the Cinnamon terminal setting
  dconf.settings."org/cinnamon/desktop/default-applications/terminal" = {
    exec = "alacritty";
    exec-arg = "-e";
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";  # `y` opens yazi; quitting cd's into the last dir
  };
}
