{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.internet;
in
{
  options.common.optional.pkgs.gui.internet = {
    enable = mkEnableOption "Internet packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tor-browser # Privacy-focused browser

      # File Transfer & Sync
      filezilla # FTP/SFTP client
      localsend # Local network file sharing (AirDrop alternative)
      nextcloud-client # Nextcloud sync client
      rymdport # Easy encrypted file, folder, and text sharing between devices
      warp # Fast and secure file transfer

      # Remote Desktop
      rustdesk # Virtual / remote desktop infrastructure for everyone! Open source TeamViewer / Citrix alternative
    ];

    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
