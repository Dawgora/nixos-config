{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
#  options.dc-tec.graphical.hyprland = {
#    enable = lib.mkEnableOption "hyprlandwm";
#  };

  config = lib.mkIf config.dc-tec.graphical.hyprland.enable {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    home.packages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
    ];

    services = {
      cliphist = {
        enable = true;
      };
    };

      ## Took some stuff from the end4 dots config @ https://github.com/end-4/dots-hyprland/blob/main/.config/hypr/hyprland/general.conf
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland = {
          enable = true;
        };

        package = inputs.hyprland.packages.${pkgs.system}.hyprland;

        settings = {
          "$terminal" = "alacritty";
          "$fileManager" = "thunar";
          "$menu" = "wofi --show drun";
          "$mod" = "SUPER";

          monitor = [
            "HDMI-A-2, 1920x1080@60, 0x0, 1, transform, 1"
            "HDMI-A-1, 1920x1080@60, 3640x0, 1, transform, 1"
            "DP-2, 2560x1440@120, 1080x0, 1"
          ];

          xwayland = {
            force_zero_scaling = true;
          };

          general = {
            gaps_in = 3;
            gaps_out = 4;
            border_size = 2;
            layout = "dwindle";
            allow_tearing = true; # false
            col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            col.inactive_border = "rgba(595959aa)";
          };

          input = {
            kb_layout = "lv";
            follow_mouse = true;
            touchpad = {
              natural_scroll = false;
            };
            sensitivity = 0;
          };

          decoration = {
            rounding = 2;
            active_opacity = 1.0;
            inactive_opacity = 1.0;

            blur = {
              enabled = true;
              xray = true;
              special = false;
              new_optimizations = true;
              size = 5;
              passes = 4;
              brightness = 1;
              noise = 0.01;
              contrast = 1;
              popups = true;
              popups_ignorealpha = 0.6;
              ignore_opacity = false;
            };

            drop_shadow = true;
            shadow_ignore_window = true;
            shadow_range = 20;
            shadow_offset = "0 2";
            shadow_render_power = 4;
          };

          animations = {
            enabled = true;
            bezier = [
              "linear, 0, 0, 1, 1"
              "md3_standard, 0.2, 0, 0, 1"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshot, 0.05, 0.9, 0.1, 1.1"
              "crazyshot, 0.1, 1.5, 0.76, 0.92"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "menu_decel, 0.1, 1, 0, 1"
              "menu_accel, 0.38, 0.04, 1, 0.07"
              "easeInOutCirc, 0.85, 0, 0.15, 1"
              "easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutExpo, 0.16, 1, 0.3, 1"
              "softAcDecel, 0.26, 0.26, 0.15, 1"
              "md2, 0.4, 0, 0.2, 1"
            ];
            animation = [
              "windows, 1, 3, md3_decel, popin 60%"
              "windowsIn, 1, 3, md3_decel, popin 60%"
              "windowsOut, 1, 3, md3_accel, popin 60%"
              "border, 1, 10, default"
              "fade, 1, 3, md3_decel"
              "layersIn, 1, 3, menu_decel, slide"
              "layersOut, 1, 1.6, menu_accel"
              "fadeLayersIn, 1, 2, menu_decel"
              "fadeLayersOut, 1, 4.5, menu_accel"
              "workspaces, 1, 7, menu_decel, slide"
              "specialWorkspace, 1, 3, md3_decel, slidevert"
            ];
          };

          cursor = {
            enable_hyprcursor = true;
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
            no_gaps_when_only = 0;
            smart_split = false;
            smart_resizing = false;
          };

          misc = {
            disable_hyprland_logo = false;
            force_default_wallpaper = -1;
            disable_splash_rendering = true;
          };

          bind = [
            # General
            "$mod, return, exec, $terminal"
            "$mod, D, exec, rofi -show drun -show-icon"
            "$, print, exec, hyprshot -m region"
            "$mod, X, exec, wlogout"
            "$mod SHIFT, q, killactive"
            "$mod SHIFT, c, killactive"
            "$mod, E, exec, $fileManager"
            "$mod SHIFT, e, exit"
            "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"

            # Screen focus
            "$mod, v, togglefloating"
            "$mod, u, focusurgentorlast"
            "$mod, tab, focuscurrentorlast"
            "$mod, f, fullscreen"

            # Screen resize
            "$mod CTRL, h, resizeactive, -20 0"
            "$mod CTRL, l, resizeactive, 20 0"
            "$mod CTRL, k, resizeactive, 0 -20"
            "$mod CTRL, j, resizeactive, 0 20"

            # Workspaces
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"

            # Move to workspaces
            "$mod SHIFT, 1, movetoworkspace,1"
            "$mod SHIFT, 2, movetoworkspace,2"
            "$mod SHIFT, 3, movetoworkspace,3"
            "$mod SHIFT, 4, movetoworkspace,4"
            "$mod SHIFT, 5, movetoworkspace,5"
            "$mod SHIFT, 6, movetoworkspace,6"
            "$mod SHIFT, 7, movetoworkspace,7"
            "$mod SHIFT, 8, movetoworkspace,8"
            "$mod SHIFT, 9, movetoworkspace,9"
            "$mod SHIFT, 0, movetoworkspace,10"

            # Navigation
            "$mod, h, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"

            # Applications
            "$mod, S, togglespecialworkspace, magic"
            "$mod SHIFT, S, movetoworkspace, special:magic"
            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"
          ];

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];

          env = [
            "NIXOS_OZONE_WL,1"
            "_JAVA_AWT_WM_NONREPARENTING,1"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "QT_QPA_PLATFORM,wayland"
            "SDL_VIDEODRIVER,wayland"
            "GDK_BACKEND,wayland"
            "LIBVA_DRIVER_NAME,nvidia"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "GBM_BACKEND,nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "HYPRCURSOR_THEME,rose-pine-cursor"
            "XCURSOR_THEME,rose-pine-cursor"
          ];
          exec-once = [
            "bash ~./config/hypr/start.sh"
            "bash ~./config/hypr/sleep.sh"
            "sway-audio-idle-inhibit"
          ];
        };
        systemd = {
          enable = true;
        };
      };
    };
  }
