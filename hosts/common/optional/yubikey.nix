{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.common.optional.yubikey;
in
{

  options.common.optional.yubikey = {
    enable = mkEnableOption "yubikey support";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      yubikey-manager # Yubikey Manager CLI
      opensc # Set of libraries and utilities to access smart cards
      yubioath-flutter # Yubikey Authenticator DEPEND: pcscd
      gnome-screenshot # Scan QR code for Yubikey Authenticator
    ];

    services.pcscd.enable = true; # Smartcard Deamon

    services.udev.packages = [
      pkgs.yubikey-manager
      pkgs.yubikey-personalization
    ];
  };
}
