{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.pkgs.gui.security;
in
{
  options.common.optional.pkgs.gui.security = {
    enable = mkEnableOption "Security GUI packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Encryption Tools
      stable.cryptomator # Cloud storage encryption
      veracrypt # Disk encryption
      picocrypt # Simple file encryption

      # Certificate Management
      kdePackages.kleopatra # Certificate manager
    ];

    programs._1password-gui.enable = true;

  };
}
