{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.security;
in {
  options.shared.pkgs.gui.security = {
    enable = mkEnableOption "Security packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Encryption Tools
      cryptomator            # Cloud storage encryption
      veracrypt             # Disk encryption
      picocrypt             # Simple file encryption

      # Certificate Management
      gnupg                 # GNU Privacy Guard
      gpgme                # GnuPG Made Easy
      gpg-tui             # Terminal UI for GnuPG
      kdePackages.kleopatra # Certificate manager
    ];

    programs.gnupg.agent.enable = true;

  };
}
