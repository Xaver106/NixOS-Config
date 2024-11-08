{config, pkgs, lib, ...}:
with lib;

let cfg = config.shared.plasma;
in {

  options.shared.plasma = {
    enable = mkEnableOption "KDE Plasma and SDDM";
  };

  config = mkIf cfg.enable {

    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "breeze"; # set login theme
        autoNumlock = true; # enable numLock on login
        settings = {
          Theme.CursorTheme = "breeze_cursors"; # set cursor theme
        };
      };
    };

    services.desktopManager.plasma6.enable = true; # Enable KDE Plasma 6

    programs.dconf.enable = true; # Correct KDE Theme on Wayland

    environment.systemPackages = with pkgs; [
    wl-clipboard # Command-line copy/paste utilities for Wayland
    xclip         # X11 clipboard
    ];

  };
}
