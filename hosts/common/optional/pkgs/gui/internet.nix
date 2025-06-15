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
    ];

    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
