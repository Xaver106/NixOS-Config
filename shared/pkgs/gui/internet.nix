{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.shared.pkgs.gui.internet;
in {
  options.shared.pkgs.gui.internet = {
    enable = mkEnableOption "Internet packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tor-browser        # Privacy-focused browser

      # File Transfer & Sync
      filezilla          # FTP/SFTP client
      localsend          # Local network file sharing (AirDrop alternative)
      nextcloud-client   # Nextcloud sync client
    ];
  };
}
