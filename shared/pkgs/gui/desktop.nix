{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.desktop;
in {
  options.shared.pkgs.gui.desktop = {
    enable = mkEnableOption "Desktop environment packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Terminal Emulators
      kitty                    # GPU-accelerated terminal emulator

      # Disk Management
      gparted                  # Partition manager
      kdePackages.filelight    # Disk usage analyzer
      kdiskmark                # Disk benchmarking tool

      # Desktop Integration
      desktop-file-utils       # Command line utilities for desktop entries
    ];
  };
}
