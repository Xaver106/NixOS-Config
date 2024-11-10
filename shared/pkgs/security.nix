{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.security;
in {
  options.shared.pkgs.security = {
    enable = mkEnableOption "Security packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Encryption Tools
      veracrypt             # Disk encryption

      # Certificate Management
      gnupg                 # GNU Privacy Guard
      gpgme                # GnuPG Made Easy
      gpg-tui             # Terminal UI for GnuPG
    ];

    programs.gnupg.agent.enable = true;

  };
}
