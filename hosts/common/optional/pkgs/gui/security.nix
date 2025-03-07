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

    # Manually add Librewolf to the supported browsers for 1Password
    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          librewolf
        '';
        mode = "0755";
      };
    };


  };
}
